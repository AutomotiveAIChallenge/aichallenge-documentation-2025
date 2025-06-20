
## 依存パッケージのインストール

sudo apt update
sudo apt install -y git

## 大会用リポジトリのクローン
cd ~
git clone https://github.com/AutomotiveAIChallenge/aichallenge-2025.git

## 依存パッケージのインストール
sudo apt update
sudo apt install -y python3-pip ca-certificates curl gnupg

## Dockerのインストール

sudo install -m 0755 -d /etc/apt/keyrings
curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo gpg --dearmor -o /etc/apt/keyrings/docker.gpg
sudo chmod a+r /etc/apt/keyrings/docker.gpg
echo \
  "deb [arch="$(dpkg --print-architecture)" signed-by=/etc/apt/keyrings/docker.gpg] https://download.docker.com/linux/ubuntu \
  "$(. /etc/os-release && echo "$VERSION_CODENAME")" stable" | \
  sudo tee /etc/apt/sources.list.d/docker.list > /dev/null

sudo apt-get update
sudo apt-get install -y docker-ce docker-ce-cli containerd.io docker-buildx-plugin docker-compose-plugin
sudo usermod -aG docker $USER
newgrp docker


sudo docker run hello-world

## rockerのインストール
pip install rocker

echo export PATH='$HOME/.local/bin:$PATH' >> ~/.bashrc
source ~/.bashrc

## Autoware環境のDockerイメージ取得
docker pull ghcr.io/automotiveaichallenge/autoware-universe:humble-latest

docker images

wget 'https://tier4inc-my.sharepoint.com/:f:/g/personal/taiki_tanaka_tier4_jp/EopMoY32mnNLhPVHWZkkow4B4aNBsc0aygEdqNPsmm_J8g' -O AWSIM.zip

mv AWSIM.zip ~/aichallenge-2025/simulator/
unzip ~/aichallenge-2025/simulator/AWSIM.zip -d ~/aichallenge-2025/simulator/
chmod a+x ~/aichallenge-2025/simulator/AWSIM.sh


## 大会環境のDockerイメージのビルド

./docker_build.sh dev

docker images

## Dockerコンテナ上でのAutowareのビルド

cd ~/aichallenge-2025
./docker_run.sh dev cpu