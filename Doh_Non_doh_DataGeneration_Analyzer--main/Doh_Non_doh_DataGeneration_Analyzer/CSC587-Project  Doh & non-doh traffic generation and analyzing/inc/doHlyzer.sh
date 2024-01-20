#! bin/bash

 #-----------------------------------------------------------------
 # This shell script automates the doHlyzer process by executing the
 # dohlyzer program and storing the output in a .csv file. Once the
 # dohlyzer operation completes, the system will issue a signal to
 # terminate the dohlyzer program. After that it will run the python
 # script to add labels (DoH or non-DoH) to the csv file.
#-----------------------------------------------------------------

dohlyzer -f DNS_Packets.pcap -c capturedPackets.csv
python3 add-labels.py