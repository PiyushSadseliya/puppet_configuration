class mysql::install{

require 'wget::install' 

exec { 'down_repo':
path => ["/usr/bin","/usr/sbin"],
cwd => "/tmp",
command => "wget http://repo.mysql.com/mysql-community-release-el7-5.noarch.rpm",
}

exec { 'add_repo':
require => Exec["down_repo"],
cwd => "/tmp",
path => ["/usr/bin","/usr/sbin"],
command => "rpm -ivh mysql-community-release-el7-5.noarch.rpm",
}

exec { 'install_mysql':
require => Exec["down_repo"],
cwd => "/tmp",
path => ["/usr/bin","/usr/sbin"],
timeout => 8000,
command => "yum install -y mysql-server",
}

exec { 'start':
require => Exec["install_mysql"],
cwd => "/tmp",
path => ["/usr/bin","/usr/sbin"],
command => "systemctl start mysqld",
}

}
