# Network Forensic Analysis Report

## Time Thieves
You must inspect your traffic capture to answer the following questions:

1. What is the domain name of the users' custom site?  frank-n-ted-DC.frank-n-ted.com
2. What is the IP address of the Domain Controller (DC) of the AD network?  10.6.12.12
3. What is the name of the malware downloaded to the 10.6.12.203 machine?  june11.dll
4. Upload the file to [VirusTotal.com](https://www.virustotal.com/gui/).
5. What kind of malware is this classified as?  Trojan.

---

## Vulnerable Windows Machine

1. Find the following information about the infected Windows machine:
    - Host name  ROTTERDAM-PC
    - IP address  172.16.4.205
    - MAC address  00:59:07:b0:63:a4

    Used the filters:  
    ip.src==172.16.4.4
    ip.dest==172.16.4.205 or ip.src==172.16.4.205

2. What is the username of the Windows user whose computer is infected?  unavailable through the provided PCAP file.

3. What are the IP addresses used in the actual infection traffic?  

Performed a statistics check on the 172.16.4.205 address, sorted by packets and found that the IP with the most traffic are 172.16.4.204, 185.243.115.84 and 166.62.111.64.

---

## Illegal Downloads

1. Find the following information about the machine with IP address `10.0.0.201`:
    - MAC address  00:16:17:18:66:c8
    - Windows username:  elmer.blanco
    - Host name:  BLANCO-DESKTOP

    Used the filter of

    ip.addr == 10.0.0.201 and http.request.method == GET

    then manually searched the info field for any torrents.

2. Which torrent file did the user download?  Betty_Boop_Rythm_on_the_Reservation.avi.torrent
