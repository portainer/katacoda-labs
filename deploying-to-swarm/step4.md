One of the many features of Portainer is it's available to deploy services based on pre-defined containers.

![](https://katacoda.com/portainer/assets/deploying-to-swarm/step4-1.png)

## Task - Deploy nginx

In this case you will deploy the nginx template.

1) Visit the _App Templates_ [tab](https://[[HOST_SUBDOMAIN]]-9000-[[KATACODA_HOST]].environments.katacoda.com/#/templates) to view the available templates.

2) Select the **nginx** template

3) Enter a friendly name for the container, for example `nginx-web`{{copy}}

4) Select _Show advanced options_ and bind port 80 to the host port 80.

5) Create the container

6) Visit the newly deployed container on [port 80](https://[[HOST_SUBDOMAIN]]-80-[[KATACODA_HOST]].environments.katacoda.com)
