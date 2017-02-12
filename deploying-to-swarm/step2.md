With the cluster configured, the next stage is to deploy Portainer.

Portainer is deployed as a container running on a Docker host or Docker Swarm cluster. This can be done in two ways:

## Deploy as Container

The first way is to deploy Portainer as a container running on a Docker Host. In this case, the command exposes the Portainer dashboard on port _9000_, persists data to the host and connects to the Docker host it's running on.

`docker run -d -p 9000:9000 --name=portainer \
  -v "/var/run/docker.sock:/var/run/docker.sock" \
  -v /host/data:/data \
  portainer/portainer`

Alternatively, if you’re using swarm mode as we are, you can also deploy Portainer as a service in your cluster.

## Deploy as Swarm Service

By deploying as a Docker Service, Swarm will ensure that the service is always running on a manager, even if the host goes down.

The service has the same configuration as a single container, with an added constraint that it only runs on a manager node.

```
docker service create \
    --name portainer \
    --publish 9000:9000 \
    --constraint 'node.role == manager' \
    --mount type=bind,src=/host/data,dst=/data \
    portainer/portainer \
    -H tcp://[[HOST_IP]]:2377
```{{execute HOST1}}
