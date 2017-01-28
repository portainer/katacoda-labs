echo "echo 'Starting Kontena cluster...'" >> launch.sh
echo "for i in {1..20}; do docker-compose -f /opt/master.yml up -d > /dev/null 2>&1 && break || sleep 1; done" >> launch.sh
echo "echo 'Waiting for Kontena cluster... This may take a few moments'" >> launch.sh
echo 'until $(curl master &> /dev/null); do' >> launch.sh
echo '  sleep 1' >> launch.sh
echo 'done' >> launch.sh
echo "for i in {1..20}; do  kontena master login --name CompanyMasterCluster --code loginwiththiscodetomaster http://master > /dev/null 2>&1 && break || sleep 1; done" >> launch.sh
echo "kontena grid create --initial-size=1 prod &> /dev/null" >> launch.sh
echo "TOKEN=\$(kontena grid show --token prod) && sudo sed -i \"s|\\\$TOKEN|\$TOKEN|\" /opt/node.yml && sudo sed -i 's/master/[[HOST_IP]]/' /opt/node.yml" >> launch.sh
echo "docker-compose -H tcp://agent01:2345 -f /opt/node.yml up -d" >> launch.sh
echo "echo 'Cluster started.'" >> launch.sh
chmod +x launch.sh
mv launch.sh /opt/launch.sh
curl -L https://gist.githubusercontent.com/BenHall/523f2beaf299e9d9a02bff34372e239d/raw/c2393cca9af78b633bd7526cccf76b65cdf5037a/master.yml -o /opt/master.yml
curl -L https://gist.githubusercontent.com/BenHall/523f2beaf299e9d9a02bff34372e239d/raw/c2393cca9af78b633bd7526cccf76b65cdf5037a/node-katacoda.yml -o /opt/node.yml
echo 'address=/tutorial-wordpress.grid1.kontena.local/[[HOST2_IP]]' >> /etc/dnsmasq.conf
echo 'address=/www.kontena.local/[[HOST2_IP]]' >> /etc/dnsmasq.conf
echo 'address=/kontena.local/[[HOST2_IP]]' >> /etc/dnsmasq.conf
echo 'nameserver 127.0.0.1' > /etc/resolv.conf
echo 'search kontena.local' >> /etc/resolv.conf
echo 'nameserver 8.8.8.8' >> /etc/resolv.conf
echo "version: '2'" >> kontena.yml
echo 'services:' >> kontena.yml
echo '  internet_lb:' >> kontena.yml
echo '    image: kontena/lb:latest' >> kontena.yml
echo '    ports:' >> kontena.yml
echo '      - 80:80' >> kontena.yml
echo '  web1:' >> kontena.yml
echo '    image: katacoda/docker-http-server:v1' >> kontena.yml
echo '    environment:' >> kontena.yml
echo '      - KONTENA_LB_MODE=http' >> kontena.yml
echo '      - KONTENA_LB_BALANCE=roundrobin' >> kontena.yml
echo '      - KONTENA_LB_INTERNAL_PORT=80' >> kontena.yml
echo '      - KONTENA_LB_VIRTUAL_HOSTS=www.kontena.local,kontena.local' >> kontena.yml
echo '    links:' >> kontena.yml
echo '      - internet_lb' >> kontena.yml
nohup dnsmasq &
