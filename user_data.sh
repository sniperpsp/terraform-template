#!/bin/bash

# Criar usuário djair com senha 33557788 e dar permissões de root
useradd djair
echo 'djair:33557788' | chpasswd
usermod -aG wheel djair

# Habilitar login com usuário e senha
sed -i 's/^#PasswordAuthentication yes/PasswordAuthentication yes/' /etc/ssh/sshd_config
sed -i 's/^PasswordAuthentication no/PasswordAuthentication yes/' /etc/ssh/sshd_config
sed -i 's/^#PermitEmptyPasswords no/PermitEmptyPasswords no/' /etc/ssh/sshd_config
sed -i 's/^PermitEmptyPasswords yes/PermitEmptyPasswords no/' /etc/ssh/sshd_config

# Reiniciar o serviço SSH para aplicar as mudanças
systemctl restart sshd

# Instalar Apache e unzip
sudo yum update -y
sudo yum install httpd unzip -y
sudo systemctl start httpd
sudo systemctl enable httpd

# Baixar e descompactar o site
curl -L -o /tmp/Website.zip https://github.com/sniperpsp/terraform-template/raw/main/Website.zip
sudo unzip /tmp/Website.zip -d /tmp
sudo mkdir /var/www/html/teste1
sudo mv /tmp/site/* /var/www/html/teste1
sudo chown -R apache:apache /var/www/html/teste1
sudo chmod -R 755 /var/www/html/teste1

# Criar arquivo de configuração do Apache para o site
cat <<EOL | sudo tee /etc/httpd/conf.d/teste1.conf
<VirtualHost *:80>
    DocumentRoot "/var/www/html/teste1"
    ServerName localhost

    <Directory "/var/www/html/teste1">
        AllowOverride All
        Require all granted
    </Directory>
</VirtualHost>
EOL

# Reiniciar o serviço Apache para aplicar as mudanças
sudo systemctl restart httpd