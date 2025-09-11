#!/usr/bin/env bash
set -euo pipefail

ROOT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"
GOLDENS_DIR="$ROOT_DIR/goldens" # legacy location for expected outputs
SAMPLES_DIR="$ROOT_DIR/samples"
OUT_DIR="$ROOT_DIR/.harness_out"

# Colors (enabled on TTY or in GitHub Actions)
if [[ -t 1 || -n "${GITHUB_ACTIONS:-}" ]]; then
  C_GREEN='\033[32m'; C_RED='\033[31m'; C_YELLOW='\033[33m'; C_BLUE='\033[34m'; C_DIM='\033[2m'; C_RESET='\033[0m'
else
  C_GREEN=''; C_RED=''; C_YELLOW=''; C_BLUE=''; C_DIM=''; C_RESET=''
fi

# Comma-separated list or space-separated list; defaults to auto-discovered
LANGS=${LANGS:-}
CONTINUE=${CONTINUE:-0}

inputs=()

build_inputs() {
  local pairs=()

  # Determine inputs/outputs roots (prefer new structure under samples/, fall back to legacy paths)
  local inputs_root outputs_root
  if [[ -d "$SAMPLES_DIR/inputs" ]]; then
    inputs_root="$SAMPLES_DIR/inputs"
  else
    inputs_root="$SAMPLES_DIR"
  fi
  if [[ -d "$SAMPLES_DIR/outputs" ]]; then
    outputs_root="$SAMPLES_DIR/outputs"
  else
    outputs_root="$GOLDENS_DIR"
  fi

  # Common pair for sample
  if [[ -f "$inputs_root/sample-input.txt" && -f "$outputs_root/sample-output.txt" ]]; then
    pairs+=("$inputs_root/sample-input.txt:$outputs_root/sample-output.txt")
  fi

  # Auto-discover <name>-input.txt => <name>-output.txt
  while IFS= read -r -d '' f; do
    local base name out
    base="$(basename "$f")"
    [[ "$base" == "sample-input.txt" ]] && continue
    name="${base%-input.txt}"
    out="$outputs_root/${name}-output.txt"
    if [[ -f "$out" ]]; then
      pairs+=("$f:$out")
    fi
  done < <(find "$inputs_root" -maxdepth 1 -type f -name "*-input.txt" -print0 | sort -z)
  inputs=("${pairs[@]}")
}

