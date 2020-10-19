# AutoMC
## An automatic installer for Minecraft PaperMC server

### Usage:
Create user for minecraft server  
	`sudo useradd -r -m -U -d /opt/minecraft -s /bin/bash minecraft`  
  
Create directories  
	`sudo mkdir -p /opt/minecraft/{tools,server}`  
  
Download script  
	`sudo wget https://raw.githubusercontent.com/ejbtrd/AutoMC/master/install.sh -O /opt/minecraft/install.sh`    
  
Make it executable  
	`sudo chmod +x /opt/minecraft/install.sh`
  
Run install script  
	`sudo /opt/minecraft/install.sh`  

### Control:

To start your server:  
	`sudo systemctl start minecraft`  
  
To stop it:  
	`sudo systemctl stop minecraft`  
  
Your server will be automaticly started every after boot, to disable it:  
	`sudo systemctl disable minecraft`  
  
To re-enable it:  
	`sudo systemctl enable minecraft` 
  
To connect to console:  
	`rcon -p <your-password>`  
  
Your password is stored in /opt/minecraft/server/rconpasswd.txt  
Don't forget to change it!  