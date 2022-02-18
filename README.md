# pcap-files
Capture network data with pcap files

# Pre-requirements
- [vagrant](https://www.vagrantup.com/downloads)
- [virtualbox](https://www.virtualbox.org/) 

# Tools
- [tcpdump](https://www.tcpdump.org/)
- [tshark](https://www.wireshark.org/docs/man-pages/tshark.html)
# How to use

clone the repository

```
git clone git@github.com:equinix-metal-use-cases/pcap-files.git
cd pcap-files
```

run virtual machine 

```
vagrant up --provider virtualbox
```

login to virtualbox

```
vagrant ssh
```

## capture the data on the interface

check what is the name of the interface

```
ip addr
```

you should see the similar output

```
vagrant@pcap:~$ ip addr
1: lo: <LOOPBACK,UP,LOWER_UP> mtu 65536 qdisc noqueue state UNKNOWN group default qlen 1000
    link/loopback 00:00:00:00:00:00 brd 00:00:00:00:00:00
    inet 127.0.0.1/8 scope host lo
       valid_lft forever preferred_lft forever
    inet6 ::1/128 scope host
       valid_lft forever preferred_lft forever
2: enp0s3: <BROADCAST,MULTICAST,UP,LOWER_UP> mtu 1500 qdisc fq_codel state UP group default qlen 1000
    link/ether 08:00:27:b8:51:28 brd ff:ff:ff:ff:ff:ff
    inet 10.0.2.15/24 brd 10.0.2.255 scope global dynamic enp0s3
       valid_lft 86218sec preferred_lft 86218sec
    inet6 fe80::a00:27ff:feb8:5128/64 scope link
       valid_lft forever preferred_lft forever
3: enp0s8: <BROADCAST,MULTICAST,UP,LOWER_UP> mtu 1500 qdisc fq_codel state UP group default qlen 1000
    link/ether 08:00:27:2a:c7:6b brd ff:ff:ff:ff:ff:ff
    inet 192.168.178.69/24 brd 192.168.178.255 scope global enp0s8
       valid_lft forever preferred_lft forever
    inet6 fe80::a00:27ff:fe2a:c76b/64 scope link
       valid_lft forever preferred_lft forever
```

you can run this simple loop on the host machine to generate the traffic for the running `nginx` server

```bash
for i in {1..100}; do curl http://192.168.178.69 &> /dev/null; sleep 1; echo "curl http://192.168.178.69 ${i}"; done
```

capture traffic on particular interface with `-i` option

```bash
sudo tcpdump -i enp0s8
sudo tshark -i enp0s8
```

capture all icmp traffic

```
sudo tcpdump -i enp0s8 icmp
sudo tshark -i enp0s8 icmp
```

capture traffic on port 

```
sudo tcpdump -i enp0s8 port 80
sudo tshark -i enp0s8 port 80
```

write the capture to the file, use `-s0` will set size of packet to capture to unlimited. use this if you want to capture all the traffic.

```
sudo tcpdump -i enp0s8 -s0 -w test.pcap
sudo tshark -i enp0s8 -s0 -w test.pcap
```

read the captured files

```
sudo tcpdump -r test.pcap
sudo tshark -r test1.pcap
```