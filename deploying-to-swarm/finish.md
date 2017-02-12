This scenario described how to get started with Portainer and use it to manage a container host or Swarm cluster.

Run Portainer on your Docker host using:

`docker run -d -p 9000:9000 --name=portainer \
  -v "/var/run/docker.sock:/var/run/docker.sock" \
  -v /host/data:/data \
  portainer/portainer`

Learn more at http://portainer.io/
