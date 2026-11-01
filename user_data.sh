#!/bin/bash
apt-get update -y
apt-get install -y nginx
systemctl enable --now nginx
echo "<h1>Hello World from $(hostname -f)</h1>" > /var/www/html/index.html
