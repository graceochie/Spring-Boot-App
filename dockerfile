# Stage 1: Build the application
FROM maven:3.8.5-openjdk-17 AS builder
WORKDIR /app

# Copy the pom.xml and download dependencies
COPY pom.xml .
# RUN mvn dependency:go-offline

# Copy the source code and build the application
COPY . .
RUN mvn clean install -DskipTests


# Stage 2: Run the application
FROM openjdk:17-jdk-slim
WORKDIR /app

# # Copy the built JAR file from the builder stage
COPY --from=builder /app/target/*.jar app.jar


# Expose the port the application runs on
EXPOSE 8080

# Run the application
ENTRYPOINT ["java", "-jar", "app.jar"]