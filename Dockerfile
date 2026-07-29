# Fase 1: Compilación
FROM maven:3.9.9-eclipse-temurin-21 AS build
WORKDIR /app
COPY pom.xml .
RUN mvn dependency:go-offline -B
COPY src ./src
RUN mvn clean package -DskipTests

# Fase 2: Ejecución
FROM eclipse-temurin:21-jre
WORKDIR /app
COPY --from=build /app/target/prueba-0.0.1-SNAPSHOT.jar app.jar
EXPOSE 8080

# En Cloud Run arrancará directo usando el archivo base e inyectando el puerto de Google
ENTRYPOINT ["java", "-Dserver.port=${PORT:8080}", "-jar", "app.jar"]
