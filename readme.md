# AutoMC
## An automatic installer for Minecraft PaperMC server

### Usage:
- Create user for minecraft server  
	`sudo useradd -r -m -U -d /opt/minecraft -s /bin/bash minecraft`  
- Switch to that user  
	`su - minecraft`  
- Create directories  
	`mkdir -p ~/{tools,server}`  
- Clone this repository  
	`git clone https://github.com/ejbtrd/AutoMC
- Go to cloned directory
	`cd AutoMC`  
- Run install script  
	`./install.sh`  
