/opt/apache-tomcat-9.0.0.M4/bin/shutdown.sh
runuser -l jenkins -c '/usr/local/jenkins/stop-jenkins.sh' && userdel -r jenkins && runuser -l jfrog -c '/opt/artifactory-oss-4.6.0/bin/artifactoryctl stop' && userdel -r jfrog && rm -rf /opt/* 
rm -f /usr/bin/java 
rm -f /usr/bin/javac 
rm -f /usr/bin/mvn 
rm -rf /usr/local/jenkins 
rm -f /etc/init.d/jenkins 
rm -f /etc/sysconfig/jenkins 
rm -rf /root/lib 
yum remove -y ntp 
yum remove -y git 
yum remove -y unzip
yum remove -y wget
cat bashrc_default > ~/.bashrc && source ~/.bashrc 
rm -rf ~/.ssh
yum remove -y cpp &&
yum remove -y gcc &&
yum remove -y gdbm-devel &&
yum remove -y glibc &&
yum remove -y glibc-common &&
yum remove -y glibc-devel &&
yum remove -y glibc-headers &&
yum remove -y kernel-headers &&
yum remove -y libdb-devel &&
yum remove -y libmpc &&
yum remove -y mpfr &&
yum remove -y perl-ExtUtils-Install &&
yum remove -y perl-ExtUtils-MakeMaker &&
yum remove -y perl-ExtUtils-Manifest &&
yum remove -y perl-ExtUtils-ParseXS &&
yum remove -y perl-Test-Harness &&
yum remove -y perl-devel &&
yum remove -y pyparsing &&
yum remove -y systemtap-sdt-devel &&
yum remove -y zlib-devel 
rm -f /usr/local/bin/git*
rm -f /usr/local/bin/ntp*
rm -rf /opt/*
userdel -r jenkins
userdel -r jfrog
