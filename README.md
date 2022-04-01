# **A environment to deploy and test the kubernetes cluster with [Kind](https://kind.sigs.k8s.io)**

![kind-logo](./docs/img/logo.png)

**Link: [https://kind.sigs.k8s.io](https://kind.sigs.k8s.io)**  
**Github: [https://github.com/kubernetes-sigs/kind](https://github.com/kubernetes-sigs/kind)**

## **Descriptions**

| **Components** | **Description** |
| :---------- | :------------ |
| **bin** | binary of kind and kubectl |
| **config** | YAML file for deploy kind |
| **cni** | cni plugin for kubernetes |
| **metrics** | metrics for kubernetes |
| **ingress** | ingress controller for kubernetes |
| **dashboard** | dashboard for kubernetes |

## **Requirements**

- **Docker:** [https://docs.docker.com/get-docker](https://docs.docker.com/get-docker)

**OBS:**

This project will be deployed on a virtual machine with Centos 7.

## **Setup**

Move binary of **kind** and **kubectl** to **/usr/local/bin/**

```bash
cp -rfv ./bin/* /usr/local/bin/
```

validate if the binary is installed

```bash
kind --version

kind version 0.11.1
```

```bash
kubectl version

Client Version: version.Info{Major:"1", Minor:"21", GitVersion:"v0.21.0-beta.1", GitCommit:"96e95cef877ba04872b88e4e2597eabb0174d182", GitTreeState:"clean", BuildDate:"2021-11-04T18:29:37Z", GoVersion:"go1.16.6", Compiler:"gc", Platform:"darwin/amd64"}
Server Version: version.Info{Major:"1", Minor:"21", GitVersion:"v1.21.6+b82a451", GitCommit:"cefce093e4e5bc9a1916eb5a489ed37c7d467f6f", GitTreeState:"clean", BuildDate:"2022-02-05T06:58:30Z", GoVersion:"go1.16.6", Compiler:"gc", Platform:"linux/amd64"}
WARNING: version difference between client (0.21) and server (1.21) exceeds the supported minor version skew of +/-1
```

Validate the configuration YAML file on [./config/cluster.yml](./config/cluster.yml)

```yaml
---
kind: Cluster
apiVersion: kind.x-k8s.io/v1alpha4
name: lab

...
```

The kind on this project is configured with 3 masters nodes and 3 worker nodes and some features enabled on masters nodes.

```yaml
featureGates:
  "CSIMigration": true

runtimeConfig:
  "api/alpha": false

networking:
  disableDefaultCNI: true
  kubeProxyMode: ipvs
  ipFamily: ipv4
  apiServerAddress: "172.16.252.100"
  apiServerPort: 6443
  podSubnet: "10.244.0.0/16"
  serviceSubnet: "10.96.0.0/12"

nodes:
  - role: control-plane
    kubeadmConfigPatches:
    - |
      kind: InitConfiguration
      nodeRegistration:
        kubeletExtraArgs:
          node-labels: "ingress-ready=true"
    extraPortMappings:
    - containerPort: 80
      hostPort: 8081
      listenAddress: "172.16.252.100"
      protocol: TCP
    - containerPort: 443
      hostPort: 8441
      listenAddress: "172.16.252.100"
      protocol: TCP
    extraMounts:
    - hostPath: /mnt/storage/vol1
      containerPath: /opt/vol1
      readOnly: true
      selinuxRelabel: false
      propagation: HostToContaine
```

If you have any doubt about the configuration, see the documentation on **[https://kind.sigs.k8s.io/docs/user/configuration](https://kind.sigs.k8s.io/docs/user/configuration)**

```bash

Insite project run the run.sh script

```bash
./run.sh

Usage: run.sh [OPTIONS]

    -c, --create            Print version information
    -d, --delete            Configuration file
    -n, --enable-cni        Enable CNI
    -i, --enable-ingress    Enable ingress
    -d, --enable-dashboard  Enable dashboard
    -u, --admin-user        Create admin user
    -h, --help              Print this help message
```
