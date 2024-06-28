The Nautilus Application Development team is planning to deploy one of the php-based applications on Kubernetes cluster. As per the recent discussion with DevOps team, they have decided to use nginx and phpfpm. Additionally, they also shared some custom configuration requirements. Below you can find more details. Please complete this task as per requirements mentioned below:



1. Create a service to expose this app, the service type must be `NodePort`, nodePort should be `30012`.
    ```
    apiVersion: v1
    kind: Service # Important!
    metadata:
    name: nginx-phpfpm
    spec:
    type: NodePort
    selector:
        app: nginx-phpfpm # This is important - used by Pod.yaml spec.
    ports:
        - port: 8092
        targetPort: 8092 # Port where requests land up!
        nodePort: 30012 # Port where service is accessed.
    ```


2. Create a config map named `nginx-config` for `nginx.conf` as we want to add some custom settings in nginx.conf.


    a) Change the default port `80` to `8092` in nginx.conf.


    b) Change the default document root `/usr/share/nginx` to `/var/www/html` in `nginx.conf`.


    c) Update the directory index to `index`  `index.html` `index.htm` `index.php` in `nginx.conf`.
    ```
    apiVersion: v1
    kind: ConfigMap
    metadata:
    name: nginx-config
    data:
    nginx.conf: |
        events {} 
        http {
        server {
            listen 8092;
            index index.html index.htm index.php;
            root  /var/www/html;
            location ~ \.php$ {
            include fastcgi_params;
            fastcgi_param REQUEST_METHOD $request_method;
            fastcgi_param SCRIPT_FILENAME $document_root$fastcgi_script_name;
            fastcgi_pass 127.0.0.1:9000;
            }
        }
        }
    ```


3. Create a pod named `nginx-phpfpm`.


    a) Create a shared volume named `shared-files` that will be used by both containers (nginx and phpfpm) also it should be a `emptyDir` volume.


    b) Map the ConfigMap we declared above as a volume for `nginx container`. Name the volume as `nginx-config-volume`, mount path should be `/etc/nginx/nginx.conf` and subPath should be `nginx.conf`


    c) Nginx container should be named as `nginx-container` and it should use `nginx:latest` image. PhpFPM container should be named as `php-fpm-container` and it should use `php:8.2-fpm-alpine` image.


    d) The shared volume `shared-files` should be mounted at `/var/www/html` location in both containers. Copy `/opt/index.php` from `jump host` to the nginx document root inside the `nginx` container, once done you can access the app using App button on the top bar.
    ```
    apiVersion: v1
    kind: Pod
    metadata:
    name: nginx-phpfpm
    labels:
        app: nginx-phpfpm
        tier: back-end
    spec:
    volumes:
        - name: shared-files
        emptyDir: {}
        - name: nginx-config-volume
        configMap:
            name: nginx-config
    containers:
        - name: nginx-container
        image: nginx:latest
        volumeMounts:
            - name: shared-files
            mountPath: /var/www/html
            - name: nginx-config-volume
            mountPath: /etc/nginx/nginx.conf
            subPath: nginx.conf
        ports:
            - containerPort: 8092
        - name: php-fpm-container
        image: php:8.2-fpm-alpine
        volumeMounts:
            - name: shared-files
            mountPath: /var/www/html
        ports:
            - containerPort: 8092
    ```

    Copy `index.php` to target container:
    ```
    $ kubectl cp /opt/index.php nginx-phpfpm:/var/www/html/ -c nginx-container
    ```

    Finally, apply all spec:
    ```
    $ kuberctl apply -f .
    ```


Before clicking on `finish` button always make sure to check if all pods are in `running` state.


You can use any labels as per your choice.

`Note`: The `kubectl` utility on `jump_host` has been configured to work with the kubernetes cluster.
