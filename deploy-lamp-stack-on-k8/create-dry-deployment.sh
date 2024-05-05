$ kubectl create deployment lamp-wp \
    --image=webdevops/php-apache:alpine-3-php7 \
    --dry-run=client -o yaml > lamp-wp.yaml