for i in {1..20}; do docker -H [[HOST_IP]]:2345 swarm init && break || sleep 1; done
token=$(docker -H [[HOST_IP]]:2345 swarm join-token -q worker)
docker -H [[HOST2_IP]]:2345 swarm join [[HOST_IP]]:2377 --token $token
docker -H [[HOST_IP]]:2345 pull portainer/portainer
