FROM openjdk:21
COPY target/RV_SpringBoot.jar /usr/app/RV_SpringBoot.jar
WORKDIR /usr/app/
EXPOSE 8080
ENTRYPOINT ["java", "-jar", "RV_SpringBoot.jar"]
