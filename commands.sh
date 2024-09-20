# docker compose
export dc_latest_version=`curl -s https://api.github.com/repos/docker/compose/releases/latest | \
        grep tag_name | \
        sed -e 's/[^0-9\.]//g'`
sudo curl -L "https://github.com/docker/compose/releases/download/v$dc_latest_version/docker-compose-$(uname -s)-$(uname -m)" -o /usr/local/bin/docker-compose
sudo chmod +x /usr/local/bin/docker-compose
sudo ln -s /usr/local/bin/docker-compose /usr/bin/docker-compose

# certbot ssl
sudo certbot certonly --standalone --email ngovanhuy.cntt3@gmail.com -d finbertngo.com -d trello.finbertngo.com

# pnpm install
curl -fsSL https://get.pnpm.io/install.sh | sh -