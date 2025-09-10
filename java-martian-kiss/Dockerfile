FROM eclipse-temurin:21-jdk
WORKDIR /app
COPY java-martian-kiss/Main.java /app/Main.java
RUN javac Main.java
ENTRYPOINT ["java","Main"]
