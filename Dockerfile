FROM maven:3.8.1-openjdk-11-slim as build
WORKDIR /app
COPY  . .
RUN mvn install

FROM openjdk:11.0
WORKDIR /app
COPY --from=build /app/target/tp-foyer-5.0.0.jar /app/
EXPOSE 9090
CMD ["java", "-jar","tp-foyer-5.0.0.jar"]
