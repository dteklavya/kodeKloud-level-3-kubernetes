We need to deploy a Drupal application on Kubernetes cluster. The Nautilus application development team want to setup a fresh Drupal as they will do the installation on their own. Below you can find the requirements, they have shared with us.



1) Configure a persistent volume `drupal-mysql-pv` with `hostPath = /drupal-mysql-data` (`/drupal-mysql-data` directory already exists on the worker Node i.e jump host), `5Gi` of storage and ReadWriteOnce access mode.

    ```
    apiVersion: v1 
    kind: PersistentVolume 
    metadata:
        name: drupal-mysql-pv # Make sure matches with requirement
        labels:
            type: local
    spec:
        storageClassName: standard       
        capacity:
            storage: 5Gi # Important
        accessModes:
            - ReadWriteOnce 
        hostPath:                       
            path: "/drupal-mysql-data"
        persistentVolumeReclaimPolicy: Retain
    ```


2) Configure one PersistentVolumeClaim named `drupal-mysql-pvc` with storage request of `3Gi` and ReadWriteOnce access mode.
    ```
    apiVersion: v1 
    kind: PersistentVolumeClaim # Important, the type of object
    metadata:                          
        name: drupal-mysql-pvc # Again, must match with spec
        labels:
            app: mysql-app 
    spec:                              
        storageClassName: standard       
        accessModes:
            - ReadWriteOnce             
        resources:
            requests:
                storage: 3Gi # Spec!
    ```


3) Create a deployment `drupal-mysql` with `1` replica, use `mysql:5.7` image. Mount the claimed PVC at `/var/lib/mysql`.
    
    First create secrets that'll be used by MySQL spec:

    ```
    $ kubectl create secret generic mysql-root-pass \
      --from-literal=password=YUIidhb667
    $ kubectl create secret generic mysql-user-pass \
      --from-literal=username=kodekloud_cap \
      --from-literal=password=ksH85UJjhb
    $ kubectl create secret generic mysql-db-url \
      --from-literal=database=kodekloud_db2
    ```

    ```
    apiVersion: apps/v1 
    kind: Deployment                    
    metadata:
        name: drupal-mysql           
        labels:                         
            app: mysql-app   
    spec:
        replicas: 1
        selector:
            matchLabels:                  
                app: mysql-app 
                tier: mysql 
        strategy:
            type: Recreate 
        template:         
            metadata:
            labels:        
                app: mysql-app
                tier: mysql
            spec:            
                containers:
                - image: mysql:5.7
                    name: mysql
                    env:
                    - name: MYSQL_ROOT_PASSWORD
                    valueFrom:
                        secretKeyRef:
                            name: mysql-root-pass
                            key: password
                    - name: MYSQL_DATABASE
                    valueFrom:
                        secretKeyRef:
                            name: mysql-db-url 
                            key: database
                    - name: MYSQL_USER
                    valueFrom:
                        secretKeyRef:
                            name: mysql-user-pass 
                            key: username
                    - name: MYSQL_PASSWORD
                    valueFrom:
                        secretKeyRef:
                            name: mysql-user-pass 
                            key: password
                    ports:
                    - containerPort: 3306              
                    name: mysql
                    volumeMounts:
                    - name: mysql-persistent-storage  
                      mountPath: /var/lib/mysql
                volumes:                        
                - name: mysql-persistent-storage
                  persistentVolumeClaim: 
                    claimName: drupal-mysql-pvc
    ```


4) Create a deployment `drupal` with `1` replica and use `drupal:8.6` image.
    ```
    apiVersion: apps/v1 
    kind: Deployment                    
    metadata:
        name: drupal
        labels:                         
            app: drupal-app
    spec:
    replicas: 1
    selector:
        matchLabels:                  
            app: drupal-app 
            tier: drupal-back-end
    strategy:
        type: Recreate 
    template:         
        metadata:
            labels:        
                app: drupal-app
                tier: drupal-back-end
        spec:            
            containers:
            - image: drupal:8.6
              name: drupal
              ports:
              - containerPort: 80              
              name: drupal
    ```


4) Create a NodePort type service which should be named as `drupal-service` and nodePort should be `30095`.
    ```
    apiVersion: v1                    
    kind: Service                      
    metadata:
        name: drupal-service     
        labels:             
            app: drupal-app  
    spec:
        type: NodePort
        ports:
            - targetPort: 80
            port: 80
            nodePort: 30095
        selector:                       
            app: drupal-app
            tier: drupal-back-end
    ```


5) Create a service drupal-mysql-service to expose mysql deployment on port 3306.
    ```
    apiVersion: v1                    
    kind: Service                      
    metadata:
        name: drupal-mysql-service         
        labels:             
            app: mysql-app  
    spec:
        type: NodePort
        ports:
            - targetPort: 3306
            port: 3306
            nodePort: 30096
        selector:                       
            app: mysql-app
            tier: mysql
    ```


6) Set rest of the configration for deployments, services, secrets etc as per your preferences. At the end you should be able to access the Drupal installation page by clicking on App button.


Note: The kubectl on jump_host has been configured to work with the kubernetes cluster.