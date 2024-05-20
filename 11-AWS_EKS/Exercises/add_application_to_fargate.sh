#!/bin/bash

# the namespace name needs to be the same as the fargate name
kubectl create ns java-application

kubectl create secret docker-registry my-registry-key \
--docker-server=docker.io \
--docker-username=rodybothe2 \
--docker-password=


kubectl apply -f Java/secret.yml -n java-application
kubectl apply -f Java/configmap.yml -n java-application
kubectl apply -f Java/mysql.yaml -n java-application
kubectl apply -f Java/java.yaml -n java-application

