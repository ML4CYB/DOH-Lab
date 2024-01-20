LAB: DoH vs non-DoH Packet Capture

1. Some Import Information Before You Start
The Domain Name System: Simplifying Networking:

The Domain Name System (DNS) emerged in the early 1980s to streamline networking processes. During the late 1960s and 1970s, the initial networks, like ARPANET, comprised a small number of hosts—only four nodes in ARPANET's case. However, as the 1980s approached, the surge in network users made remembering IP addresses a cumbersome task.

Before the creation of DNS, a straightforward text file named "HOSTS.txt" was used to map all existing sites. With the mounting need for a more efficient system to simplify networking, the concept of DNS was born.

DNS essentially associates names with various internet resources and stores this information in servers known as domain name servers. Every time you access a new website, you are essentially communicating with one of these servers, even though it may go unnoticed. This ingenious system enables users to input user-friendly names like "amazon.com" instead of the more intricate IP addresses such as "127.0.0.1"

Moreover, DNS servers not only store IP addresses but also house other crucial pieces of information, such as Start of Authority (SOA) records, mail exchanges, name servers, and more. Each piece of information is intricately linked to a specific name.
 

Hypertext Transfer Protocol (HTTP): A Cornerstone of the World Wide Web

Hypertext Transfer Protocol (HTTP) came into existence during the early 1990s, marking a pivotal moment in networking history, especially with the advent of the World Wide Web. HTTP was designed to facilitate the exchange of information over the internet, essentially becoming the backbone of web communication.

The inaugural version of HTTP was incredibly simplistic by today's standards. It primarily utilized GET commands to retrieve information from external servers, with the response typically delivered in a plain text format. During this phase, HTTP lacked the extensive elements we now consider standard, such as HTTP headers, footers, status codes, and error codes.

Fast forward to the present, and HTTP has become the cornerstone of internet communication. Its applications have diversified, encompassing information retrieval, data exchange, and even real-time updates of web pages. The ubiquity of HTTP within the internet landscape firmly establishes its enduring presence, ensuring its continued prominence as long as the internet persists.

Domain Name Resolution with HTTP (DoH): Enhancing Privacy and Security

Domain Name over HTTP (DoH) represents a modern approach to conducting DNS lookups. Unlike traditional DNS lookups that employ the DNS protocol, DoH utilizes HTTP for these queries. This shift not only streamlines the process but also introduces a significant privacy advantage. By integrating DNS functionality into the HTTP protocol, DoH makes it exceptionally challenging for potential attackers or eavesdroppers to intercept and interpret the transmitted information.
The heightened privacy is a direct result of HTTP's encryption of data between the DNS client and the DNS resolver. This encryption renders the transmitted data indecipherable to anyone attempting to capture and inspect network contents.
Introduced in 2017, DoH has experienced remarkable growth. Many popular web browsers have swiftly incorporated support for DoH, underscoring its increasing adoption and acknowledgment within the digital landscape.


Transmission Control Protocol (TCP): A Fundamental Networking Protocol:

The Transmission Control Protocol (TCP) stands as one of the most pervasive networking protocols in use today. Initially conceived in the 1970s, TCP was designed to work in tandem with the Internet Protocol (IP), which eventually became the foundational protocol of the modern internet. In the early 1980s, another significant IP protocol, the User Datagram Protocol (UDP), was introduced and gained widespread use.

TCP distinguishes itself from UDP—the User Datagram Protocol—by being a connection-oriented protocol. In this context, a connection is established only when both parties involved initiate it. The connection initiation process follows a three-way handshake: the host wishing to commence the connection sends a synchronization (SYN) message to the intended host, which responds with a synchronized acknowledgment (SYN/ACK) message. This exchange signifies their mutual intent to establish a connection. Subsequently, the initial host acknowledges (ACK) the message, completing the handshake, and enabling the exchange of messages between the two hosts.

Moreover, TCP incorporates error correction mechanisms, unlike UDP. If a packet is received in a damaged state or does not arrive at all, the receiving host refrains from sending an acknowledgment (ACK) message. Consequently, the sending host retransmits the packet, ensuring data integrity. However, this inherent error correction capability comes at the cost of speed, making TCP relatively slower than IP. As a result, TCP is primarily utilized for data transmission scenarios where a slight delay in the order of seconds is imperceptible, such as in email exchanges or large file downloads. Conversely, for real-time applications like video conferencing or live TV streaming, where minimizing lag is crucial, other protocols like UDP are favored over TCP.

Understanding TCPdump: Capturing and Analyzing Network Traffic:

TCPdump is a command-line utility that allows you to capture and analyze network traffic flowing into and out of your system. This tool is a valuable asset for network administrators, aiding in troubleshooting network-related issues by providing insights into the traffic exchanged by a device.

When you run the TCPdump command, it displays information about the traffic entering and exiting your device. This information can be presented directly on the screen or saved into a file. The utility offers several flags to customize the data capture, allowing you to specify what data to capture, how many packets to capture, and whether to write it into a file.

