#!/bin/bash
apt-get update -y
apt-get install git -y
apt-get install python3 -y
cd /home/ubuntu/
# TOKEN=XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX
git clone https://@github.com/Herr-Aksoy/Proje2-Team.git    #$TOKEN
 # https://github.com/Herr-Aksoy/Proje2-Team.git
cd /home/ubuntu/Proje2-Team
apt install python3-pip -y
apt-get install python3.7-dev libmysqlclient-dev -y
pip3 install -r requirements.txt
cd /home/ubuntu/Proje2-Team/src
python3 manage.py collectstatic --noinput
python3 manage.py makemigrations
python3 manage.py migrate
python3 manage.py runserver 0.0.0.0:80