discover_langs() {
  # Implementations now live under langs/*
  (cd "$ROOT_DIR" && ls -1d langs/* 2>/dev/null || true)
}

langs_list() {
  if [[ -n "$LANGS" ]]; then
    # Allow comma- or space-separated; accept bare names or langs/* paths
    for item in $(echo "$LANGS" | tr ',' ' '); do
      if [[ -d "$ROOT_DIR/$item" ]]; then
        echo "$item"
      elif [[ -d "$ROOT_DIR/langs/$item" ]]; then
        echo "langs/$item"
      fi
    done
  else
    discover_langs
  fi
}

log() { printf "%b[harness]%b %s\n" "$C_DIM" "$C_RESET" "$*"; }

run_one_lang() {
  local lang_dir="$1"
  local overall="OK"

  local image_tag
  image_tag="$(basename "$lang_dir")"
  [[ -n "${GITHUB_ACTIONS:-}" ]] && echo "::group::Build $image_tag ($lang_dir)"
  log "Building docker image for $lang_dir"
  if ! docker build -f "$ROOT_DIR/$lang_dir/Dockerfile" -t "martian:$image_tag" "$ROOT_DIR"; then
    overall="BUILD_FAIL"
  fi
  [[ -n "${GITHUB_ACTIONS:-}" ]] && echo "::endgroup::"

  for pair in "${inputs[@]}"; do
    IFS=":" read -r in_file out_file <<<"$pair"
    log "Testing $lang_dir against $(basename "$in_file")"
    tmp_out="$(mktemp)"
    if ! docker run --rm -i "martian:$image_tag" < "$in_file" | sed -e 's/\r$//' > "$tmp_out"; then
      overall="RUNTIME_FAIL"; rm -f "$tmp_out"; break
    fi
    # Normalize actual: trim trailing blank lines, then ensure exactly one trailing newline
    tmp_norm="$(mktemp)"
    awk '{ a[NR]=$0 } END{ i=NR; while(i>=1 && a[i]=="") i--; for(j=1;j<=i;j++) print a[j]; print "" }' "$tmp_out" > "$tmp_norm"
    exp_norm="$(mktemp)"
    awk '{ a[NR]=$0 } END{ i=NR; while(i>=1 && a[i]=="") i--; for(j=1;j<=i;j++) print a[j]; print "" }' "$out_file" > "$exp_norm"
    if ! cmp -s "$tmp_norm" "$exp_norm"; then
      overall="MISMATCH"
      echo "--- expected"; cat "$exp_norm"; echo "--- actual"; cat "$tmp_norm"; echo "--- diff"; diff -u "$exp_norm" "$tmp_norm" || true
      # still store actual for cross-diff
      local base name outpath
      base="$(basename "$in_file")"; name="${base%-input.txt}"
      outpath="$OUT_DIR/$image_tag"; mkdir -p "$outpath"; cp "$tmp_norm" "$outpath/$name.out"
      rm -f "$tmp_out" "$tmp_norm" "$exp_norm"; break
    fi
    # store normalized output for cross-diff
    local base name outpath
    base="$(basename "$in_file")"; name="${base%-input.txt}"
    outpath="$OUT_DIR/$image_tag"; mkdir -p "$outpath"; cp "$tmp_norm" "$outpath/$name.out"
    rm -f "$tmp_out" "$tmp_norm" "$exp_norm"
  done

  case "$overall" in
    OK)
      printf "%b[OK]%b %s\n" "$C_GREEN" "$C_RESET" "$image_tag" ;;
    BUILD_FAIL)
      printf "%b[FAIL]%b %s (build)\n" "$C_RED" "$C_RESET" "$image_tag" ;;
    RUNTIME_FAIL)
      printf "%b[FAIL]%b %s (runtime)\n" "$C_RED" "$C_RESET" "$image_tag" ;;
    MISMATCH)
      printf "%b[FAIL]%b %s (mismatch)\n" "$C_RED" "$C_RESET" "$image_tag" ;;
  esac

  # expose result to caller
  RUN_OVERALL_RESULT="$overall"
  [[ "$overall" == "OK" ]]
}

main() {
  local failures=0
  local tested=0
  local -a results=()
  rm -rf "$OUT_DIR" && mkdir -p "$OUT_DIR"
  build_inputs
  for dir in $(langs_list); do
    [[ ! -d "$ROOT_DIR/$dir" ]] && continue
    if ! run_one_lang "$dir"; then failures=$((failures+1)); fi
    results+=("$dir|$RUN_OVERALL_RESULT")
    tested=$((tested+1))
  done
  log "Tested $tested implementations; failures: $failures"

  # GitHub step summary
  if [[ -n "${GITHUB_STEP_SUMMARY:-}" ]]; then
    {
      echo "## Martian Robots Test Summary"
      echo ""
      echo "- Implementations tested: $tested"
      echo "- Failures: $failures"
      echo ""
      echo "| Implementation | Result |"
      echo "|---|---|"
      for item in "${results[@]}"; do
        IFS='|' read -r name status <<<"$item"
        case "$status" in
          OK) echo "| \`$name\` | ✅ OK |" ;;
          BUILD_FAIL) echo "| \`$name\` | ❌ Build failed |" ;;
          RUNTIME_FAIL) echo "| \`$name\` | ❌ Runtime error |" ;;
          MISMATCH) echo "| \`$name\` | ❌ Output mismatch |" ;;
          *) echo "| \`$name\` | ❓ Unknown |" ;;
        esac
      done
      echo ""
      echo "Run locally: \`./tools/harness.sh\` or \`make test-all\`"
    } >> "$GITHUB_STEP_SUMMARY"
  fi

  # Cross-implementation diff
  local cross=0 cross_issues=0
  for pair in "${inputs[@]}"; do
    IFS=":" read -r in_file out_file <<<"$pair"
    local base name
    base="$(basename "$in_file")"; name="${base%-input.txt}"
    # choose first existing output as reference
    local ref="" ref_lang=""
    for d in $(langs_list); do
      if [[ -f "$OUT_DIR/$d/$name.out" ]]; then ref="$OUT_DIR/$d/$name.out"; ref_lang="$d"; break; fi
    done
    [[ -z "$ref" ]] && continue
    cross=$((cross+1))
    for d in $(langs_list); do
      [[ "$d" == "$ref_lang" ]] && continue
      if [[ -f "$OUT_DIR/$d/$name.out" ]]; then
        if ! cmp -s "$ref" "$OUT_DIR/$d/$name.out"; then
          cross_issues=$((cross_issues+1))
          echo "[DIFF] $name: $d differs from $ref_lang"
          diff -u "$ref" "$OUT_DIR/$d/$name.out" || true
        fi
      fi
    done
  done

  # Summarize cross-diff in GitHub
  if [[ -n "${GITHUB_STEP_SUMMARY:-}" ]]; then
    {
      echo "### Cross-implementation diffs"
      echo "- Inputs compared: $cross"
      echo "- Differences found: $cross_issues"
    } >> "$GITHUB_STEP_SUMMARY"
  fi

  if [[ "$CONTINUE" == "1" ]]; then
    [[ $failures -eq 0 ]]
  else
    # Fail fast behavior preserved when CONTINUE!=1
    [[ $failures -eq 0 ]]
  fi
}

main "$@"
