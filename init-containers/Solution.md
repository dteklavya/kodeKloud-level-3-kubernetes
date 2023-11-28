```
thor@jump_host ~$ kubectl get pods
No resources found in default namespace.
thor@jump_host ~$

thor@jump_host ~$ kubectl get deploy
No resources found in default namespace.
thor@jump_host ~$

thor@jump_host ~$ kubectl get services 
NAME         TYPE        CLUSTER-IP   EXTERNAL-IP   PORT(S)   AGE
kubernetes   ClusterIP   10.96.0.1    <none>        443/TCP   67m
thor@jump_host ~$
```

Create skeleton YAML spec using dry run:

```
thor@jump_host ~$ kubectl create deployment ic-deploy-nautilus --replicas=1 \
--image=fedora:latest --dry-run=client -o yaml > ic-deployment.yaml
thor@jump_host ~$
```

Edit the file, add section for `initContainers` and other changes as per problem statement and run:

```
thor@jump_host ~$ kubectl create -f ic-deployment.yaml
```

Verify:

```
thor@jump_host ~$ kubectl get pods
```

```
thor@jump_host ~$ kubectl logs -f <REPLACE_WITH_REAL_POD>
```
