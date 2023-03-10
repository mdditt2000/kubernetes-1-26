# What Kubernetes Ingress Resources to use with F5 BIG-IP

By default, Kubernetes pods and services cannot be accessed outside of the cluster. The Kubernetes Ingress resource is used to expose pods and services outside the cluster.

Kubernetes Ingress allows you to configure various rules for routing traffic to services within your Kubernetes cluster. You can use an Kubernetes Ingress solution to load-balance traffic; terminate SSL/TLS; implement name-based virtual hosting; enable security, monitoring, and more.

This article, will guide you through various Kubernetes Ingress solutions and use cases to help you find the best Kubernetes Ingress option that fits your needs.

## Kubernetes Ingress Resources available on BIG-IP using CIS

F5 BIG-IP CIS support multiple Kubernetes Ingress Resources. The following are:

* [Ingress](https://github.com/F5Networks/k8s-bigip-ctlr/tree/master/docs/config_examples/ingress/networkingV1)
* [ConfigMap](https://github.com/F5Networks/k8s-bigip-ctlr/tree/master/docs/config_examples/configmap)
* [Routes](https://github.com/F5Networks/k8s-bigip-ctlr/tree/master/docs/config_examples/next-gen-routes)
* [Custom Resource Definitions (CRDs)](https://github.com/F5Networks/k8s-bigip-ctlr/tree/master/docs/config_examples/customResource)

This document displays **sampling and trends over 3 years** of what Kubernetes Ingress Resources are used with CIS to configure F5 BIG-IP

## Kubernetes Ingress Resources Percentage 

Diagram shows CIS Kubernetes Ingress resources percentages used

![percentages](https://github.com/mdditt2000/kubernetes-1-26/blob/main/k8s-resources/diagram/2023-03-10_12-49-32.png)

Diagram shows CIS Kubernetes Ingress resources trends

![chart](https://github.com/mdditt2000/kubernetes-1-26/blob/main/k8s-resources/diagram/2023-03-10_12-50-34.png)