#!/bin/bash

WORKSPACE=$1
clusterName=$2
# AWS_ACCESS_KEY_ID=$3
# AWS_SECRET_ACCESS_KEY=$4
# esEndPoint=$5

kubectl apply -f $WORKSPACE/EFK/kube-logging.yml

fluentd=`cat "$WORKSPACE/EFK/fluentd/fluentd.yml" | sed "s/{{clusterName}}/$clusterName/g"`
echo "$fluentd" | kubectl apply -f -
# es_proxy_deployment=`cat "$WORKSPACE/EFK/es-proxy-deployment.yml" | sed "s~{{AWS_ACCESS_KEY_ID}}~$AWS_ACCESS_KEY_ID~g" | sed "s~{{AWS_SECRET_ACCESS_KEY}}~$AWS_SECRET_ACCESS_KEY~g" | sed "s~{{ELASTICSEARCH_URL}}~$esEndPoint~g"`
# echo "$es_proxy_deployment" | kubectl apply -f -
