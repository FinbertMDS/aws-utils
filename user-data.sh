#!/usr/bin/bash -x
default_user='ec2-user'

# programming languages
python_version='3.12.6'
node_version='20.17.0'

# installation: docker
sudo dnf install -y docker
sudo groupadd docker
sudo usermod -aG docker ${default_user}
sudo -u ${default_user} newgrp docker
sudo systemctl start docker

# installation: build essentials
sudo dnf install -y gcc git
sudo dnf install -y bzip2-devel libffi-devel libyaml-devel openssl-devel readline-devel sqlite-devel xz-devel zlib-devel

# installation: pyenv
curl https://pyenv.run | bash
TMPDIR="${PWD}/tmp" pyenv install ${python_version}
pyenv global ${python_version}

# installation: nodenv
curl -o- https://raw.githubusercontent.com/nvm-sh/nvm/v0.39.7/install.sh | bash
source ~/.bashrc


# installation: golang
sudo dnf install golang -y -q

# installation: certbot
sudo dnf install -y python3 augeas-libs cronie
sudo python3 -m venv /opt/certbot/
sudo /opt/certbot/bin/pip install --upgrade pip
sudo /opt/certbot/bin/pip install certbot certbot-nginx
sudo ln -s /opt/certbot/bin/certbot /usr/bin/certbot

# installation: nginx
sudo dnf install -y nginx

