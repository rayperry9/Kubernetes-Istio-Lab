#!/bin/bash

helm delete bpcalculator

helm repo add bitnami https://charts.bitnami.com/bitnami

helm install bpcalculator --set auth.rootPassword=secretpassword bitnami/mongodb

export MONGODB_ROOT_PASSWORD=$(kubectl get secret --namespace default bpcalculator-mongodb -o jsonpath="{.data.mongodb-root-password}" | base64 --decode)

kubectl run --namespace default bpcalculator-mongodb-client --rm --tty -i --restart='Never' --env="MONGODB_ROOT_PASSWORD=$MONGODB_ROOT_PASSWORD" --image docker.io/bitnami/mongodb:4.4.5-debian-10-r0 --command -- bash

mongo admin --host "bpcalculator-mongodb" --authenticationDatabase admin -u root -p $MONGODB_ROOT_PASSWORD