In addition to flags, TCPdump supports filter expressions, enabling you to collect specific data based on predefined criteria. Here are some common flags and filter expressions to enhance your usage:
- -i eth0: Captures packets from the eth0 interface.
- -c <number of packets>: Specifies the number of packets to capture.
- -w <filename>: Writes the captured packets into a file.
- tcp: Captures only TCP packets.
- -v: Increases the verbosity level of the output, providing more detailed information for each packet. You can use it up to 3 times (e.g., -vvv) for even more detailed output.





2. Laboratory Instructions: Capturing and Analyzing DoH and non-DoH Packets

Overview:
Now that you have gained an understanding of DNS, HTTP, DoH, and TCP dumps, let's proceed to the lab. Here, you'll capture packets into a .pcap file and analyze them using the doHlyzer tool, which will generate a .csv file for further analysis.

Beginning the lab 
The lab starts from the Labtainer working directory on your Linux host, e.g., a Linux VM. From there, issue the command: From your labtainer-student directory start the lab using:

labtainer <fill in lab name> 

The resulting virtual terminal is connected to a client computer.


Tasks
a.	Navigate to the DNS_testing/inc directory

Use the change directory command “cd” to navigate to the DNS_testing/inc directory.


b.	Take a look at your directory.
Use the -ls command to list the contents of the directory. You'll notice several files, including:

   - packetGeneration.py: This script generates internet traffic.
   - add-labels.py: This script appends labels (doH or non-doH) to each packet.

c.) Download Necessary Libraries and Software

In this section, you will acquire several essential libraries required for this lab.
1. Download tcpdump:
Execute the following command to obtain tcpdump, a software tool that will be used to  capture network traffic:
sudo apt-get install tcpdump
This will install tcpdump, which will capture the packets being produced by the packetGeneration.py script.

2. Download Google Chrome:
While the graphic interface won't be utilized in this lab, Google Chrome will run in the background alongside chromedriver for performing lookups and generating packets. Execute the following three commands:
wget https://dl.google.com/linux/direct/google-chrome-stable_current_amd64.deb
sudo dpkg -i google-chrome-stable_current_amd64.deb
sudo apt-get install -f
These commands fetch the Google Chrome installation file, download it into your lab environment, repackage the file, and install it onto your system.

3. Install Selenium and Requests Libraries:
These libraries enable the Python script to perform GET requests and conduct website lookups. Execute the following commands:

pip install selenium
pip install selenium requests

Ensure you follow these steps to set up the necessary components for the upcoming lab exercises.


d.	Execute the TCP dump command to capture packets and run the Python script in the background using the & command.

python3 packetGeneration.py & pid=$! && sudo tcpdump -i eth0 -vvv -s0 -n -c10000 port 443 and tcp -w DNS_Packets.pcap -Z root && kill $pid

Note the flags being used, such as -i for interface, -w for writing to a .pcap file, and -n for capturing packets on port 443.


e.	 Once done run  -ls again to see a new file.
You will notice a new file

DNS_Packets.pcap

in the directory. This file stores the captured packet information.


f.	Pass the DNS_Packets.pcap file through doHlyzer
Use the following command:

dohlyzer -f DNS_Packets.pcap -c capturedPackets.csv

Here, -f specifies the input file, and -c specifies the output .csv file.


g.	Run  -ls again to see a new .csv file.
Once doHlyzer completes its analysis, you'll find a file named 

capturedPackets.csv

in the directory. This file presents the packet information in a more readable .csv format.


h.	Execute Script:
Execute the

python3 add-labels.py

 script to append labels to each row in the capturedPackets.csv file:
Place in 

  capturedPackets.csv
  
as the input and

 	labeledPackets.csv
  
as the output


i.	Export the .csv file from the lab to host machine.
Now it’s time for you to export the .csv file from the lab to the host machine for further viewing.

You can export the .csv file use this command

scp labeledPackets.csv student@172.17.0.1:.

You will be prompted to enter a password. Just enter
password123
and the .csv file should be exported from the lab to the host machine.


j.	Exit the program
To exit the program, use the ‘stoplab <labname>’ command in the terminal you previously opened. Next, navigate to the files icon located on the left side of your screen. This action will display a directory containing all the files within the host machine. Locate the 'labeledPackets.csv' file you imported during the lab; it should be easily accessible in your home directory.

Double-click on the '.csv' file to open it. Inside, you'll find a comprehensive collection of packet information captured via tcpdump. This includes details such as the source and destination IP addresses, source and destination ports, packet length, duration of travel, and various other packet-related information. Take a moment to explore this data. Towards the end of the list, you'll notice a column labeled 'label,' displaying values as either 'non-doh' or 'doh.' This column indicates whether the packets sent or received were using the DoH (DNS over HTTPS) protocol or the standard non-DoH protocol


k.	Submit .xfer file to Canvas
There will be a file created on the Desktop: labtainer xfer. Go to Desktop → labtainer xfer → <labname> and upload that file to Canvas as part of your single zip file explained above. For example, mine was called uludag at umich.edu.<labname>.lab.

 

Figure 2: File name to include in the zip file to submit to Canvas for the Wireshark-Intro Lab. Please do not rename your .lab file name!
