#Создаём пользователей otusadm и otus
useradd otusadm && sudo useradd otus
#Создаём пользователям otusadm и otus пароли
echo "otusadm:Otus2022!" | chpasswd && echo "otus:Otus2022!" | chpasswd
#Создаём группу admin
groupadd -f admin
#Добавляем пользователей vagrant, root и otusadm в группу admin
gpasswd -a otusadm admin && gpasswd -a vagrant admin && gpasswd -a root admin
#Перемещаем скопированный в Vagrantfile скрипт контроля подключения пользователей
mv /tmp/login.sh /usr/local/bin/login.sh
#Добавляем права на исполнение файла
chmod +x /usr/local/bin/login.sh
#Добавляем строчку проверки подключения по ssh с использованием скрипта контроля
echo "account    required     pam_exec.so     /usr/local/bin/login.sh" >> /etc/pam.d/sshd
