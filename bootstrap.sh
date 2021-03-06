#!/bin/bash
export ANSIBLE_FORCE_COLOR=true
export PYTHONUNBUFFERED=1
apt-get update
apt-get install python-pip python-dev git -y
pip install PyYAML jinja2 paramiko
echo -e 'LANG=en_US.UTF-8\nLC_ALL=en_US.UTF-8' > /etc/default/locale
cd /tmp
git clone https://github.com/ansible/ansible.git
cd ansible
git submodule update --init --recursive
make install
cd ../
rm -rf ansible/
cd /home/init
git submodule init
git submodule update --recursive
cd /home/init/ansible
cp host_vars/localhost.dist host_vars/localhost
ansible-playbook -i dev server.yml --connection=local
