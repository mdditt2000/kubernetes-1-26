# Setup Fannel with F5 BIG-IP

This guide documents how to use Flannel CNI with F5 BIG-IP. I am only going to provide a quick example for this documentation. Full BIG-IP HA examples can be found on my user-guides 

### Step 1 Initial Setup for non-HA

Flannel requires VXLAN tunnels setup on the BIG-IP. This process can be tricky and complex in some environments

```
tmsh create auth partition k8s
tmsh create net tunnels vxlan fl-vxlan port 8472 flooding-type none
tmsh create net tunnels tunnel fl-vxlan key 1 profile fl-vxlan local-address 192.168.200.60
tmsh create net self 10.244.20.60 address 10.244.20.60/255.255.0.0 allow-service none vlan fl-vxlan
```

### Step 2 Deploy CIS

Deploy CIS and create CNI

```
#create kubernetes cis container, authentication and RBAC
kubectl create secret generic bigip-login -n kube-system --from-literal=username=admin --from-literal=password=f5PME123
kubectl create -f bigip-ctlr-clusterrole.yaml
kubectl create -f f5-bigip-ctlr-deployment.yaml
kubectl create -f f5-bigip-node.yaml
```

# Pros and Cons of using Fannel with F5 BIG-IP

* Flannel is very simple to setup in Kubernetes
* Works really but not easy to customize when intergrating with BIG-IP. For example if you want to change the VNI to support multiple tunnels
* VXLAN not easy to setup and very difficult troubleshoot when things do not work



