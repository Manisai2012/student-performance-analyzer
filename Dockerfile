# Multi-stage Docker build for Student Performance Analyzer Spring Boot Backend

# Stage 1: Build with Maven and JDK 17
FROM maven:3.9.6-eclipse-temurin-17-alpine AS build
WORKDIR /app

# Copy pom and pre-fetch dependencies for fast cached builds
COPY backend/pom.xml .
RUN mvn dependency:go-offline -B

# Copy backend source code and package JAR
COPY backend/src ./src
RUN mvn clean package -DskipTests -B

# Stage 2: Lean production runtime with JRE 17
FROM eclipse-temurin:17-jre-alpine
WORKDIR /app

# Copy compiled JAR
COPY --from=build /app/target/*.jar app.jar

# Expose Spring Boot port
ENV PORT=8080
EXPOSE 8080

# Run application with dynamic PORT binding
ENTRYPOINT ["sh", "-c", "exec java -Dserver.port=${PORT:-8080} -Djava.security.egd=file:/dev/./urandom -jar app.jar"]
