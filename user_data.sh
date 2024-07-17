#!/bin/bash

Habilitar login como root e definir senha
echo 'root:Dd33557788' | chpasswd
sed -i 's/PermitRootLogin prohibit-password/PermitRootLogin yes/' /etc/ssh/sshd_config
systemctl restart sshd

# Instalar Apache e unzip
sudo yum update -y
sudo yum install httpd unzip -y
sudo systemctl start httpd
sudo systemctl enable httpd
sudo unzip /tmp/Website.zip -d /tmp
sudo mv /tmp/Site/* /var/www/html/
sudo chown -R apache:apache /var/www/html
sudo chmod -R 755 /var/www/html
sudo systemctl restart httpd
