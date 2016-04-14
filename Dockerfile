FROM centos6-ml
MAINTAINER Andrew Jacobs <andrew.jacobs@marklogic.com>

RUN yum update -y

RUN yum install -y nodejs

# ENV JAVA_VERSION 1.8.0
# # Install JDK
# RUN yum install -y java-${JAVA_VERSION}-openjdk-devel
# ENV JAVA_HOME /usr/lib/jvm/java-openjdk
# RUN touch /etc/profile.d/java.sh && \
#     echo '#!/bin/bash' >> /etc/profile.d/java.sh && \
#     echo 'JAVA_HOME=/usr/lib/jvm/java-openjdk/' >> /etc/profile.d/java.sh && \
#     echo 'PATH=$JAVA_HOME/bin:$PATH' >> /etc/profile.d/java.sh && \
#     echo 'export PATH JAVA_HOME' >> /etc/profile.d/java.sh && \
#     chmod +x /etc/profile.d/java.sh && \
#     source /etc/profile.d/java.sh

# Install Git
RUN yum install -y git

# RUN mkdir /opt/samplestack
WORKDIR /home
RUN git clone https://github.com/ryanjdew/ml-slush-discovery-app.git

# RUN /etc/rc.d/init.d/MarkLogic start && sleep 5
# RUN ifconfig
# RUN curl 127.0.0.1:8001 -v

WORKDIR /home/ml-slush-discovery-app/
RUN ./ml local bootstrap
RUN ./ml local delpoy modules
RUN npm install bower && npm install gulp && npm install && bower install
RUN gulp init-local
RUN npm install --save www-authenticate
 # seedDataFetch && ./gradlew seedDataExtract

WORKDIR /
# Expose MarkLogic admin
EXPOSE 8000 8001 8002 8040 3000 9070
# Run Supervisor
CMD ["/usr/bin/supervisord", "-c", "/etc/supervisord.conf"] 



# docker run --name ml-slush -d -p 8000:8000 -p 8001:8001 -p 3000:3000 -p 8040:8040 -p 9070:9070 centos-ml8-ml-slush-discovery
# docker exec ml-slush bash -c "cd /home/ml-slush-discovery-app/ && gulp serve-local"


# docker run --name java-samplestack -d -p 8000:8000 -p 8001:8001 -p 8002:8002 -p 8006:8006 -p 8090:8090 centos6-ml8-java-samplestack
# Bootstrap and start Samplestack:
# docker exec java-samplestack bash -c "cd /home/marklogic-samplestack/appserver/java-spring && ./gradlew dbInit && ./gradlew appserver"
