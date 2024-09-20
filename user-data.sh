#!/usr/bin/bash -x
export default_user='ec2-user'

# programming languages
export python_version='3.12.6'
export node_version='20.17.0'

# installation: docker
sudo dnf install -y docker
sudo groupadd docker
sudo usermod -aG docker ${default_user}
sudo -u ${default_user} newgrp docker
sudo systemctl start docker

# docker compose
export dc_latest_version=`curl -s https://api.github.com/repos/docker/compose/releases/latest | \
        grep tag_name | \
        sed -e 's/[^0-9\.]//g'`
sudo curl -L "https://github.com/docker/compose/releases/download/v$dc_latest_version/docker-compose-$(uname -s)-$(uname -m)" -o /usr/local/bin/docker-compose
sudo chmod +x /usr/local/bin/docker-compose
sudo ln -s /usr/local/bin/docker-compose /usr/bin/docker-compose

# installation: build essentials
sudo dnf install -y gcc git
sudo dnf install -y bzip2-devel libffi-devel libyaml-devel openssl-devel readline-devel sqlite-devel xz-devel zlib-devel

# installation: certbot
sudo dnf install -y python3 augeas-libs cronie
sudo python3 -m venv /opt/certbot/
sudo /opt/certbot/bin/pip install --upgrade pip
sudo /opt/certbot/bin/pip install certbot certbot-nginx
sudo ln -s /opt/certbot/bin/certbot /usr/bin/certbot

# installation: nginx
sudo dnf install -y nginx

# installation: nvm node
curl -o- https://raw.githubusercontent.com/nvm-sh/nvm/v0.39.7/install.sh | bash
source ~/.bashrc
nvm install --lts
npm install -g yarn

# installation: pyenv
curl https://pyenv.run | bash
export TMPDIR="${PWD}/tmp" pyenv install ${python_version}
pyenv global ${python_version}

# installation: golang
sudo dnf install golang -y -q
