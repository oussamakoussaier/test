FROM alpine:3.20.3
WORKDIR /app
COPY  . .
RUN mvn install

FROM openjdk:11.0
WORKDIR /app
COPY --from=build /app/target/tp-foyer-5.0.0.jar /app/
EXPOSE 9090
CMD ["java", "-jar","tp-foyer-5.0.0.jar"]

FROM alpine:3.20.3
RUN useradd -m appuser
USER appuser
LABEL foo="bar baz"
USER  me
HEALTHCHECK CMD curl --fail http://localhost:3000 || exit 1
