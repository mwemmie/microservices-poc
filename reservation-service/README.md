# Overview
Simple cloud native reservation service using an embedded H2 database and JPA.  

Use the shell scripts to build, deploy, and eventually delete from Kubernetes.

Exposes the endpoint `/reservations` on:
* port 8080 locally and on docker
* port 80 as `http://reservation-service` on kubernetes

# Build and Deploy

## Run script to handle of all it
sh build_docker_deploy_kubernetes.sh

## Individual pieces in scripts

### Build a self-executable jar
`./mvnw -DskipTests clean package`

### Build docker image, tag named for my private GCP docker registry
`docker build -t gcr.io/lyrical-epigram-179318/reservation-service:v1 .`

### Test docker image, mapping port 8080 on localhost to port 8080 on the running docker container
`docker run -ti --rm -p 8080:8080 gcr.io/lyrical-epigram-179318/reservation-service:v1`

### Create a Kubernetes deployment and expose the service internally
sh deploy_kubernetes.sh

#### To create a kubernetes deployment, do one of the following:
* `kubectl run reservation-service --image=reservation-service:v1 --port=8080`
* `kubectl create -f deployment.yaml`

#### To create a kubernetes service exposed internally, do one of the following:
* `kubectl create -f service.yaml`
* `kubectl expose deployment reservation-service --port=80 --target-port=8080`

# Clean Up Kubernetes When You Want to Stop

## Run script to handle of all it
sh delete_kubernetes.sh

## Individual Pieces in the Script

### Delete the service
`kubectl delete service reservation-service`

### Delete the deployment
`kubectl delete deployment reservation-service`