kubectl create secret generic mysql-root-pass --from-literal=password=YUIidhb667
kubectl create secret generic mysql-user-pass --from-literal=username=kodekloud_cap \
--from-literal=password=ksH85UJjhb
kubectl create secret generic mysql-db-url --from-literal=database=kodekloud_db2
