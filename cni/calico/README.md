# Setup Calico with F5 BIG-IP

This guide documents how to use Calico CNI with F5 BIG-IP. I am only going to provide a quick example for this documentation. In this document I migrated from Flannel to Calico using the following document [Replace Flannel w/ Calico](https://clouddocs.f5.com/training/community/containers/html/appendix/appendix8/appendix8.html#appendix-8-replace-flannel-w-calico)

### Setup for non-HA

Calico setup on the BIG-IP is well documented. Recommend following link above or [Configuring Calico](https://clouddocs.f5.com/containers/latest/userguide/calico-config.html?highlight=calico#configuring-calico)

# Pros and Cons of using Calico with F5 BIG-IP

* Calico is very simple to setup in Kubernetes and well documented
* Works really and stable
* Excellent option for production, allows easy configuration for BIG-IP HA
* No configuration of tunnels