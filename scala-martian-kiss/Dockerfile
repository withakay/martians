FROM openjdk:17-slim
RUN apt-get update && \
    apt-get install -y wget ca-certificates && \
    wget -qO- https://github.com/scala/scala/releases/download/v2.13.12/scala-2.13.12.tgz | \
    tar xz -C /opt/ && \
    ln -s /opt/scala-2.13.12/bin/scala /usr/local/bin/scala && \
    apt-get clean && rm -rf /var/lib/apt/lists/*
WORKDIR /app
COPY scala-martian-kiss/Main.scala /app/Main.scala
ENTRYPOINT ["scala", "/app/Main.scala"]
