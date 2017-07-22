curl -fsSL https://raw.githubusercontent.com/kazukgw/devenv/master/setup/install_dockerd_on_ubuntu

echo ""
echo "edit /etc/docker/daemon.json and restart dockerd if you change dockerd runtime path"
echo ""
sudo curl -fsSL -o /etc/docker/daemon.json https://raw.githubusercontent.com/kazukgw/devenv/master/dockerd-daemon.json

curl -fsSL -o $HOME/.docker/config.json https://raw.githubusercontent.com/kazukgw/devenv/master/docker-config.json

curl -fsSL -o $HOME/Dockerfile https://raw.githubusercontent.com/kazukgw/devenv/master/setup/Dockerfile

curl -fsSL -o $HOME/docker-compose.yml https://raw.githubusercontent.com/kazukgw/devenv/master/setup/docker-compose.yml

sudo apt-get install python-pip -y

pip install docker-compose

echo ""
echo "edit docker-compose.yml for your environment"
echo "and do 'docker-compose build' "
echo ""

curl -fsSL -o $HOME/devenv https://raw.githubusercontent.com/kazukgw/devenv/master/setup/docker.sh
chmod +x $HOME/devenv
