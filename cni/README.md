# What Kubernetes CNI to use with F5 BIG-IP

This document covers the different CNI that can be used with F5 BIG-IP when integrating with Kubernetes and OpenShift. This document also provides sampling of what CNIs are currently used on BIG-IP

## F5 BIG-IP CNI available on BIG-IP using CIS

Container Network Interface (CNI) is a framework for dynamically configuring networking resources in Kubernetes. It uses a group of libraries and specifications written in Go. The plugin specification defines an interface for configuring the network, provisioning IP addresses, and maintaining connectivity with multiple hosts and containers.

When used with Kubernetes, CNI can integrate smoothly with pods to enable the use of an overlay or underlay network. Overlay networks encapsulate network traffic using a virtual interface such as Virtual Extensible LAN (VXLAN). Underlay networks work at the physical level and comprise switches and routers. VXLAN is just one protocol using in CNIs today

## CNIs used with F5 BIG-IP

**Diagram showing 3 years CNI usage with BIG-IP**

![cni](https://github.com/mdditt2000/kubernetes-1-26/blob/main/cni/diagram/2023-02-13_11-43-13.png)

Links below provide more information on how to deploy CNIs with BIG-IP

* [Flannel](https://github.com/mdditt2000/kubernetes-1-26/tree/main/cni/flannel#readme)
* [Calico](https://github.com/mdditt2000/kubernetes-1-26/tree/main/cni/calico#readme)
* [Cilium](https://github.com/mdditt2000/kubernetes-1-26/tree/main/cni/cilium#readme)