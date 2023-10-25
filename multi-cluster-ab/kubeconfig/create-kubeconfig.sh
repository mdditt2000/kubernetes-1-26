#!/bin/bash

CLUSTER_ALIAS=$1

if [ -z $CLUSTER_ALIAS ]; then

	echo "Needs to specify cluster alias as argument, ie: $0 ocp1"
	exit 1
fi

# USER_TOKEN_NAME=$(oc -n cis-mc-onetier get serviceaccount bigip-ctlr -o=jsonpath='{.secrets[0].name}')

kubectl apply -f - <<EOF
apiVersion: v1
kind: Secret
metadata:
  name: bigip-ctlr
  namespace: cis-mc-onetier
  annotations:
    kubernetes.io/service-account.name: bigip-ctlr
type: kubernetes.io/service-account-token
EOF

# USER_TOKEN_VALUE=$(kubectl create token bigip-ctlr -n cis-mc-onetier --duration=0s)
USER_TOKEN_VALUE=$(kubectl -n cis-mc-onetier get secret bigip-ctlr -o=jsonpath='{.data.token}' | base64 -d )
CURRENT_CONTEXT=$(kubectl config current-context)
CURRENT_CLUSTER=$(kubectl config view --raw -o=go-template='{{range .contexts}}{{if eq .name "'''${CURRENT_CONTEXT}'''"}}{{ index .context "cluster" }}{{end}}{{end}}')
CLUSTER_SERVER=$(kubectl config view --raw -o=go-template='{{range .clusters}}{{if eq .name "'''${CURRENT_CLUSTER}'''"}}{{ .cluster.server }}{{end}}{{ end }}')
CLUSTER_CA=$(kubectl config view --raw -o=go-template='{{range .clusters}}{{if eq .name "'''${CURRENT_CLUSTER}'''"}}"{{with index .cluster "certificate-authority-data" }}{{.}}{{end}}"{{ end }}{{ end }}')
if [ -n $CLUSTER_CA ]; then
	CLUSTER_CA=$(kubectl config view --minify --flatten -o jsonpath='{.clusters[].cluster.certificate-authority-data}')
fi

cat << EOF > kubeconfig.$CLUSTER_ALIAS
apiVersion: v1
kind: Config
current-context: bigip-ctlr-context
contexts:
- name: bigip-ctlr-context
  context:
    cluster: ${CURRENT_CLUSTER}
    user: bigip-ctlr
clusters:
- name: ${CURRENT_CLUSTER}
  cluster:
    certificate-authority-data: ${CLUSTER_CA}
    server: ${CLUSTER_SERVER}
users:
- name: bigip-ctlr
  user:
    token: ${USER_TOKEN_VALUE}
EOF


# kubectl create secret generic <secret-name> --from-file=kubeconfig=<kube-config yaml file name>
# kubectl create secret generic -n cis-mc-onetier kubeconfig.$CLUSTER_ALIAS --from-file=kubeconfig=kubeconfig.$CLUSTER_ALIAS