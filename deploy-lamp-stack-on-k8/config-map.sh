echo 'variables_order = "EGPCS"' > php.ini
kubectl create configmap php-config --from-file php.ini
# Verify
kubectl get configmaps
kubectl describe configmap php-config