```
thor@jump_host ~$ kubectl create secret generic mysql-root-pass \
> --from-literal=password=R00t 
secret/mysql-root-pass created
thor@jump_host ~$ 
thor@jump_host ~$ 
thor@jump_host ~$ kubectl create secret generic mysql-user-pass \
--from-literal=username=kodekloud_cap --from-literal=password=ksH85UJjhb
secret/mysql-user-pass created
thor@jump_host ~$ 
thor@jump_host ~$ kubectl create secret generic mysql-db-url --from-literal=database=kodekloud_db8
secret/mysql-db-url created
thor@jump_host ~$
thor@jump_host ~$ kubectl create secret generic mysql-host --from-literal=host=mysql-service
secret/mysql-host created
thor@jump_host ~$

```

```
thor@jump_host ~$ echo 'variables_order = "EGPCS"' > php.ini
thor@jump_host ~$ kubectl create configmap php-config --from-file php.ini
configmap/php-config created
thor@jump_host ~$ kubectl get configmaps 
NAME               DATA   AGE
kube-root-ca.crt   1      37m
php-config         1      82s
thor@jump_host ~$
```

Create dry deployment spec:

```
thor@jump_host ~$ kubectl create deployment lemp-wp --dry-run=client \--image=webdevops/php-nginx:alpine-3-php7 -o yaml > lemp-deployment.yaml
thor@jump_host ~$ 
thor@jump_host ~$ vi lemp-deployment.yaml
```

