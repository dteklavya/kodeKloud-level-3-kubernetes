The Nautilus DevOps team is working on a Kubernetes template to deploy a web application on the cluster. There are some requirements to create/use persistent volumes to store the application code, and the template needs to be designed accordingly. Please find more details below:

1. Create a `PersistentVolume` named as `pv-xfusion`. Configure the `spec` as storage class should be `manual`, set capacity to `3Gi`, set access mode to `ReadWriteOnce`, volume type should be `hostPath` and set path to `/mnt/security` (this directory is already created, you might not be able to access it directly, so you need not to worry about it).

2. Create a `PersistentVolumeClaim` named as `pvc-xfusion`. Configure the `spec` as storage class should be `manual`, request `1Gi` of the storage, set access mode to `ReadWriteOnce`.

3. Create a `pod` named as `pod-xfusion`, mount the persistent volume you created with claim name `pvc-xfusion` at document root of the web server, the container within the pod should be named as `container-xfusion` using image `nginx` with `latest` tag only (remember to mention the tag i.e `nginx:latest`).

4. Create a node port type service named `web-xfusion` using node port `30008` to expose the web server running within the pod.
