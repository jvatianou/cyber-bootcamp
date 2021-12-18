# cyber-bootcamp
###Scripts, playbooks, documentation, and diagrams for Security Bootcamp

This public repository contains diagrams, Ansible playbooks and some random Linux configurations as part of Notherwestern's Cybersecurity Bootcamp, taken in the Fall and Winter of 2021-22.  

The project being described here is a full-fledged webserver setup behind a load balancer, with an ELK stack to monitor it.  The entire deployment is within an Azure resource group.  A provision box is setup the provision both the webservsers and the ELK box.  Because the webservers are insecure, rules are in place allowing access from only one public IP.

##Directories
### Linux
Houses any scripts or configurations worked on in the class

### Ansible
Houses any configurations, hosts files, and playbooks related to Ansible classes

### Diagram
Contains a diagram of the webserver and ELK deployment in Azure
 
###Network Rules

| Source IP	| Source Port	| Protocol	| Destination	|
|-----------|-------------|-----------|-------------|
| Admin Public IP	| 80	| TCP	| Jump Box Public IP|

