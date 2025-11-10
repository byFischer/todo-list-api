# 1. Aşama: Uygulamayı Derleme
# Projeyi derlemek için bir Maven (Java) imajı kullan
FROM maven:3.8.5-openjdk-17 AS build

# Çalışma dizini oluştur
WORKDIR /app

# Önce pom.xml'i kopyala ve bağımlılıkları indir
COPY pom.xml .
RUN mvn dependency:go-offline

# Kaynak kodu kopyala ve uygulamayı derle
COPY src ./src
RUN mvn package -DskipTests

# 2. Aşama: Çalıştırma İmajı
# Sadece Java'nın çalışması için gereken küçük imajı kullan
FROM openjdk:17-slim

# Çalışma dizini
WORKDIR /app

# 1. aşamada derlenen .jar dosyasını kopyala
# !!! AŞAĞIDAKİ SATIRI KONTROL ET !!!
COPY --from=build /app/target/todo-backend-0.0.1-SNAPSHOT.jar app.jar

# Render'ın verdiği portu kullan (veya varsayılan 8080)
ENTRYPOINT ["java", "-Dserver.port=${PORT:8080}", "-jar", "app.jar"]