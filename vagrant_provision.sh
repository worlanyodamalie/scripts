#!/bin/sh

# A Ubuntu 14.04 install aimed for Ruby on Rails development

# This box start with a basic Ubuntu 14.04 (trusty) based on phusion/ubuntu-14.04-amd64
# And it adds the following packages aimed for rails development

# - rbenv and ruby-build
# - ruby 2.1.2 with bundler
# - Git 1.9.1
# - Postgresql 9.3 and SQLite
# - Node.js
# - PhantomJs 1.9.7
# - Qt for Capybara Webkit
# - ImageMagick
# - Redis and Memcached

# enable console colors
#sed -i '1iforce_color_prompt=yes' ~/.bashrc

# disable docs during gem install
echo 'gem: --no-rdoc --no-ri' >> ~/.gemrc

# essentials
sudo apt-get update
sudo apt-get install -y autoconf bison build-essential libssl-dev libyaml-dev libreadline6 libreadline6-dev zlib1g zlib1g-dev libcurl4-openssl-dev curl wget

# SQLite, Git and Node.js
sudo apt-get install -y libsqlite3-dev git nodejs

# Qt for Capybara Webkit
sudo apt-get install -y libqtwebkit-dev

# ImageMagick
sudo apt-get install -y imagemagick

# Postgres
sudo apt-get install -y postgresql-9.3 postgresql-server-dev-9.3 postgresql-contrib-9.3

# Memcached
sudo apt-get install -y memcached

# Redis
#sudo apt-get install -y redis-server

# setup rbenv and ruby-build
git clone https://github.com/sstephenson/rbenv.git ~/.rbenv
echo 'export PATH="$HOME/.rbenv/bin:$PATH"' >> ~/.bashrc
echo 'eval "$(rbenv init -)"' >> ~/.bashrc
git clone https://github.com/sstephenson/ruby-build.git ~/.rbenv/plugins/ruby-build

# Install ruby 2.3.3 and bundler
export RBENV_ROOT="${HOME}/.rbenv"
export PATH="${RBENV_ROOT}/bin:${PATH}"
export PATH="${RBENV_ROOT}/shims:${PATH}"
rbenv install 2.3.3
rbenv global 2.3.3
gem install bundler
rbenv rehash

# Phantomjs
#sudo wget https://bitbucket.org/ariya/phantomjs/downloads/phantomjs-1.9.7-linux-x86_64.tar.bz2 -P /usr/local/share --quiet
#sudo tar xjf /usr/local/share/phantomjs-1.9.7-linux-x86_64.tar.bz2 -C /usr/local/share
#sudo ln -s /usr/local/share/phantomjs-1.9.7-linux-x86_64/bin/phantomjs /usr/local/share/phantomjs
#sudo ln -s /usr/local/share/phantomjs-1.9.7-linux-x86_64/bin/phantomjs /usr/local/bin/phantomjs
#sudo ln -s /usr/local/share/phantomjs-1.9.7-linux-x86_64/bin/phantomjs /usr/bin/phantomjs

# app specifics
cd /vagrant
bundle install
rbenv rehash
#sudo sudo -u postgres psql -1 -c "CREATE USER pgadmin WITH PASSWORD 'secret';"
#sudo sudo -u postgres psql -1 -c "ALTER USER pgadmin WITH SUPERUSER;"
#cp -R config/database.sample.yml config/database.yml
#rake db:create
#rake db:migrate
#rake db:seed

# cleanup
sudo apt-get clean
