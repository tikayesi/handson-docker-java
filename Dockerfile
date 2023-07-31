## Ambil image dari OpenJDK 11 (bisa disesuaikan dengan versi Java yang digunakan)
#FROM openjdk:11-jre-slim
#
## Buat direktori untuk aplikasi
#WORKDIR /app
#
## Salin file JAR aplikasi dari direktori target (pastikan aplikasi sudah dibuild sebelumnya)
#COPY target/simple-todo-0.0.1-SNAPSHOT.jar /app/simple-todo-0.0.1-SNAPSHOT.jar
#
## Eksekusi perintah ketika container berjalan
#CMD ["java", "-jar", "simple-todo-0.0.1-SNAPSHOT.jar"]


# Tahap 1: Build aplikasi Spring Boot
FROM maven:3.8.3-jdk-11 AS build

# Buat direktori untuk aplikasi
WORKDIR /app

# Salin file pom.xml terlebih dahulu agar dependensi dapat di-cache
COPY pom.xml .

# Unduh dan cache dependensi aplikasi
RUN mvn dependency:go-offline -B

# Salin kode aplikasi
COPY src ./src

# Build aplikasi dengan Maven
RUN mvn package -DskipTests

# Tahap 2: Buat image runtime dengan JRE slim
FROM openjdk:11-jre-slim

# Buat direktori untuk aplikasi
WORKDIR /app

# Salin file JAR aplikasi dari tahap build sebelumnya ke dalam image runtime
COPY --from=build /app/target/simple-todo-0.0.1-SNAPSHOT.jar /app/simple-todo-0.0.1-SNAPSHOT.jar

# Eksekusi perintah ketika container berjalan
CMD ["java", "-jar", "/app/simple-todo-0.0.1-SNAPSHOT.jarr"]
