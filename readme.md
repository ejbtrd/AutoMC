<div align="center">

# AutoMC

### An automatic installer for Minecraft Paper server

</div>

### Usage: 
  
Download script  
	`wget https://raw.githubusercontent.com/ejbtrd/AutoMC/master/install.sh -O ~/install.sh`    
  
Make it executable  
	`chmod +x ~/install.sh`
  
Run install script  
	`sudo ~/install.sh`  

### Control:

You can control your server using [systemd](https://www.digitalocean.com/community/tutorials/systemd-essentials-working-with-services-units-and-the-journal).
  
To connect to console:  
	`rcon -p <your-password>`  
  
*Your password is stored in* `/opt/minecraft/server/rconpasswd.txt`
*Don't forget to change it!*
