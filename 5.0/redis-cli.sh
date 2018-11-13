#!/bin/bash                                                                                                                                                                                                                        
host_ip=$(ip route | awk '/default/ { print $9 }')
sudo docker exec -it redis redis-cli -a xs1h -h ${host_ip} -c