There are some applications that need to be deployed on Kubernetes cluster and these apps have some pre-requisites where some configurations need to be changed before deploying the app container. Some of these changes cannot be made inside the images so the DevOps team has come up with a solution to use init containers to perform these tasks during deployment. Below is a sample scenario that the team is going to test first.



1. Create a `Deployment` named as `ic-deploy-nautilus`.


2. Configure `spec` as replicas should be `1`, labels `app` should be `ic-nautilus`, template's metadata lables `app` should be the same `ic-nautilus`.


3. The `initContainers` should be named as `ic-msg-nautilus`, use image `fedora`, preferably with `latest` tag and use command `'/bin/bash'`, `'-c'` and `'echo Init Done - Welcome to xFusionCorp Industries > /ic/official'`. The volume mount should be named as `ic-volume-nautilus` and mount path should be `/ic`.


4. Main container should be named as `ic-main-nautilus`, use image `fedora`, preferably with `latest` tag and use command `'/bin/bash'`, `'-c'` and `'while true; do cat /ic/official; sleep 5; done'`. The volume mount should be named as `ic-volume-nautilus` and mount path should be `/ic`.


5. Volume to be named as `ic-volume-nautilus` and it should be an `emptyDir` type.


`Note`: The `kubectl` utility on `jump_host` has been configured to work with the kubernetes cluster.