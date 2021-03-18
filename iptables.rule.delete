
# iptables -t filter -P FORWARD DROP

iptables -t filter -D FORWARD -j ACCEPT
#iptables -D FORWARD -j ACCEPT

iptables -t nat -D POSTROUTING -s 10.181.0.0/24 -o eth0 -j MASQUERADE
iptables -t nat -D POSTROUTING -s 10.182.0.0/24 -o eth0 -j MASQUERADE
iptables -t nat -D POSTROUTING -s 10.183.0.0/24 -o eth0 -j MASQUERADE
iptables -t nat -D POSTROUTING -s 10.184.0.0/24 -o eth0 -j MASQUERADE

