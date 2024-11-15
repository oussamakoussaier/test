# Stage 1: Build the app
FROM alpine:3.20.3 AS build
WORKDIR /app
COPY . .
RUN mvn install

# Stage 2: Run the app with OpenJDK
FROM openjdk:11.0
WORKDIR /app
COPY --from=build /app/target/tp-foyer-5.0.0.jar /app/
EXPOSE 9090
CMD ["java", "-jar", "tp-foyer-5.0.0.jar"]

# Stage 3: Set up a user in a clean Alpine image
FROM alpine:3.20.3

# Install shadow package for useradd
RUN apk add --no-cache shadow

# Add a user using useradd
RUN useradd -m appuser
USER appuser

# Set label with correct formatting
LABEL foo="bar baz"

# Switch to another user 'me'
USER me

# Set healthcheck to monitor the app
HEALTHCHECK CMD curl --fail http://localhost:3000 || exit 1
