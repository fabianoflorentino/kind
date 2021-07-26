#!/bin/sh

case $1 in

    --create)
        kind create cluster --config=./config/cluster.yaml;;
    --delete)
        kind delete cluster --name $2;;
    *)
        echo -e "Sorry! Try [--create || --delete <CLUSTER-NAME> ]";;
esac