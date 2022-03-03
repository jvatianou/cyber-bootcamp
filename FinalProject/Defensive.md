# Blue Team: Summary of Operations

## Table of Contents
- Network Topology
- Description of Targets
- Monitoring the Targets
- Patterns of Traffic & Behavior
- Suggestions for Going Further

### Network Topology

The following vulnerable machines were identified on the network:
- Name of VM 1
  - **Operating System**:  Debian Linux
  - **Purpose**:  Wordpress
  - **IP Address**:  192.168.1.110
- Name of VM 2
  - **Operating System**:  Debian Linux
  - **Purpose**:  Wordpress
  - **IP Address**:  192.168.1.115


### Description of Targets

The target of this attack was: `Target 1` (192.168.1.110)

Target 1 is an Apache web server and has SSH enabled, so ports 80 and 22 are possible ports of entry for attackers. As such, the following alerts have been implemented.

PORT    STATE SERVICE     VERSION
22/tcp  open  ssh         OpenSSH 6.7p1 Debian 5+deb8u4 (protocol 2.0)
80/tcp  open  http        Apache httpd 2.4.10 ((Debian))


### Monitoring the Targets

Traffic to these services should be carefully monitored. To this end, we have implemented the alerts below:

#### Name of Alert 1

Alert 1 is implemented as follows:
  - **Metric**: Sum of HTTP bytes
  - **Threshold**: Above 3000 bytes
  - **Vulnerability Mitigated**:  Code injection
  - **Reliability**: Possibility that an attacker can use small requests to brute-force.  Medium reliability.
  - **Alert**: In practice for production, this would be setup to notify a Slack channel.

#### Name of Alert 2
Alert 2 is implemented as follows:
  - **Metric**: CPU Alert
  - **Threshold**: Anytime system CPU processing is above 0.5
  - **Vulnerability Mitigated**: Malicious code
  - **Reliability**: Highly reliable way to verify that no unwanted code is running on the machine.  0.5 is a relatively small percentage of CPU on a server.
  - **Alert**: In practice for production, this would be setup to notify a Slack channel.

#### Name of Alert 3
Alert 3 is implemented as follows:
  - **Metric**: HTTP 400 Codes
  - **Threshold**: Top 5 alerts are for HTTP codes over 400
  - **Vulnerability Mitigated**: Brute-force
  - **Reliability**: Highly reliable for treating brute-force attacks.
  - **Alert**: In practice for production, this would be setup to notify a Slack channel.
