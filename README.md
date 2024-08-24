# noVNC com Openbox

Este repositório oferece uma configuração simples para acessar um ambiente gráfico Openbox remotamente via noVNC.


#### Instalação no Linux (Recomendado: Ubuntu)
```bash
sudo apt update && sudo apt install -y curl
curl -sL https://raw.githubusercontent.com/rafaellrossi/novnc-ubuntu-openbox/main/install.sh | sudo bash
```
#### Se preferir usar Docker, siga as instruções abaixo:
```bash
sudo apt update && sudo apt install -y git
git clone https://github.com/rafaellrossi/novnc-ubuntu-openbox.git
cd novnc-ubuntu-openbox
docker build -t novnc-ubuntu-openbox .
docker run --privileged -it -p 6080:6080 novnc-ubuntu-openbox
```
