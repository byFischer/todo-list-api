# 1. Aşama: Uygulamayı Derleme
# Bu kısım doğruydu, DOKUNMA.
FROM maven:3.8.5-openjdk-17 AS build
WORKDIR /app
COPY pom.xml .
RUN mvn dependency:go-offline
COPY src ./src
RUN mvn package -DskipTests

# 2. Aşama: Çalıştırma İmajı
# Sadece Java'nın çalışması için gereken küçük imajı kullan
# !!!!!!!!!!!!! DEĞİŞİKLİK BURADA !!!!!!!!!!!!!
FROM eclipse-temurin:17-jre-alpine

# Çalışma dizini
WORKDIR /app

# 1. aşamada derlenen .jar dosyasını kopyala
COPY --from=build /app/target/todo-Backend-0.0.1-SNAPSHOT.jar app.jar

# Render'ın verdiği portu kullan
ENTRYPOINT ["java", "-Dserver.port=${PORT:8080}", "-jar", "app.jar"]