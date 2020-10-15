#!/bin/bash

GH_URL=$1
GH_PATH=$2
NAMESPACE=$3

URL_CFG=$(cat "url_template.json" | sed "s%##GH_URL##%${1:-https://github.com/jnpacker/policy-collection.git}%g")
echo "$URL_CFG" > url_patch.json
CHANNEL_CFG=$(cat "channel_template.json" | sed "s/##NAMESPACE##/${3:-policies}/g")
echo "$CHANNEL_CFG" > channel_patch.json
KUST_CFG=$(cat "kustomization_template.yaml" | sed "s/##NAMESPACE##/${3:-policies}/g")
echo "$KUST_CFG" > kustomization.yaml

kubectl kustomize . > resources.yaml
kubectl apply -f resources.yaml

rm url_patch.json
rm channel_patch.json
rm kustomization.yaml
rm resources.yaml
