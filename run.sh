#!/bin/sh

HELP="
Usage: run.sh [OPTIONS]

    -c, --create            Print version information
    -d, --delete            Configuration file
    -i, --enable-ingress    Enable ingress
    -d, --enable-dashboard  Enable dashboard
    -u, --admin-user        Create admin user
    -h, --help              Print this help message
"


case $1 in

    -c|--create)
        kind create cluster --config=./config/cluster.yml;;
    -d|--delete)
        kind delete cluster --name $2;;
    -i|--enable-ingress)
        kubectl label node --overwrite lab-control-plane ingress-ready=true
        kubectl apply -f ./ingress/nginx.yml;;
    -d|--enable-dashboard)
        kubectl apply -f ./dashboard/deploy.yml;;
    -u|--admin-user)
        kubectl apply -f ./dashboard/admin-user.yml;;
    -h|--help)
        echo -e "$HELP";;
    *)
        echo -e "$HELP";;
esac