FROM amazoncorretto:11 as build
WORKDIR /workspace/app

COPY mvnw .
COPY .mvn .mvn
COPY pom.xml .
COPY src src
RUN --mount=type=cache,target=/root/.m2 ./mvnw install -DskipTests

ARG JAR_FILE=target/*.jar
COPY ${JAR_FILE} target/app.jar

FROM amazoncorretto:11
ENTRYPOINT ["java", "-jar", "/app.jar"]