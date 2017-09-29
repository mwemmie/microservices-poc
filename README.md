# Overview
Simple, minimal cloud native Java microservice setup using Spring boot, Docker, and kubernetes.  This is a super slimmed down version of https://github.com/joshlong/bootiful-microservices/tree/master/bootiful-microservices-dalston. This repo has 2 microservices, `reservation-service` and `reservation-client`.  `reservation-service` is a true microservice that is exposed only internally for collaboration with other microservices.  It is exposed internally using Kubernetes internal DNS at `http://reservation-service`.  `reservation-client` is an edge microservice that calls the `reservation-service` microservice, however, `reservation-client` is also exposed external to kubernetes using the LoadBalancer feature.  This externally exposed service will get a unique, dedicated IP address determined by the cloud provider it is running on.

# How to Run It Locally On Kubernetes Minikube
To compile, build docker containers, and deploy to kubernetes all at once, you can run `sh build_all_local.sh`.  

Note that you must have the following installed:
 * `docker`
 * `kubectl` installed and configured to point to a particular kubernetes cluster
 * [minikube](https://kubernetes.io/docs/tutorials/stateless-application/hello-minikube/)
 (local installation of kubernetes) - When using minikube, you should also run `eval $(minikube docker-env)` prior to building docker images, so that when you build docker images, they exist in a "virtual image repository" that is directly accessible by minikube, i.e. you don't have to do a `docker -- push <image>` to anywhere.

You can also build/deploy/delete more granular parts by using the various shell scripts in the directories for each microservice.

# How To Run On GCP

## Set Up a GCP Account And Do Initial Project Configuration
See the first few steps of [this tutorial](https://codelabs.developers.google.com/codelabs/cloud-springboot-kubernetes/index.html#0) for instructions on how to get set up.  

Steps 2 and 3 include setting up a GCP account, using the browser based google cloud shell, configuring that shell with your cloud account and project information.

Step 4 talks about cloning a git repository into your google cloud shell directory.  Instead of cloning that repository, clone `https://github.com/mwemmie/microservices-poc.git` and switch to the `kubernetes` branch with `git checkout kubernetes`.

It's possible that you may first also need to enable certain GCP services - I can't remember.  After doing this, you should be able to run the script in the next step to do a full fresh install that gets a Kubernetes cluster up and running with your microservices deployed to it!

## Completely Fresh Install
Run `sh build_all_gcp.sh`.  This creates a brand new cluster and then builds and deploys the microservices to it.

## Install on existing cluster
Run `sh build_all_except_cluster.sh`.  This builds and deploys all the microservices to whatever existing cluster you are targeting in kubectl.  If you want to know the more granular steps, look at the scripts referenced.

## One time cluster creation
If a cluster hasn't been built on GCP, this step will need to be run first.  This step is included in `build_all_gcp.sh`.
`gcloud container clusters create microservice-poc-cluster \
  --num-nodes 2 \
  --machine-type n1-standard-1 \
  --zone us-central1-c`

# How to Tear It Down
Running a cluster of microservices isn't cheap, so you should tear it down when it's not being used.  Below are various ways to do this.

## Tear Down Everything on GCP (cluster, kubernetes components, docker repository images)
Run `sh tear_down_gcp.sh`

## Tear Down Kubernetes Components But Not the Cluster Itself (local or GCP)
Run `sh delete_all_kubernetes.sh`

## Delete cluster on GCP:
`gcloud container clusters delete microservice-poc-cluster --zone=us-central1-c`

## Delete docker container registry images:
`gcloud container images delete gcr.io/lyrical-epigram-179318/reservation-service:v1 gcr.io/lyrical-epigram-179318/reservation-client:v1`
