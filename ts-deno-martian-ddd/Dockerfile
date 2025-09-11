FROM denoland/deno:debian
WORKDIR /app
COPY ts-deno-martian-ddd/src /app/src
ENTRYPOINT ["deno","run","-q","/app/src/cli.ts"]

