class java::install{

file { "/tmp/$java_archive" :
ensure => "present",
source => "puppet:///modules/java/$java_archive",
require => Exec["java_check_link2"],
}

exec { 'java_check_folder':
path    => ["/usr/bin", "/usr/sbin", "/bin"],
command => "rm -rf /opt/${java_folder}",
onlyif => "/usr/bin/test -d /opt/${java_folder}",
}

exec { 'java_check_link1':
path    => ["/usr/bin", "/usr/sbin", "/bin"],
command => "rm -f /usr/bin/java",
onlyif => "/usr/bin/test -L /usr/bin/java",
require => Exec["java_check_folder"],
}


exec { 'java_check_link2':
path    => ["/usr/bin", "/usr/sbin", "/bin"],
command => "rm -f /usr/bin/javac",
onlyif => "/usr/bin/test -L /usr/bin/javac",
require => Exec["java_check_link1"],
}


exec { 'extract_java':
path    => ["/usr/bin", "/usr/sbin", "/bin"],
require => File["/tmp/$java_archive"],
cwd => "/tmp",
command => "tar -xzf $java_archive",
}

exec { 'set_java':
path    => ["/usr/bin", "/usr/sbin", "/bin"],
require => Exec["extract_java"],
cwd => "/tmp",
command => "mv -f $java_folder /opt/",
}

#file_line { 'edit_bashrc':
#require => Exec["set_java"],
#path => '/root/.bashrc',
#line => 'export JAVA_HOME=/opt/jdk1.8.0_77
#export JRE_HOME=/opt/jdk1.8.0_77/jre
#export PATH=$PATH:/opt/jdk1.8.0_77/bin:/opt/jdk1.8.0_77/jre/bin',
#}

exec { 'set_links1':
path    => ["/usr/bin", "/usr/sbin", "/bin"],
require => Exec["set_java"],
command => "ln -s /opt/$java_folder/bin/java /usr/bin/java",
}

exec { 'set_links2':
path    => ["/usr/bin", "/usr/sbin", "/bin"],
require => Exec["set_java"],
command => "ln -s /opt/$java_folder/bin/javac /usr/bin/javac",
}

exec { 'remove_folder':
path    => ["/usr/bin", "/usr/sbin", "/bin"],
require => Exec["set_links2"],
cwd => "/tmp",
command => "rm -rf $java_folder",
}

exec { 'remove_archive':
path    => ["/usr/bin", "/usr/sbin", "/bin"],
require => Exec["set_links2"],
cwd => "/tmp",
command => "rm -rf $java_archive",
}


}

