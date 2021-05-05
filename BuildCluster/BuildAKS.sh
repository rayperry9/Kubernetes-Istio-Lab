#!/bin/bash

echo "Login"
az login

echo "Create a resource group"
az group create --name=student-group --location=northeurope

echo "Create Service Principle for AKS"
az ad sp create-for-rbac --skip-assignment > cred.txt
appId=$(cat cred.txt | grep appId | cut -d ":" -f2 | tr -d '"' | tr -d ',')
password=$(cat cred.txt | grep password | cut -d ":" -f2 | tr -d '"' | tr -d ',')

sleep 10

echo "Create the k8s Cluster"
echo "(Don’t be paro, this will take some minutes to complete)"
az aks create --resource-group student-group --name studentAKSCluster --node-count 1 --location northeurope --service-principal $appId --generate-ssh-keys --client-secret $password --generate-ssh-keys

echo "Connect local kubectl client to AKS cluster"
az aks get-credentials --resource-group student-group --name studentAKSCluster

echo "Verify the connection to your cluster"
kubectl get nodes





