## Initialize

`docker swarm init`{{execute HOST1}}

## Join

`token=$(docker -H [[HOST_IP]]:2345 swarm join-token -q worker) && echo $token`{{execute HOST2}}

`docker swarm join [[HOST_IP]]:2377 --token $token`{{execute HOST2}}
