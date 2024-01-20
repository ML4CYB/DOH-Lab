#!/bin/bash

#-----------------------------------------------------------------------------------
# This shell script automates the packetGeneration and tcpdump processes by
# concurrently running both scripts. It generates and captures packets,
# subsequently storing them in a .pcap file. Once the tcpdump operation completes,
# the system will issue a signal to terminate the packet generation script.
#-----------------------------------------------------------------------------------
python3 packetGeneration.py & python_pid=$!

echo Loading...

sleep 15

tcpdump -i eth0 -vvv -s0 -n -c20000 port 443 and tcp -w DNS_Packets.pcap

kill $python_pid



