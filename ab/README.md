# A/B Validation using Cilium CNI with F5 BIG-IP

This document demonstrates how to configure A/B testing using a CRD in Kubernetes. F5 BIG-IP integrates using Cilium CNI

* A/B testing is the practice of running two release versions of software simultaneously and then forwarding usage to a given version according to routing configuration settings
* A typical example of A/B testing is website usability testing. A publisher will release a beta version of the website to run alongside the stable version of the site. Users will be routed between the legacy site and the beta version at random or according to a predefined weighting algorithm — for example, only 10% of the incoming traffic will be routed to the beta version

### A/B Testing using CRD

In this example their are two pool members as shown in the example

![ab](https://github.com/mdditt2000/kubernetes-1-26/blob/main/ab/diagram/2023-05-10_16-07-50.png)

```

```

