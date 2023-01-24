# Setup Fannel with F5 BIG-IP

This guide documents how to use Calico CNI with F5 BIG-IP. I am only going to provide a quick example for this documentation. In this document I migrated from Flannel to Calico using the following document [Replace Flannel w/ Calico](https://clouddocs.f5.com/training/community/containers/html/appendix/appendix8/appendix8.html#appendix-8-replace-flannel-w-calico)

### Step 1 Initial Setup for non-HA

Calico setup on the BIG-IP is well documented. Recommend following link above or [Configuring Calico](https://clouddocs.f5.com/containers/latest/userguide/calico-config.html?highlight=calico#configuring-calico)

# Pros and Cons of using Fannel with F5 BIG-IP

* Flannel is very simple to setup in Kubernetes
* Works really but not easy to customize when intergrating with BIG-IP. For example if you want to change the VNI to support multiple tunnels
* VXLAN not easy to setup and very difficult troubleshoot when things do not work
* BIG-IP Ha not possible unless you disable all floating address on BIG-IP. That is not really possible for some BIG-IP users