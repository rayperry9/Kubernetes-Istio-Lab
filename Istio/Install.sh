#!/bin/bash

curl -L https://istio.io/downloadIstio | sh -

export PATH=$PWD/bin:$PATH

istioctl install --set profile=demo -y

kubectl label namespace default istio-injection=enabled