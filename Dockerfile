FROM maven:3.9-eclipse-temurin-21 AS build
WORKDIR /app
COPY pom.xml .
COPY src ./src
RUN mvn clean package -DskipTests
RUN ls -la /app/target/

FROM tomcat:11.0-jdk21
COPY --from=build /app/target/*.war /usr/local/tomcat/webapps/ROOT.war
RUN ls -la /usr/local/tomcat/webapps/
EXPOSE 8080
CMD ["catalina.sh", "run"]