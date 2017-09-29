#!/bin/bash

# Build a self-executable jar
./mvnw -DskipTests clean package

# Build docker image
docker build -t reservation-client:v1 .

# Create a Kubernetes deployment and expose the client as a Kubernetes service externally
sh deploy_kubernetes.sh