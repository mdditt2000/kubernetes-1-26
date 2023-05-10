# A/B Validation using Cilium CNI with F5 BIG-IP

This document demonstrates how to configure A/B testing using a CRD in Kubernetes. F5 BIG-IP integrates using Cilium CNI. In this example BIG-IP is using a non-standard route-domian. Will be changing the route-domain from 0 "default" to 3. Route-domain provide layer 2/3 isolation on BIG-IP which are frequently used on BIG-IP today. 

**Note** Is its highly recommend to not change the default route-domain. Keep setting default to remove the complexity

* A/B testing is the practice of running two release versions of software simultaneously and then forwarding usage to a given version according to routing configuration settings
* A typical example of A/B testing is website usability testing. A publisher will release a beta version of the website to run alongside the stable version of the site. Users will be routed between the legacy site and the beta version at random or according to a predefined weighting algorithm — for example, only 10% of the incoming traffic will be routed to the beta version


### BIG-IP Tunnel Setup for Cilium VTEP Integration

* Create a VXLAN tunnel profile. The tunnel profile name is fl-vxlan,
```
tmsh create net tunnels vxlan fl-vxlan port 8472 flooding-type multipoint
```

* Create a VXLAN tunnel, the tunnel name is ``flannel_vxlan``, in CIS use ``-flannel-name`` argument
```
tmsh create net tunnels tunnel flannel_vxlan key 2 profile fl-vxlan local-address 192.168.200.60
```

* Create VXLAN tunnel self IP, allow default service, allow none stops self ip ping from working
```
tmsh create net self 10.1.6.60 address 10.1.6.60/255.255.255.0 allow-service default vlan flannel_vxlan
```

* Create a static route to Cilium managed pod CIDR network ``10.0.0.0/16`` through tunnel interface ``flannel_vxlan``
```
tmsh create net route 10.0.0.0 network 10.0.0.0/16 interface flannel_vxlan
```

* Save sys config
```
tmsh save sys config
```

* Add the BIG-IP device to the VXLAN overlay network. **Find the VTEP MAC address**

```
root@(k8s)(cfg-sync Standalone)(zrd DOWN)(/Common)(tmos)# show net tunnels tunnel flannel_vxlan all-properties

-------------------------------------------------
Net::Tunnel: flannel_vxlan
-------------------------------------------------
MAC Address                     00:50:56:bb:f7:a7
Interface Name                      flannel_vxlan

Incoming Discard Packets                        0
Incoming Error Packets                          0
Incoming Unknown Proto Packets                  0
Outgoing Discard Packets                        0
Outgoing Error Packets                      74.1K
HC Incoming Octets                           1.8M
HC Incoming Unicast Packets                 24.7K
HC Incoming Multicast Packets                   0
HC Incoming Broadcast Packets                   0
HC Outgoing Octets                           1.6M
HC Outgoing Unicast Packets                 24.7K
HC Outgoing Multicast Packets                   0
HC Outgoing Broadcast Packets                   0
```

### Enable Cilium VXLAN Tunnel Endpoint (VTEP) integration

* Edit the **cilium-config** ConfigMap
    kubectl edit cm cilium-config -n kube-system

```
enable-vtep:   "true"
vtep-endpoint: "192.168.200.60"
vtep-cidr:     "10.1.5.0/24"
vtep-mask:     "255.255.255.0"
vtep-mac:      "00:50:56:bb:f7:a7"
```

* Restart Cilium daemonset
    kubectl rollout restart ds/cilium -n kube-system

* Monitor the CIS logs for FDB entries

```
2023/01/27 20:41:25 [INFO] Text: '{"kind":"tm:net:fdb:tunnel:records:recordscollectionstate","selfLink":"https://localhost/mgmt/tm/net/fdb/tunnel/~Common~flannel_vxlan/records?ver=16.1.2","items":[{"kind":"tm:net:fdb:tunnel:records:recordsstate","name":"0a:0a:c0:a8:c8:41","fullPath":"0a:0a:c0:a8:c8:41","generation":130,"selfLink":"https://localhost/mgmt/tm/net/fdb/tunnel/~Common~flannel_vxlan/records/0a:0a:c0:a8:c8:41?ver=16.1.2","endpoint":"192.168.200.65%0"},{"kind":"tm:net:fdb:tunnel:records:recordsstate","name":"0a:0a:c0:a8:c8:42","fullPath":"0a:0a:c0:a8:c8:42","generation":130,"selfLink":"https://localhost/mgmt/tm/net/fdb/tunnel/~Common~flannel_vxlan/records/0a:0a:c0:a8:c8:42?ver=16.1.2","endpoint":"192.168.200.66%0"}]}'
```

Can also view the FDB entries from the F5 BIG-IP 

![FDB](https://github.com/mdditt2000/kubernetes-1-26/blob/main/cni/cilium/diagram/2023-01-27_12-47-16.png)

