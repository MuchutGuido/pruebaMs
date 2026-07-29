# 1. Usamos una imagen que tenga Maven y Java 26 para compilar en la nube
FROM maven:3.9-eclipse-temurin-26 AS build
WORKDIR /app

# 2. Copiamos el código de IntelliJ al contenedor de Google
COPY pom.xml .
COPY src ./src

# 3. Compilamos y generamos el .jar dentro de Google Cloud
RUN mvn clean package -DskipTests

# 4. Le decimos al contenedor cómo arrancar la aplicación
# (Buscamos dinámicamente cualquier jar en 'target' para evitar escribir el nombre exacto)
ENTRYPOINT ["sh", "-c", "java -jar target/*.jar"]
