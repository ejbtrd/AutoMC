#!/bin/bash

# Check if script is running as root
if [ "$EUID" -ne 0 ]
  then echo "Please run this script as root."
  exit
fi

# Install packages
PACKAGES="git build-essential openjdk-11-jre-headless ufw"

if [ -f /etc/debian_version ]; then
    echo "Detected Debian-based distribution!"
    apt-get -qq -y update
    apt-get -qq -y install $PACKAGES
elif [ -f /etc/arch-release ]; then
    echo "Detected arch linux based distribution!"
    pacman -Syuq $PACKAGES
else
    echo "Cannot detect distribution!"
    exit
fi

# Create user for server
useradd -r -m -U -d /opt/minecraft -s /bin/bash minecraft
mkdir -p /opt/minecraft/{tools,server}

# Create random RCON password
PASSWORD=$(cat /dev/urandom | tr -dc 'a-zA-Z0-9' | fold -w 32 | head -n 1)
echo $PASSWORD > /opt/minecraft/server/rconpasswd.txt

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
wget https://papermc.io/api/v1/paper/1.16.5/latest/download -O /opt/minecraft/server/paperclip.jar

# Accept eula
echo "eula=true" > /opt/minecraft/server/eula.txt

# Enable RCON and set random password
echo -e """rcon.port=25575
rcon.password=${PASSWORD}
enable-rcon=true""" > /opt/minecraft/server/server.properties

# Install Minecraft Server as service
echo -e """[Unit]
Description=Minecraft Server
After=network.target

[Service]
User=minecraft
Nice=1
KillMode=none
SuccessExitStatus=0 1
ProtectHome=true
ProtectSystem=full
PrivateDevices=true
NoNewPrivileges=true
WorkingDirectory=/opt/minecraft/server
ExecStart=/usr/bin/java -Xms512M -Xmx6G -jar paperclip.jar nogui
ExecStop=mcrcon -H 127.0.0.1 -P 25575 -p ${PASSWORD} stop

[Install]
WantedBy=multi-user.target""" > /etc/systemd/system/minecraft.service

# Reload services daemon
systemctl daemon-reload

# Run and enable minecraft service
systemctl enable --now minecraft

chown -R minecraft:minecraft /opt/minecraft

echo "Installation done!"
echo "Your RCON password is:"
echo ""
echo "$PASSWORD"
echo ""
