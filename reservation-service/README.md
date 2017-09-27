# Overview
Simple cloud native reservation service using an embedded H2 database and JPA.  

Use the shell scripts to build, deploy, and eventually delete from Kubernetes.

# Build and Deploy

## Build app
`./mvnw -DskipTests clean package`

## Build docker image
`docker build -t reservation-service:v1 .`

## Test docker image, mapping port 8080 on localhost to port 8080 on the running docker container
`docker run -ti --rm -p 8080:8080 reservation-service:v1`

## Deploy to Kubernetes
`kubectl run reservation-service --image=reservation-service:v1 --port=8080`

## Expose as a service on kubernetes
`kubectl expose deployment reservation-service --port=80 --target-port=8080`

# Clean Up Kubernetes When You Want To Stop

# Delete the service
`kubectl delete service reservation-service`

# Delete the deployment
`kubectl delete deployment reservation-service`

