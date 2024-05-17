apiVersion: v1
kind: Pod
metadata:
  name: secret-nautilus
  labels:
    name: myapp
spec:
  volumes:
    - name: secret-volume-nautilus
      secret:
        secretName: beta
  containers:
    - name: secret-container-nautilus
      image: ubuntu:latest
      command: ["/bin/bash", "-c", "sleep 10000"]
      volumeMounts:
        - name: secret-volume-nautilus
          mountPath: /opt/apps
          readOnly: true