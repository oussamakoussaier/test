FROM alpine:latest as build
WORKDIR /app
COPY  . .
RUN mvn install

FROM openjdk:11.0
WORKDIR /app
COPY --from=build /app/target/tp-foyer-5.0.0.jar /app/
EXPOSE 9090
CMD ["java", "-jar","tp-foyer-5.0.0.jar"]

FROM base
RUN useradd -m appuser
USER appuser
LABEL foo="bar baz
USER  me
HEALTHCHECK CMD curl --fail http://localhost:3000 || exit 1",
