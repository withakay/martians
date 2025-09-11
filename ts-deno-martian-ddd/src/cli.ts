import { runMission } from "./app.ts";

const input = await new Response(Deno.stdin.readable).text();
await Deno.stdout.write(new TextEncoder().encode(runMission(input)));
