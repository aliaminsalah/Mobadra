FROM ubuntu:latest

LABEL maintainer="Ali Amin <aliaminsalah2@gmail.com>"
LABEL description="Custom Docker image for Spring Petclinic application"

ENV DEBIAN_FRONTEND=noninteractive

RUN apt-get update && \
    apt-get install -y openjdk-17-jdk git maven curl && \
    apt-get clean

WORKDIR /app

RUN git clone https://github.com/dockersamples/spring-petclinic-docker.git

WORKDIR /app/spring-petclinic-docker

RUN ./mvnw package

# Copy wait-for-it script
#COPY wait-for-it.sh /usr/local/bin/

#RUN chmod +x /usr/local/bin/wait-for-it.sh

EXPOSE 8080

ENV APP_VERSION="1.0.0"

RUN echo "Running Spring Petclinic version $APP_VERSION"

#HEALTHCHECK --interval=20s --timeout=10s \
#  CMD curl -f http://localhost:8080 || exit 1

CMD ["java", "-jar", "target/spring-petclinic-2.7.0-SNAPSHOT.jar"]