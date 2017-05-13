sleep 1
docker -H [[HOST_IP]]:2345 swarm init
token=$(docker -H [[HOST_IP]]:2345 swarm join-token -q worker)
docker -H [[HOST2_IP]]:2345 swarm join [[HOST_IP]]:2377 --token $token
ssh root@host01 mkdir -p /host/data
docker -H [[HOST_IP]]:2345 pull portainer/portainer
