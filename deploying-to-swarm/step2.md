With the cluster configured, the next stage is to deploy Portainer. Portainer is deployed as a container running on a Docker Swarm cluster or a Docker host.

## Task: Deploy as Swarm Service

To complete this scenario, deploy Portainer as a Docker Service. By deploying as a Docker Service, Swarm will ensure that the service is always running on a manager, even if the host goes down.

The service exposes the port _9000_ and stores the internal Portainer data in the directory _/host/data_. When Portainer starts, it connects over tcp to the Docker Swarm Host, in this running on port _2345_. This port may vary should be kept secure and not exposed publicly.

There is an added constraint that the container should only run on a manager node.

```
docker service create \
    --name portainer \
    --publish 9000:9000 \
    --constraint 'node.role == manager' \
    --mount type=bind,src=/host/data,dst=/data \
    portainer/portainer \
    -H tcp://[[HOST_IP]]:2345
```{{execute HOST1}}

## Deploy as Container

An alternative way of running Portainer is directly on a host. In this case, the command exposes the Portainer dashboard on port _9000_, persists data to the host and connects to the Docker host it's running on via the _docker.sock_ file.

`docker run -d -p 9000:9000 --name=portainer \
  -v "/var/run/docker.sock:/var/run/docker.sock" \
  -v /host/data:/data \
  portainer/portainer`
