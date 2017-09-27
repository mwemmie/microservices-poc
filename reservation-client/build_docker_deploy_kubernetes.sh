#!/bin/bash

# Build a self-executable jar
./mvnw -DskipTests clean package

# Build docker image
docker build -t reservation-client:v1 .

# Create a Kubernetes deployment
kubectl run reservation-client --image=reservation-client:v1 --port=8080

# Expose the client as a Kubernetes service externally
kubectl expose deployment reservation-client --type=LoadBalancer --port=80 --target-port=8080