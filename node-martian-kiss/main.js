#!/usr/bin/env node
const fs = require("fs");

const data = fs.readFileSync(0, "utf8");
if (!data.trim()) {
	console.error("No input provided");
	process.exit(1);
}

const dirs = ["N", "E", "S", "W"];
const step = { N: [0, 1], E: [1, 0], S: [0, -1], W: [-1, 0] };
function left(d) {
	return dirs[(dirs.indexOf(d) - 1 + 4) % 4];
}
function right(d) {
	return dirs[(dirs.indexOf(d) + 1) % 4];
}
function inside(x, y, MX, MY) {
	return 0 <= x && x <= MX && 0 <= y && y <= MY;
}

try {
	const lines = data
		.split(/\r?\n/)
		.map((s) => s.trim())
		.filter(Boolean);
	if (lines.length === 0) throw new Error("Empty input");
	const head = lines[0].split(/\s+/);
	if (head.length < 2) throw new Error("Invalid header");
	const MX = parseInt(head[0], 10),
		MY = parseInt(head[1], 10);
	const scents = new Set();
	const out = [];
	for (let i = 1; i + 1 < lines.length; i += 2) {
		const p = lines[i].split(/\s+/);
		let x = parseInt(p[0], 10),
			y = parseInt(p[1], 10),
			d = p[2];
		const instr = lines[i + 1];
		let lost = false;
		for (const c of instr) {
			if (lost) break;
			if (c === "L") d = left(d);
			else if (c === "R") d = right(d);
			else if (c === "F") {
				const [dx, dy] = step[d];
				const nx = x + dx,
					ny = y + dy;
				if (!inside(nx, ny, MX, MY)) {
					const key = `${x},${y},${d}`;
					if (scents.has(key)) continue;
					scents.add(key);
					lost = true;
				} else {
					x = nx;
					y = ny;
				}
			} else {
				// ignore unknown
			}
		}
		out.push(`${x} ${y} ${d}${lost ? " LOST" : ""}`);
	}
	process.stdout.write(out.join("\n") + "\n\n");
} catch (e) {
	console.error(e.message || String(e));
	process.exit(1);
}
