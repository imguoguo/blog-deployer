#!/bin/sh

#echo "PasswordAuthentication yes" >> /etc/ssh/sshd_config

if [ -z $USER ]; then
  echo "No User Set, Find Password."
  sed -i "s/#PermitRootLogin.*/PermitRootLogin yes/g" /etc/ssh/sshd_config
  if [ -n $PASSWORD ]; then
    echo "Password Set!"
    echo root:$PASSWORD | chpasswd
  else
    echo "Default password is root."
    echo root:root | chpasswd
  fi
else 
  echo "User $USER found!"
  adduser -S $USER -G users -s /bin/sh
  if [ -n $PASSWORD ]; then
     echo $USER:$PASSWORD | chpasswd
  else 
    echo "Password Not Found, Default Password is $USER"
    echo $USER:$USER | chpasswd
  fi
  chown -R $USER /home/$USER
  chown -R $USER /app
fi
		
/usr/sbin/sshd -D
