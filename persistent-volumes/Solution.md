---
apiVersion: v1
kind: PersistentVolume
metadata:
  name: pv-xfusion
spec:
  capacity:
    storage: 3Gi
  accessModes:
    - ReadWriteOnce
  storageClassName: manual
  hostPath:
    path: /mnt/security
---
apiVersion: v1
kind: PersistentVolumeClaim
metadata:
  name: pvc-xfusion
spec:
  accessModes:
    - ReadWriteOnce
  storageClassName: manual
  resources:
    requests:
      storage: 1Gi
---
apiVersion: v1
kind: Pod
metadata:
  name: pod-xfusion
  labels:
    app: pv-nginx
spec:
  volumes:
    - name: storage-xfusion
      persistentVolumeClaim:
        claimName: pvc-xfusion
  containers:
    - name: container-xfusion
      image: nginx:latest
      ports:
        - containerPort: 80
      volumeMounts:
        - name: storage-xfusion
          mountPath:  /usr/share/nginx/html
--- 
apiVersion: v1 
kind: Service 
metadata: 
  name: web-xfusion
spec: 
   type: NodePort 
   selector: 
     app: pv-nginx
   ports: 
     - port: 80 
       targetPort: 80 
       nodePort: 30008