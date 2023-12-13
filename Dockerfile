FROM maven as build
WORKDIR /app
COPY . .
RUN mvn install

FROM openjdk
WORKDIR /app
COPY --from=build /app/target/vprofile-v2.war /app/
EXPOSE 9090
CMD ["java","-war","vprofile-v2.war"]
