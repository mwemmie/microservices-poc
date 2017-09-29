# Overview
Simple, minimal cloud native Java microservice setup using Spring boot, Docker, and kubernetes.  This is a super slimmed down version of https://github.com/joshlong/bootiful-microservices/tree/master/bootiful-microservices-dalston. This repo has 2 microservices, `reservation-service` and `reservation-client`.  `reservation-service` is a true microservice that is exposed only internally for collaboration with other microservices.  It is exposed internally using Kubernetes internal DNS at `http://reservation-service`.  `reservation-client` is an edge microservice that calls the `reservation-service` microservice, however, `reservation-client` is also exposed external to kubernetes using the LoadBalancer feature.  This externally exposed service will get a unique, dedicated IP address determined by the cloud provider it is running on.

# How to Run It
To compile, build docker containers, and deploy to kubernetes all at once, you can run `sh build_all.sh`.  Note that you must have `docker` installed, as well as `kubectl` installed and configured to point to a particular kubernetes cluster.

Thus far, I've run this configuration only on my local macbook using docker for mac and [minikube](https://kubernetes.io/docs/tutorials/stateless-application/hello-minikube/)
 (local installation of kubernetes).  When using minikube, you can also run `eval $(minikube docker-env)` so that when you build docker images, they exist in a "virtual image repository" that is directly accessible by minikube, i.e. you don't have to do a `docker -- push <image>` to anywhere.

You can also build/deploy/delete more granular parts by using the various shell scripts in the directories for each microservice.

# How to Tear It Down
To delete components from Kubernetes, you can run `sh delete_all_kubernetes.sh`.  
