#!/bin/sh

#echo "PasswordAuthentication yes" >> /etc/ssh/sshd_config

if [ -z $SSH_USER ] || [ $SSH_USER = "root" ]; then
  echo "No User Set, Find Password."
  sed -i "s/#PermitRootLogin.*/PermitRootLogin yes/g" /etc/ssh/sshd_config
  chown -R root /root
  if [ -n $SSH_PASSWORD ]; then
    echo "Password Set!"
    echo root:$SSH_PASSWORD | chpasswd
  else
    echo "Default password is root."
    echo root:root | chpasswd
  fi
else 
  echo "User $SSH_USER found!"
  adduser -S $SSH_USER -G users -s /bin/sh
  if [ -n $SSH_PASSWORD ]; then
     echo $SSH_USER:$SSH_PASSWORD | chpasswd
  else 
    echo "Password Not Found, Default Password is $SSH_USER"
    echo $SSH_USER:$SSH_USER | chpasswd
  fi
  chown -R $SSH_USER /home/$SSH_USER
  chown -R $SSH_USER /app
fi
		
/usr/sbin/sshd -D
