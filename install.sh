#!/bin/bash

# Atualizar o sistema e instalar os pacotes necessários
apt update && apt upgrade -y
DEBIAN_FRONTEND=noninteractive apt install -y \
    wget sudo openbox lxterminal pwgen novnc tightvncserver \
    python3 python3-pip python3-websockify python3-numpy \
    libnss3 libnspr4 libu2f-udev xvfb xdg-utils software-properties-common fonts-liberation \
    && apt clean \
    && rm -rf /var/lib/apt/lists/*

# Gerar certificado SSL autoassinado para noVNC
apt update
openssl req -x509 -nodes -newkey rsa:3072 -keyout /root/novnc.pem -out /root/novnc.pem -days 3650 -subj "/"

# Instalar chrome
wget https://dl.google.com/linux/direct/google-chrome-stable_current_amd64.deb
apt install -y -f ./google-chrome-stable_current_amd64.deb
rm google-chrome-stable_current_amd64.deb
apt update

# Criar uma senha para o VNC
export USER=root
PASSWORD=$(pwgen 8 1)
mkdir -p ~/.vnc
echo $PASSWORD | vncpasswd -f > ~/.vnc/passwd
chmod 600 ~/.vnc/passwd

# Configurar o VNC
vncserver :1
apt update
vncserver -kill :1
mv ~/.vnc/xstartup ~/.vnc/xstartup.bak

# Configurar o Openbox
cat <<EOF > ~/.vnc/xstartup
#!/bin/bash
xrdb $HOME/.Xresources
openbox-session &
EOF

# Iniciar o VNC
chmod +x ~/.vnc/xstartup
vncserver :1

# Iniciar noVNC
websockify -D --web=/usr/share/novnc/ --cert=/root/novnc.pem 6080 localhost:5901 > /dev/null 2>&1

# Exibir informações
if [ "$PASSWORD" ]; then
    echo ""
    echo "noVNC configurado com sucesso"
    echo "Acesse noVNC em http://<IP ou URL>:6080/vnc.html"
    echo "Senha: $PASSWORD"
    echo ""
else
    echo ""
    echo "Erro ao configurar o noVNC."
    echo ""
fi
