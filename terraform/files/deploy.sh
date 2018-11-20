#!/bin/bash
set -e

source ~/.profile
git clone https://github.com/Artemmkin/reddit.git
cd reddit
bundle install
bundle exec cap production deploy:initial

sudo mv /tmp/puma.service /etc/systemd/system/puma.service
sudo systemctl start puma
sudo systemctl enable puma
