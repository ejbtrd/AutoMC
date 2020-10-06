<div align="center">

# AutoMC

## An automatic installer for Minecraft PaperMC server

</div>

### Usage: 
  
Download script  
	`wget https://raw.githubusercontent.com/ejbtrd/AutoMC/master/install.sh -O ~/install.sh`    
  
Make it executable  
	`chmod +x ~/install.sh`
  
Run install script  
	`sudo ~/install.sh`  

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
  
*Your password is stored in* `/opt/minecraft/server/rconpasswd.txt`
*Don't forget to change it!*
