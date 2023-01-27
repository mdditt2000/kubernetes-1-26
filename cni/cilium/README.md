# Setup Cilium with F5 BIG-IP

This guide documents how to use Cilium CNI with F5 BIG-IP

#. Create a VXLAN tunnel profile. The tunnel profile name is fl-vxlan,
    tmsh create net tunnels vxlan fl-vxlan port 8472 flooding-type multipoint

#. Create a VXLAN tunnel, the tunnel name is ``flannel_vxlan``, in CIS use ``-flannel-name`` argument
    tmsh create net tunnels tunnel flannel_vxlan key 2 profile fl-vxlan local-address 10.169.72.34

#. Create VXLAN tunnel self IP, allow default service, allow none stops self ip ping from working
    tmsh create net self 10.1.6.34 address 10.1.6.34/255.255.255.0 allow-service default vlan flannel_vxlan

#. Create a static route to Cilium managed pod CIDR network ``10.0.0.0/16`` through tunnel interface ``flannel_vxlan``
    tmsh create net route 10.0.0.0 network 10.0.0.0/16 interface flannel_vxlan

#. Save sys config
    tmsh save sys config

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

