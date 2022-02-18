#!/usr/bin/env bash

export DEBIAN_FRONTEND=noninteractive
apt-get upgrade -y
apt-get update && apt-get install nginx curl vim tshark -y

systemctl enable nginx
systemctl start nginx
