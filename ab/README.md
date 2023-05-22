# A/B testing using the F5 BIG-IP Container Ingress Services

This document demonstrates how to configure A/B testing using a CRD in Kubernetes. A/B testing, sometimes called split testing, is a deployment strategy used to test a specific version of an application by routing a subset (usually defined in percentages) of users to a newer version of said application. This is extremely useful when rolling out a new feature and you are unsure of how it might affect existing users.

* A/B testing is the practice of running two release versions of software simultaneously and then forwarding usage to a given version according to routing configuration settings
* A typical example of A/B testing is website usability testing. A publisher will release a beta version of the website to run alongside the stable version of the site. Users will be routed between the legacy site and the beta version at random or according to a predefined weighting algorithm — for example, only 10% of the incoming traffic will be routed to the beta version

![ab](https://github.com/mdditt2000/kubernetes-1-26/blob/main/ab/diagram/2023-05-10_16-07-50.png)

Demo on YouTube [video](https://youtu.be/5m1Hl5Ej6HI)

### A/B Testing using CRD

In this example their are two namespaces **cafeone** and **cafetwo** each with the cafe application deployed. BIG-IP will create two pools and load-balance the traffic based on the weight between the pools

```
apiVersion: cis.f5.com/v1
kind: VirtualServer
metadata:
  labels:
    f5cr: "true"
  name: vs-coffee-ab
  namespace: cafeone
spec:
  virtualServerAddress: 10.192.75.121
  tlsProfileName: edge-tls
  httpTraffic: redirect
  host: cafe.example.com
  pools:
    - path: /coffee
      service: coffee-svc
      servicePort: 8080
      weight: 70
      alternateBackends:
        - service: coffee-svc
          weight: 30
          serviceNamespace: cafetwo
```

