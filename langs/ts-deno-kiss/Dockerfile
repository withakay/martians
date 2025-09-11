FROM denoland/deno:debian
WORKDIR /app
COPY langs/ts-deno-kiss/main.ts /app/main.ts
ENTRYPOINT ["deno","run","-q","/app/main.ts"]
