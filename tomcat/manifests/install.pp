class tomcat::install($tomcat_folder="apache-tomcat-9.0.0.M4",
$tomcat_archive="apache-tomcat-9.0.0.M4.tar.gz")
{

file { "/tmp/$tomcat_archive":
source => "puppet:///modules/tomcat/$tomcat_archive",
}

exec{ 'extract_it':
path => ["/usr/bin","/usr/sbin"],
cwd => "/tmp",
require => File["/tmp/$tomcat_archive"],
command => "tar xvf $tomcat_archive",
}

exec{ 'move_it':
path => ["/usr/bin","/usr/sbin"],
cwd => "/tmp",
require => Exec["extract_it"],
command => "mv $tomcat_folder /opt/",
}

exec{ 'delete_settings':
path => ["/usr/bin","/usr/sbin"],
require => Exec["move_it"],
command => "rm -f /opt/$tomcat_folder/conf/server.xml",
}

file { "/opt/$tomcat_folder/conf/server.xml":
require => Exec["delete_settings"],
ensure => present,
content => template('tomcat/tomcat.conf.erb'),
}

exec { 'start_tomcat':
require => File["/opt/$tomcat_folder/conf/server.xml"],
command => "/opt/$tomcat_folder/bin/startup.sh",
}

}
