#!/bin/bash -xeu
OS_VERSION=`cat /etc/os-release | grep VERSION=  | awk -F '"' '{print $2}'| awk '{print $1}' | awk -F '.' -v 'OFS=.' '{print $1,$2}'`
curl https://build.opensuse.org/projects/home:manuelschneid3r/public_key | sudo apt-key add -

sudo sh -c "echo 'deb http://download.opensuse.org/repositories/home:/manuelschneid3r/xUbuntu_${OS_VERSION}/ /' > /etc/apt/sources.list.d/home:manuelschneid3r.list"

sudo apt-get update
sudo apt-get install -y albert
