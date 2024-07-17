#!/bin/bash

# Criar usuário template com senha Te#mpl@te e dar permissões de root
useradd template #criando usuario
echo 'template:Te#mpl@te' | chpasswd #senhad o usuario
usermod -aG wheel template #permissão de root para o usuario

# Habilitar login com usuário e senha
sed -i 's/^#PasswordAuthentication yes/PasswordAuthentication yes/' /etc/ssh/sshd_config  #habilitando acesso com senha via ssh
sed -i 's/^PasswordAuthentication no/PasswordAuthentication yes/' /etc/ssh/sshd_config #habilitando acesso com senha via ssh
sed -i 's/^#PermitEmptyPasswords no/PermitEmptyPasswords no/' /etc/ssh/sshd_config #habilitando acesso com senha via ssh
sed -i 's/^PermitEmptyPasswords yes/PermitEmptyPasswords no/' /etc/ssh/sshd_config #habilitando acesso com senha via ssh

# Reiniciar o serviço SSH para aplicar as mudanças
systemctl restart sshd

# Instalar Apache e unzip
sudo yum update -y
sudo yum install httpd unzip -y
sudo systemctl start httpd
sudo systemctl enable httpd

# Baixar e descompactar o site
curl -L -o /tmp/Website.zip https://github.com/sniperpsp/terraform-template/raw/main/Website.zip    #Aqui vou baixar o site na pasta /tmp com o nome Website.zip, você pode trocar site 
sudo unzip /tmp/Website.zip -d /tmp #descompactando o zip, importante  trocar o nome do zip se você baixar com outro nome
sudo mkdir /var/www/html/teste1 #criando a pasta onde vai ser habilitado o site
sudo mv /tmp/site/* /var/www/html/teste1 #movendo o conteudo do site para a pasta que vai ser o front do apache < mude a origem de acordo com seu arquivo>
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