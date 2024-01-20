# Solution

Start by `describing` the deployment and the `pod` if needed.

```
thor@jump_host ~$ kubectl get deployments.apps
```

Describe deployment:

```
thor@jump_host ~$ kubectl describe deployments.apps python-deployment-datacenter

```
Note the `Ready` output `0/1`.

Describe the pods:

```
thor@jump_host ~$ kubectl describe pod python-deployment-datacenter-***
```

You'll find the reason why it failed. Image name was incorrect.

#### Generate YAML config for deployment

```
thor@jump_host ~$ kubectl get deployments.apps python-deployment-datacenter  -o yaml > deployment.yaml
```

Edit the YAML file and fix image name and nodePort.

Next, just apply the changes and wait a few for pod to get ready:

```
thor@jump_host ~$ kubectl apply -f deployment.yaml
```

#### Fix the nodePort in services

Describe service:

```
thor@jump_host ~$ kubectl get service -o yaml > service.yaml 
```

Edit `service.yaml` and make sure `targetPort` and `nodePort` have desired values. And apply you changes.
