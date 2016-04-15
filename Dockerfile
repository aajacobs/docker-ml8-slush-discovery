FROM centos6-ml
MAINTAINER Andrew Jacobs <andrew.jacobs@marklogic.com>

RUN yum update -y

RUN curl --silent --location https://rpm.nodesource.com/setup | bash -
RUN yum install -y nodejs

# Install Git
RUN yum -y install git
RUN yum -y install ruby
RUN ruby -v
RUN which ruby

WORKDIR /home
RUN git clone https://github.com/ryanjdew/ml-slush-discovery-app.git

# RUN /etc/rc.d/init.d/MarkLogic start && sleep 5
# RUN ifconfig
# RUN curl 127.0.0.1:8001 -v

WORKDIR /home/ml-slush-discovery-app/
RUN ./ml local bootstrap
RUN ./ml local deploy modules
RUN npm install bower && npm install gulp && npm install && bower install
RUN gulp init-local

WORKDIR /
# Expose MarkLogic admin
EXPOSE 8000 8001 8002 8040 3000 9070
# Run Supervisor
CMD ["/usr/bin/supervisord", "-c", "/etc/supervisord.conf"] 



# docker run --name ml-slush -d -p 8000:8000 -p 8001:8001 -p 3000:3000 -p 8040:8040 -p 9070:9070 centos-ml8-ml-slush-discovery
# docker exec ml-slush bash -c "cd /home/ml-slush-discovery-app/ && gulp serve-local"
