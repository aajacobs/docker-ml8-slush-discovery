# docker-ml8-java-samplestack
Dockerfile for MarkLogic 8 and Slush Discovery App

## Setup
### Create docker base image   
Follow instructions from https://github.com/rlouapre/docker-ml  
Make sure to download MarkLogic 8 - Centos 6 RPM package  
The new image created must have the tag name: **centos6-ml**

### Build docker image  
```docker build --rm=true -t "docker-ml8-slush-discovery" github.com/aajacobs/docker-ml8-slush-discovery```  

### Run Samplestack within the container (for demo)  
Run docker with named container:  
```docker run --name ml-slush -d -p 8000:8000 -p 8001:8001 -p 3000:3000 -p 8040:8040 -p 9070:9070 centos-ml8-ml-slush-discovery```  
Bootstrap and start Samplestack:  
```docker exec ml-slush bash -c "cd /home/ml-slush-discovery-app/ && gulp serve-local"```  








### Run Samplestack from a volume mounted to the container (for development)  
Assuming path-to-samplestack is /Users/Richard/Projects/ML/marklogic-samplestack  
```docker run --name java-samplestack -d -p 8000:8000 -p 8001:8001 -p 8002:8002 -p 8006:8006 -p 8090:8090 -v /Users/Richard/Projects/ML/marklogic-samplestack:/opt/marklogic-samplestack rlouapre/centos6-ml8-java-samplestack```  

```docker exec java-samplestack bash -c "cd /opt/marklogic-samplestack/appserver/java-spring && ./gradlew dbInit && ./gradlew appserver"```  

FIX: Windows / Virtualbox driver does not mount to local file system  
```VBoxManage controlvm ${machine-name} acpipowerbutton```  
```VBoxManage sharedfolder add ${machine-name} --name Users --hostpath c:/Users --automount```  
```VBoxManage startvm ${machine-name} --type headless```  

## Test

Samplestack web app accessible from: ```http://{docker-ip}:8090```  
Samplestack REST server accessible from: ```http://{docker-ip}:8006```  

If you are using docker-machine ip address is available from ```docker-machine ip {machine-name}```


# docker run --name ml-slush -d -p 8000:8000 -p 8001:8001 -p 3000:3000 -p 8040:8040 -p 9070:9070 centos-ml8-ml-slush-discovery
# docker exec ml-slush bash -c "cd /home/ml-slush-discovery-app/ && gulp serve-local"
