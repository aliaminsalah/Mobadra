FROM ubuntu:latest AS build

ENV DEBIAN_FRONTEND=noninteractive

RUN apt-get update && \
    apt-get install -y openjdk-17-jdk git maven curl && \
    apt-get clean && \
    rm -rf /var/lib/apt/lists/*

WORKDIR /app

COPY . .

# Run the Maven build and ensure the target directory exists
RUN ./mvnw package && \
    ls /app/target/spring-petclinic-*.jar

FROM openjdk:17-jdk-slim

ENV JAVA_OPTS=""
WORKDIR /app
COPY --from=build /app/target/spring-petclinic-*.jar /app/spring-petclinic.jar
EXPOSE 8081
CMD ["java", "-jar", "/app/spring-petclinic.jar"]
