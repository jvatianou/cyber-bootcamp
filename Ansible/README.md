### Network Security Group Rules

Below rules describe access to the entire infrastructure.  Because the web containers are by design vulnerable, several rules are put into place to ensure that only authorized access, my own public IP, is allowed.  Really, the point of the project is to implement secure network security group rules and work on provisioning.

| Source IP	| Source Port	| Protocol	| Destination	|
|-----------|-------------|-----------|-------------|
| Admin Public IP	| 80	| TCP	| Web Server Load Balancer Public IP |
| Admin Public IP | 22	| SSH | Jump Box Public IP|
| Jump Box Private IP	| 22	| SSH | Webservers Private IPs	|
| Jump Box Private IP	| 22 | SSH	| ELK Box Private IP	|
| Admin Public IP | 5601	| TCP	| Kibana	|

See README in Diagrams directory for more network information.

# Background
The "jump box" is the main provisioning box.  Admins from the configured public IP may access the jump box via SSH.  Docker must be installed on the jump using the following directions:

https://docs.docker.com/engine/install/ubuntu/

Then the Ansible container must be started using the command below:

`docker run -d --restart always ansible`

Using the `--restart always` option will ensure that the Ansible container starts whenever the jump box is started.

Once the Ansible container is started, users need to `ssh` into it using the command:

`docker exec -it ansible /bin/bash`

Users need to install `git` on the server, and generate a public/private key using `ssh-keygen`.  The public key must be added to Github and configured to allow `ssh` access on the webservers and ELK box.  Once the public key is verified on Github, users may simply clone this repo to get all the playbooks and configuration files.

Configurations are detailed below, as are playbook commands to use.

# Ansible Playbooks and Configurations

`ansible.cfg`
Ansible configuration file

`elk.yml`
Ansible playbook for ELK server.  Completes all the setup steps necessary.

`filebeat-config.yml`
Configures filebeats establishing correct hosts.  Host for the ELK box must be established in the configuration file.  In this case, set to 10.1.0.5 box.

`filebeat-playbook.yml`
Ansible provision file for file beats.

`hosts`
Lists out ansible provision hosts, including ELK and webservers.  View the file for IP of relevant servers.  Matches information in diagram.

`metricbeat-config.yml`
Configuration file establishing correct hosts for metric beats.  Host for the ELK box must be established in the configuration file.  In this case, set to 10.1.0.5 box.

`metricbeat-playbook.yml`
Ansible provision file for Metric beats.

`setup.yml`
Sets up the provision container on the  webservers.  Completes all the setup steps that are necessary including creating and starting any containers that need to run.

# Provisioning
From the jump box, run the following commands to provision different parts of the project.  Each playbook must be run to setup all the webservers, the ELK box and then the right file and metric beats.

* `ansible-playbook elk.yml` for ELK box setup

* `ansible-playbook setup.yml` for the webservers

* `ansible-playbook metricbeat-playbook.yml` to setup metric beats on webservers

* `ansible-playbook filebeat-playbook.yml` to setup file beats on webservers

# Accessing Kibana

Users can access Kibana from the public IP of the admin computer to the public IP of the ELK box.  Once the URL is inputted, then the admin may monitor the webservers.
