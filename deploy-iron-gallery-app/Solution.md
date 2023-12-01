```
thor@jump_host ~$ kubectl get ns
NAME                 STATUS   AGE
default              Active   67m
kube-node-lease      Active   67m
kube-public          Active   67m
kube-system          Active   67m
local-path-storage   Active   67m
thor@jump_host ~$ kubectl get pods
No resources found in default namespace.
thor@jump_host ~$ kubectl get deploy
No resources found in default namespace.
thor@jump_host ~$ 

```

```
thor@jump_host ~$ kubectl create namespace iron-namespace-devops
namespace/iron-namespace-devops created
thor@jump_host ~$
```
```
thor@jump_host ~$ kubectl create deployment iron-gallery-deployment-devops --dry-run=client --namespace=iron-namespace-devops --replicas=1 --image=kodekloud/irongallery:2.0 -o yaml > deploy-gallery.yaml
thor@jump_host ~$
```

```
thor@jump_host ~$ kubectl create deployment iron-db-deployment-devops --dry-run=client --namespace=iron-namespace-devops --replicas=1 --image=kodekloud/irondb:2.0 -o yaml > deploy-db.yamlthor@jump_host ~$
```


