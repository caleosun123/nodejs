# Use the official Tomcat image as a base
FROM tomcat:9.0-jdk11

# Set the working directory
WORKDIR /usr/local/tomcat/webapps

# Remove the default ROOT web application
RUN rm -rf ROOT

# Copy the WAR file into the webapps directory
COPY # Use the official Tomcat image as a base
FROM tomcat:9.0

# Set the working directory
WORKDIR /usr/local/tomcat/webapps

# Remove the default ROOT web application
RUN rm -rf ROOT

# Copy the WAR file into the webapps directory
COPY target/bumbleb-1.0-SNAPSHOT.war ROOT.war

# Expose the port Tomcat runs on
EXPOSE 8080

# Start Tomcat
CMD ["catalina.sh", "run"] ROOT.war

# Expose the port Tomcat runs on
EXPOSE 8080

# Start Tomcat
CMD ["catalina.sh", "run"]
