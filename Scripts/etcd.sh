
export PUBLIC_IP=54.191.254.133

sudo docker run -d -p 8005:8005 -p 5005:5005 quay.io/coreos/etcd:v0.4.6 -peer-addr ${PUBLIC_IP}:8005 -addr ${PUBLIC_IP}:5005 -name etcd-node1

sudo docker run -d -p 8002:8002 -p 5002:5002 quay.io/coreos/etcd:v0.4.6 -peer-addr ${PUBLIC_IP}:8002 -addr ${PUBLIC_IP}:5002 -name etcd-node2 -peers ${PUBLIC_IP}:8005,${PUBLIC_IP}:8002,${PUBLIC_IP}:8003

sudo docker run -d -p 8003:8003 -p 5003:5003 quay.io/coreos/etcd:v0.4.6 -peer-addr ${PUBLIC_IP}:8003 -addr ${PUBLIC_IP}:5003 -name etcd-node3 -peers ${PUBLIC_IP}:8005,${PUBLIC_IP}:8002,${PUBLIC_IP}:8003

sudo docker run -p 3306:3306  --name mysql2 -e MYSQL_ROOT_PASSWORD=123 -d mysql/mysql-server:5.7

