class java::install($java_archive="jdk-8u77-linux-x64.tar.gz",
$java_folder="jdk1.8.0_77")
{

file { "/tmp/$java_archive" :
ensure => "present",
source => "puppet:///modules/java/$java_archive",
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

file_line { 'edit_bashrc':
require => Exec["set_java"],
path => '/root/.bashrc',
line => 'export JAVA_HOME=/opt/jdk1.8.0_77
export JRE_HOME=/opt/jdk1.8.0_77/jre
export PATH=$PATH:/opt/jdk1.8.0_77/bin:/opt/jdk1.8.0_77/jre/bin',
}

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
