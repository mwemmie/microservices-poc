# Overview
Simple cloud native client that calls another microservice (reservation-service).

Use the shell scripts to build, deploy, and eventually delete from Kubernetes.

Exposes the endpoint `/reservations/names` on:
* port 8080 locally and on docker
* port 80 as `http://reservation-client/reservations/names` internally on kubernetes
* externally on the internet (or at least external to kubernetes) at an IP determined by the LoadBalancer

# Build and Deploy

## Run script to handle of all it
sh build_docker_deploy_kubernetes.sh

## Individual pieces in scripts

### Build a self-executable jar
`./mvnw -DskipTests clean package`

### Build docker image
`docker build -t reservation-client:v1 .`

### Test docker image, mapping port 8080 on localhost to port 8080 on the running docker container
`docker run -ti --rm -p 8080:8080 reservation-client:v1`

### Create a Kubernetes deployment and expose the client as a Kubernetes service externally
sh deploy_kubernetes.sh

#### To create a kubernetes deployment, do one of the following:
* `kubectl run reservation-client --image=reservation-client:v1 --port=8080`
* `kubectl create -f deployment.yaml`

#### To create a kubernetes service client exposed externally, do one of the following:
* `kubectl create -f service.yaml`
* `kubectl expose deployment reservation-client --type=LoadBalancer --port=80 --target-port=8080`

# Clean Up Kubernetes When You Want to Stop

## Run script to handle of all it
sh delete_kubernetes.sh

## Individual Pieces in the Script

### Delete the service
`kubectl delete service reservation-client`

### Delete the deployment
`kubectl delete deployment reservation-client`