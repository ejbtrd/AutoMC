#!/bin/bash

# User variables
echo "How much GB of RAM do you have?"
read $RAM

# Create random RCON password
PASSWORD=$(head /dev/urandom | tr -dc a-z0-9 | head -c 6 ; echo '')
echo $PASSWORD > server/rconpasswd.txt

# Install packages
sudo apt update -y
sudo apt install git build-essential openjdk-8-jre-headless ufw

# Install mcrcon
git clone https://github.com/Tiiffi/mcrcon tools/mcrcon
cd tools/mcrcon
make 
sudo make install 
sudo mkdir /bin/mcrcon
sudo ln -s /opt/minecraft/tools/mcrcon/mcrcon /bin/mcrcon

# Open ports
sudo ufw allow 22
sudo ufw allow 25565
sudo ufw enable

# Download PaperMC
sudo wget https://papermc.io/ci/view/all/job/Paper-1.16/lastSuccessfulBuild/artifact/paperclip.jar -O server/paperclip.jar

# Accept eula
echo "eula=true" > eula.txt

# Enable RCON and set random password
echo -e 
"rcon.port=25575\n
rcon.password=$PASSWORD\n
enable-rcon=true" > server.properties

# Install Minecraft Server as service
echo -e 
"[Unit]\n
Description=Minecraft Server\n
After=network.target\n
\n
[Service]\n
User=minecraft\n
Nice=1\n
KillMode=none\n
SuccessExitStatus=0 1\n
ProtectHome=true\n
ProtectSystem=full\n
PrivateDevices=true\n
NoNewPrivileges=true\n
WorkingDirectory=/opt/minecraft/server\n
ExecStart=/usr/bin/java -Xmx512M -Xms$RAMG -jar server.jar nogui\n
ExecStop=mcrcon -H 127.0.0.1 -P 25575 -p $PASSWORD stop\n
\n
[Install]\n
WantedBy=multi-user.target" > /etc/systemd/system/minecraft.service

echo "Installation done!"
echo "Your RCON password is:"
echo ""
echo "$PASSWORD"
echo ""
echo "Don't forget to change it in server.properties!"