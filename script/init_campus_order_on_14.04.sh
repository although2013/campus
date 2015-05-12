#!/usr/bin/env bash

# WARNING: only for ubuntu 14.04


#..................
#useradd -m deployme
#adduser deployme sudo
#passwd deployme
#su - deployme
#..................


sudo apt-get update;
sudo apt-get -y install git-core curl zlib1g-dev build-essential libssl-dev libreadline-dev libyaml-dev libsqlite3-dev sqlite3 libxml2-dev libxslt1-dev libcurl4-openssl-dev python-software-properties libffi-dev;

sudo apt-get -y install libgdbm-dev libncurses5-dev automake libtool bison libffi-dev;

gpg --keyserver hkp://keys.gnupg.net --recv-keys 409B6B1796C275462A1703113804BB82D39DC0E3


curl -L https://get.rvm.io | bash -s stable;
source ~/.rvm/scripts/rvm;

rvm install 2.2.1;
rvm use 2.2.1 --default;
echo "-------ruby version-----ruby version------"
ruby -v;

echo "gem: --no-ri --no-rdoc" > ~/.gemrc
gem install bundler










echo "-------nodejs-----nodejs------"
sudo add-apt-repository -y ppa:chris-lea/node.js;
sudo apt-get update;
sudo apt-get -y install nodejs;



echo "-------Passenger-----Passenger------"
sudo apt-key adv --keyserver keyserver.ubuntu.com --recv-keys 561F9B9CAC40B2F7;

sudo apt-get -y install apt-transport-https ca-certificates;



sudo bash -c 'echo "deb https://oss-binaries.phusionpassenger.com/apt/passenger trusty main" > /etc/apt/sources.list.d/passenger.list';

sudo apt-get update;

sudo apt-get -y install nginx-extras passenger;



sudo sh -c 'sed -e "s/# passenger_root/passenger_root/" -e "s/# passenger_ruby.*/passenger_ruby \/home\/deployme\/.rvm\/wrappers\/default\/ruby;/" /etc/nginx/nginx.conf > /etc/nginx/nginx.conf2';

sudo mv /etc/nginx/nginx.conf  /etc/nginx/nginx.conf_back;
sudo mv /etc/nginx/nginx.conf2 /etc/nginx/nginx.conf;




sudo mkdir -p /var/www/campusorders.com;
sudo chown deployme:deployme /var/www/campusorders.com;

cd /var/www/campusorders.com;


git clone https://github.com/although2013/campusOrders.git master;

cd master;

sudo apt-get -y install mysql-server libmysqlclient-dev;



./script/setup_server.sh




sudo rm /etc/nginx/sites-enabled/default

sudo touch /etc/nginx/sites-enabled/campusorders.com.conf


sudo sh -c "echo '''server {
    listen 80 default;
    server_name campusorders.com;
    root /var/www/campusorders.com/master/public;
    passenger_enabled on;
}''' > /etc/nginx/sites-enabled/campusorders.com.conf;"


sudo service nginx restart


sudo apt-get -y autoremove;

echo "YOU SHOULD:"
echo "export TWITTER_KEY"
echo "export TWITTER_SECRET"


#vi /etc/nginx/nginx.conf
#client_max_body_size 20m;