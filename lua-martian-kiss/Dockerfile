FROM alpine:3.19
WORKDIR /app
RUN apk add --no-cache lua5.4
COPY lua-martian-kiss/main.lua /app/main.lua
ENTRYPOINT ["lua5.4","/app/main.lua"]
