# Running Mule on Docker
Download Mulestandalone zip file

Code to build the Docker image:

    docker build -t dockermule -f Dockerfile .

Running the docker image:

    docker run -d -p 5000:8092 -i -t dockermule

Create server on anypoint studio and copy the command in the the docker terminal of your container.

Restart the container

## Problems you may encounter
1. jdk issue - solve by changing the `eclipse-temurin:21` to the latest jdk version

## References
[Deploy Mule application on Docker](https://medium.com/@brojoluck/deploy-mule-application-on-docker-dc3fddf6e99f)