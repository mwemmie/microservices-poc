#!/bin/bash

# Build app
./mvnw -DskipTests clean package

# Build docker image, tag named for my private GCP docker registry
docker build -t gcr.io/lyrical-epigram-179318/reservation-service:v1 .