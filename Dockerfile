# Ambil image Maven yang mengandung JDK (bisa disesuaikan dengan versi Maven dan JDK yang digunakan)
FROM maven:3.8.3-jdk-11 AS build

# Definisikan argumen build untuk mengganti nilai properti aplikasi Spring Boot
ARG APP_PORT=8090
ARG HOST_DB=backend-db
ARG PORT_DB=5432
ARG DB_NAME=todo
ARG USERNAME_DB=tikayesikristiani

# Buat direktori untuk aplikasi
WORKDIR /app

# Salin file pom.xml terlebih dahulu agar dependensi dapat di-cache
COPY pom.xml .

# Unduh dan cache dependensi aplikasi
RUN mvn dependency:go-offline -B

# Salin kode aplikasi
COPY src ./src

# Build aplikasi dengan Maven dan tambahkan argumen untuk mengganti nilai properti
RUN mvn package -DskipTests \
    -DAPP_PORT=${APP_PORT} \
    -DHOST_DB=${HOST_DB} \
    -DPORT_DB=${PORT_DB} \
    -DDB_NAME=${DB_NAME} \
    -DUSERNAME_DB=${USERNAME_DB} \
    -DPASSWORD_DB=${PASSWORD_DB}

# Gunakan image OpenJDK 11 JRE slim untuk runtime
FROM openjdk:11-jre-slim

# Buat direktori untuk aplikasi
WORKDIR /app

# Salin file JAR aplikasi dari image build sebelumnya ke dalam image runtime
COPY --from=build /app/target/simple-todo-0.0.1-SNAPSHOT.jar /app/simple-todo-0.0.1-SNAPSHOT.jar

# Eksekusi perintah ketika container berjalan
CMD ["java", "-jar", "/app/simple-todo-0.0.1-SNAPSHOT.jar"]
