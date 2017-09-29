#!/bin/bash

# To delete components (not the cluster itself) from Kubernetes
sh delete_all_kubernetes.sh

# To delete clusters:
gcloud container clusters delete microservice-poc-cluster --zone=us-central1-c

# To delete docker container registry images:
gcloud container images delete gcr.io/lyrical-epigram-179318/reservation-service:v1 gcr.io/lyrical-epigram-179318/reservation-client:v1
