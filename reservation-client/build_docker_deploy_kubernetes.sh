#!/bin/bash

# Build a self-executable jar
./mvnw -DskipTests clean package

# Build docker image
docker build -t gcr.io/lyrical-epigram-179318/reservation-client:v1 .

# Create a Kubernetes deployment and expose the client as a Kubernetes service externally
sh deploy_kubernetes.sh