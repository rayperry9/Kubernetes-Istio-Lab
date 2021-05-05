#!/bin/bash

curl -L https://istio.io/downloadIstio | sh -

cp install.sh istio-1.9.4 && cd istio-1.9.4 && export PATH=$PWD/bin:$PATH

istioctl install --set profile=demo -y

kubectl label namespace default istio-injection=enabled
