#!/bin/sh

iptables -F


# on autorise les connexions deja etablies
iptables -A INPUT -m state --state ESTABLISHED,RELATED -j ACCEPT
iptables -A OUTPUT -m state --state ESTABLISHED,RELATED -j ACCEPT

# on change d'abord les politiques pour les connexions
#entrantes et sortantes et les paquets rediriges aussi
iptables -P OUTPUT DROP
iptables -P INPUT DROP
iptables -P FORWARD DROP

#autorisons le loupback
iptables -A INPUT -i lo -j ACCEPT
iptables -A OUTPUT -o lo -j ACCEPT

#SSH
iptables -A INPUT -p tcp --dport 2006 -j ACCEPT
iptables -A OUTPUT -p tcp --dport 2006 -j ACCEPT

# HTTP(S)
iptables -A OUTPUT -p tcp --dport 80 -j ACCEPT
iptables -A OUTPUT -p tcp --dport 443 -j ACCEPT
iptables -A INPUT -p tcp --dport 80 -j ACCEPT
iptables -A INPUT -p tcp --dport 443 -j ACCEPT

# DNS
iptables -A OUTPUT -p tcp --dport 53 -j ACCEPT
iptables -A OUTPUT -p udp --dport 53 -j ACCEPT
iptables -A INPUT -p tcp --dport 53 -j ACCEPT
iptables -A INPUT -p udp --dport 53 -j ACCEPT

#  limiter  DoS a 3 tentatives sur le port ssh 
iptables -A INPUT -p tcp --syn --dport 2006 -m connlimit ! --connlimit-above 3 -j ACCEPT

# NTP (pour avoir une horloge locale synchronisee avec une reference d'heure)
iptables -A OUTPUT -p udp --dport 123 -j ACCEPT

iptables -A INPUT -j LOG
iptables -A FORWARD -j LOG

