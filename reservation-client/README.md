# Overview
Simple cloud native client that calls another microservice (reservation-service).

Use the shell scripts to build, deploy, and eventually delete from Kubernetes.

# Build and Deploy

## Build a self-executable jar
`./mvnw -DskipTests clean package`

## Build docker image
`docker build -t reservation-client:v1 .`

## Test docker image, mapping port 8080 on localhost to port 8080 on the running docker container
`docker run -ti --rm -p 8080:8080 reservation-client:v1`

## Create a Kubernetes deployment
`kubectl run reservation-client --image=reservation-client:v1 --port=8080`

## Expose the client as a Kubernetes service externally
`kubectl expose deployment reservation-client --type=LoadBalancer --port=80 --target-port=8080`

# Clean Up Kubernetes When You Want to Stop

## Delete the service
`kubectl delete service reservation-client`

## Delete the deployment
`kubectl delete deployment reservation-client`