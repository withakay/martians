FROM alpine:3.19
WORKDIR /app
COPY awk-martian-kiss/main.sh /app/main.sh
RUN chmod +x /app/main.sh
ENTRYPOINT ["/bin/sh","/app/main.sh"]
