docker -H [[HOST_IP]]:2345 swarm init
token=$(docker -H [[HOST_IP]]:2345 swarm join-token -q worker)
docker -H tcp://[[HOST2_IP]]:2345 swarm join [[HOST_IP]]:2377 --token $token
docker -H [[HOST_IP]]:2345 run -d -p 9000:9000 portainer/portainer -H tcp://[[HOST_IP]]:2377
