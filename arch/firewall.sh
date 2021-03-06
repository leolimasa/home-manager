iptables -P FORWARD DROP
iptables -P OUTPUT ACCEPT
iptables -P INPUT DROP

iptables -A INPUT -m conntrack --ctstate RELATED,ESTABLISHED -j ACCEPT
iptables -A INPUT -i lo -j ACCEPT

# Drop invalid packets
iptables -A INPUT -m conntrack --ctstate INVALID -j DROP

# Allow ping
iptables -A INPUT -p icmp --icmp-type 8 -m conntrack --ctstate NEW -j ACCEPT

# Chromecast
chromecast_mac=48:b0:2d:31:aa:e2
iptables -A INPUT -m mac --mac-source $chromecast_mac -p tcp --dports 8008:8009 -j ACCEPT
iptables -A INPUT -m mac --mac-source $chromecast_mac -p udp --dport 32768:61000 -j ACCEPT


# TODO open ports for print discovery
# TODO add support for a graphical firewall

iptables-save -f /etc/iptables/iptables.rules
systemctl enable iptables
