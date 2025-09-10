FROM eclipse-temurin:21-jdk
WORKDIR /app
COPY java-martian-ddd/src /app/src
RUN javac $(find /app/src -name "*.java") -d /app/out
WORKDIR /app/out
ENTRYPOINT ["java","Main"]

