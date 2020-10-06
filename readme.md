# AutoMC
## An automatic installer for Minecraft PaperMC server

### Usage:
- Create user for minecraft server  
	`sudo useradd -r -m -U -d /opt/minecraft -s /bin/bash minecraft`   
- Create directories  
	`mkdir -p /opt/minecraft/{tools,server}`  
- Clone this repository  
	`git clone https://github.com/ejbtrd/AutoMC /opt/minecraft/AutoMC`    
- Run install script  
	`/opt/minecraft/AutoMC/install.sh`  
