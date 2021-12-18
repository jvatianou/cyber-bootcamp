# Network Topology for Webservers, Jump Box and ELK box

## Resource Group
One resource group created for the entire project.

## Linux OS
Ubuntu 18.04 LTS

## Containers

Webservers:  DVWA
Jump box:  Ansible
ELK box:  ELK

## Networks
Two networks and two subnets are available in the resource group, each network controlled by its own Network Security Group.

Webserver and provision box:  10.0.0.0/16

Monotiring network:  10.1.0.0/16

## Provision box
Private IP:  10.0.0.4

## Webservers
Subnet:  10.0.0.0/24
 
Public IP of Load balancer:  20.124.104.98
Private IP of web1:  10.0.0.5
Private IP of web-2:  10.0.0.6
Private IP of web3: 10.0.0.7
 
Private IP of jump:  10.0.0.4
Public IP of jump:  20.124.33.249 (static)

## ELK 

Subnet for ELK:  10.1.0.0/24
 
Private IP of elk-box:  10.1.0.5
Public IP of Kibana:  40.122.198.139

