FROM openjdk:11 as base

WORKDIR /app

COPY .mvn/ .mvn
COPY mvnw pom.xml ./
RUN ./mvnw dependency:go-offline

COPY src ./src

FROM base as build
RUN ./mvnw package

FROM amazoncorretto:11 as production
EXPOSE 5000

COPY --from=build /app/target/*.jar /app.jar

CMD ["java", "-Djava.security.egd=file:/dev/./urandom", "-jar", "/app.jar"]
