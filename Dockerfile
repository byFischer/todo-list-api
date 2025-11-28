
FROM maven:3.8.5-openjdk-17 AS build
WORKDIR /app
COPY pom.xml .
RUN mvn dependency:go-offline
COPY src ./src
RUN mvn package -DskipTests


FROM eclipse-temurin:17-jre-alpine


WORKDIR /app


COPY --from=build /app/target/todo-backend-0.0.1-SNAPSHOT.jar app.jar


ENTRYPOINT ["java", "-Dserver.port=${PORT:8080}", "-jar", "app.jar"]
