#!/bin/sh

case $1 in

    --create)
        kind create cluster --config=./config/cluster.yml;;
    --enable-ingress)
        kubectl label node --overwrite lab-control-plane ingress-ready=true;;
        kubectl apply -f ./ingress/nginx.yml;;
    --delete)
        kind delete cluster --name $2;;
    *)
        echo -e "Sorry! Try [--create || --delete <CLUSTER-NAME> ]";;
esac