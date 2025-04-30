FROM eclipse-temurin:21

# Mule installation
ENV MULE_VERSION=4.9.3

# Add mule runtime in Docker Container
ENV MULE_HOME=/opt/mule

#Add mule runtime in Docker Container
ADD mule-ee-distribution-standalone-4.9.3.zip /opt

#ADD test-muleapp.jar /opt
RUN apt-get update && apt-get install -y unzip
RUN set -x \
                && cd /opt \
                && unzip mule-ee-distribution-standalone-4.9.3.zip \
                && mv mule-enterprise-standalone-4.9.3 mule \
                && $MULE_HOME/bin/mule -installLicense $MULE_HOME/conf/$LICENSE_FILE

WORKDIR $MULE_HOME

# Define mount points
# VOLUME ["/opt/mule/.mule"]

VOLUME $MULE_HOME/apps
VOLUME $MULE_HOME/conf
VOLUME $MULE_HOME/domains
VOLUME $MULE_HOME/logs

#Copy and install License
# CMD echo "-----Copy and install License-----"
# COPY muleLicenseKey.lic $MULE_HOME/conf/
# RUN $MULE_HOME/bin/mule -installLicense $ MULE_HOME/conf/muleLicenseKey.lic

# Check if Mule license is installed
RUN ls -ltr $MULE_HOME/conf/
CMD echo "-----License installed!-----"

# Copy and deploy mule application in runtime
# CMD echo "-----Deploying mule application in runtime!-----"
# COPY test-muleapp.jar $MULE_HOME/apps
# RUN ls -ltr $MULE_HOME/apps

# HTTP service port
# Expose the necessary port ranges as required by the Mule Apps
EXPOSE 8082-8091
EXPOSE 9000
EXPOSE 9082

# Configure external access
# HTTPS Port for Anypoint Platform Communication
EXPOSE 443
# Mule remote debugger
EXPOSE 5000
# Mule JMX port (must match Mule config file)
EXPOSE 1098
# Mule MMC agent port
EXPOSE 7777
# AMC agent port
EXPOSE 9997

# Mule Cluster ports
EXPOSE 5701
EXPOSE 54327
# HTTP Service port
# EXPOSE 8081
# EXPOSE 8091

# Start Mule runtime
CMD echo "-----Start Mule runtime!-----"
ENTRYPOINT [ "./bin/mule" ]

# Environment and execution:
# CMD ["/opt/mule/bin/mule", "-M-DMule.agent.enabled=false"]