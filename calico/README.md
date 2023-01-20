# Setup Flannel with F5 BIG-IP

This guide documents how to use Flannel CNI with F5 BIG-IP. In this document I used the default ** kubeadm init  --pod-network-cidr=10.244.0.0/16**

Looking at the nodes that get created **Flannel** uses the cidr=10.244.0.0 for the pod network

```
metadata:
  annotations:
    flannel.alpha.coreos.com/backend-data: '{"VNI":1,"VtepMAC":"c2:e5:af:15:7c:f6"}'
    flannel.alpha.coreos.com/backend-type: vxlan
    flannel.alpha.coreos.com/kube-subnet-manager: "true"
    flannel.alpha.coreos.com/public-ip: 192.168.200.65
    kubeadm.alpha.kubernetes.io/cri-socket: unix:///var/run/crio/crio.sock
    node.alpha.kubernetes.io/ttl: "0"
    volumes.kubernetes.io/controller-managed-attach-detach: "true"
  creationTimestamp: "2023-01-18T23:55:30Z"
  labels:
    beta.kubernetes.io/arch: amd64
    beta.kubernetes.io/os: linux
    kubernetes.io/arch: amd64
    kubernetes.io/hostname: master-node-k8.f5demo.com
    kubernetes.io/os: linux
    node-role.kubernetes.io/control-plane: ""
    node.kubernetes.io/exclude-from-external-load-balancers: ""
  name: master-node-k8.f5demo.com
  resourceVersion: "122886"
  uid: 6aac993f-91cf-4bb7-a564-98a2a652c571
spec:
  podCIDR: 10.244.0.0/24
  podCIDRs:
  - 10.244.0.0/24
  taints:
  - effect: NoSchedule
    key: node-role.kubernetes.io/control-plane

```

I have documented how to setup BIG-IP HA etc using flannel on my GitHub page at 