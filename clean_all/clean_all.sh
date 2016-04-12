rm -rf /opt/*
rm -f /usr/bin/java
rm -f /usr/bin/javac
rm -f /usr/bin/mvn
rm -rf /usr/local/jenkins
rm -f /etc/init.d/jenkins
rm -f /etc/sysconfig/jenkins
rm -rf /root/lib
yum remove -y ntp
yum remove -y git
userdel -r jfrog
userdel -r jenkins
cat bashrc_default > ~/.bashrc
