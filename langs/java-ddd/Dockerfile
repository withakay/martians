FROM eclipse-temurin:21-jdk
WORKDIR /app
COPY langs/java-ddd/src /app/src
RUN javac $(find /app/src -name "*.java") -d /app/out
WORKDIR /app/out
ENTRYPOINT ["java","Main"]

