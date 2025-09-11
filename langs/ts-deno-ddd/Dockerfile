FROM denoland/deno:debian
WORKDIR /app
COPY langs/ts-deno-ddd/src /app/src
ENTRYPOINT ["deno","run","-q","/app/src/cli.ts"]

