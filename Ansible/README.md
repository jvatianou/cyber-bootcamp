# Ansible Playbooks and Configurations

`ansible.cfg`
Ansible configuration file

`elk.yml`
Ansible playbook for ELK server

`filebeat-config.yml`
Configures filebeats establishing correct hosts

`filebeat-playbook.yml`
Ansible provision file for file beats

`hosts`
Lists out ansible provision hosts, including ELK and webservers

`metricbeat-config.yml`
Configuration file establishing correct hosts for metric beats

`metricbeat-playbook.yml`
Ansible provision file for Metric beats

`setup.yml`
Sets up the provision container on the  webservers

# Provisioning
From the jump box:
`ansible-playbook elk.yml` for ELK box setup
`andible-playbook setup.yml` for the webservers
`ansible-playbook metricbeat-playbook.yml` to setup metric beats on webservers
`ansible-playbook filebeat-playbook.yml` to setup file beats on webservers
