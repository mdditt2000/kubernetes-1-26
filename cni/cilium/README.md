# Setup Cilium with F5 BIG-IP

This guide documents how to use Cilium CNI with F5 BIG-IP

```
enable-vtep:   "true"
vtep-endpoint: "192.168.200.60"
vtep-cidr:     "10.1.5.0/24"
vtep-mask:     "255.255.255.0"
vtep-mac:      "00:50:56:bb:f7:a7"
```

Add the BIG-IP device to the flannel overlay network. Find the VTEP MAC address

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

root@(k8s)(cfg-sync Standalone)(zrd DOWN)(/Common)(tmos)#
```

