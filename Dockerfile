# Use the official Tomcat 11.0.5 image
FROM tomcat:11.0.5-jdk17

# Set the working directory
WORKDIR /usr/local/tomcat/webapps

# Remove the default ROOT web application
RUN rm -rf ROOT

# Copy your WAR file and rename it to ROOT.war
COPY target/bumbleb-1.0-SNAPSHOT.war ROOT.war

# Expose the port Tomcat runs on
EXPOSE 8080

# Start Tomcat
CMD ["catalina.sh", "run"]
