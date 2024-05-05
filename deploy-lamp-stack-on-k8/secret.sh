$ kubectl create secret generic db-config \
    --from-literal=MYSQL_ROOT_PASSWORD=kodekloud_root \
    --from-literal=MYSQL_DATABASE=kodekloud \
    --from-literal=MYSQL_USER=kodekloud_user \
    --from-literal=MYSQL_PASSWORD=kodekloud_user \
    --from-literal=MYSQL_HOST=mysql-service