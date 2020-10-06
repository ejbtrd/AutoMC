#!/bin/bash

# Check if script is running as root
if [ "$EUID" -ne 0 ]
  then echo "Please run this script as root."
  exit
fi

# User variables
echo "How much GB of RAM do you have?"
read $RAM

# Create random RCON password
PASSWORD=$(head /dev/urandom | tr -dc a-z0-9 | head -c 6 ; echo '')
echo $PASSWORD > /opt/minecraft/server/rconpasswd.txt

# Install packages
apt update -y
apt install git build-essential openjdk-8-jre-headless ufw -y

# Install mcrcon
git clone https://github.com/Tiiffi/mcrcon /opt/minecraft/tools/mcrcon
cd /opt/minecraft/tools/mcrcon
make 
make install 
mkdir /bin/mcrcon
ln -s /opt/minecraft/tools/mcrcon/mcrcon /bin/mcrcon

# Open ports
ufw allow 22
ufw allow 25565/tcp
ufw allow 25575/tcp
ufw enable

# Download PaperMC
wget https://papermc.io/ci/view/all/job/Paper-1.16/lastSuccessfulBuild/artifact/paperclip.jar -O /opt/minecraft/server/paperclip.jar

# Accept eula
echo "eula=true" > /opt/minecraft/server/eula.txt

# Enable RCON and set random password
echo -e "rcon.port=25575\nrcon.password=${PASSWORD}\nenable-rcon=true" > /opt/minecraft/server/server.properties

# Install Minecraft Server as service
echo -e "[Unit]\nDescription=Minecraft Server\nAfter=network.target\n\n[Service]\nUser=minecraft\nNice=1\nKillMode=none\nSuccessExitStatus=0 1\nProtectHome=true\nProtectSystem=full\nPrivateDevices=true\nNoNewPrivileges=true\nWorkingDirectory=/opt/minecraft/server\nExecStart=/usr/bin/java -Xmx512M -Xms${RAM}G -jar paperclip.jar nogui\nExecStop=mcrcon -H 127.0.0.1 -P 25575 -p $PASSWORD stop\n\n[Install]\nWantedBy=multi-user.target" > /etc/systemd/system/minecraft.service

systemctl daemon-reload

while true; do
    read -p "Do you want to start your server now?" yn
    case $yn in
        [Yy]* ) systemctl start minecraft; echo "Server started!";;
        [Nn]* ) exit;;
        * ) echo "Please answer yes or no.";;
    esac
done

while true; do
    read -p "Do you want to start your server automaticly after boot?" yn
    case $yn in
        [Yy]* ) systemctl enable minecraft; echo "Server will turn on after boot.";;
        [Nn]* ) exit;;
        * ) echo "Please answer yes or no.";;
    esac
done

echo "Installation done!"
echo "Your RCON password is:"
echo ""
echo "$PASSWORD"
echo ""
echo "Don't forget to change it in server.properties!"