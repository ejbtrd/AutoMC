# PaperMC-Auto
## An automatic installer for Minecraft PaperMC server

### Usage:
- Create user for minecraft server  
	`sudo useradd -r -m -U -d /opt/minecraft -s /bin/bash minecraft`  
- Switch to that user  
	`su - minecraft`  
- Create directories  
	`sudo mkdir -p ~/{backups,tools,server}`  
- Clone this repository  
	`git clone https://github.com/ejbtrd/papermc-auto`  
- Run install script  
	`./install.sh`  