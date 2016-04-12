class jenkins{

require 'maven::install' 
#require 'git::install'

file { '/usr/local/jenkins/jenkins.war':
require => Exec["make_dir"],
source => "puppet:///modules/jenkins/jenkins.war",
}

exec { 'make_dir':
path => ["/usr/bin","/usr/sbin"],
command => "mkdir /usr/local/jenkins",
}

file { '/usr/local/jenkins/start-jenkins.sh':
require => File["/usr/local/jenkins/jenkins.war"],
ensure => present,
content => template('jenkins/start-jenkins.conf.erb'),
}

file { '/usr/local/jenkins/stop-jenkins.sh':
require => File["/usr/local/jenkins/start-jenkins.sh"],
ensure => present,
content => template('jenkins/stop-jenkins.conf.erb'),
}

file { '/etc/init.d/jenkins':
ensure => present,
content => template('jenkins/initd_jenkins.conf.erb'),
}

exec { 'ownership':
require => File["/usr/local/jenkins/stop-jenkins.sh"],
path => ["/usr/bin","/usr/sbin"],
command => "chown -R jenkins. /usr/local/jenkins",
}

exec { 'chmod1':
require => Exec["ownership"],
path => ["/usr/bin","/usr/sbin"],
command => "chmod a+x /usr/local/jenkins/start-jenkins.sh",
}

exec { 'chmod2':
require => Exec["ownership"],
path => ["/usr/bin","/usr/sbin"],
command => "chmod a+x /usr/local/jenkins/stop-jenkins.sh",
}

exec { 'chmod3':
require => File["/etc/init.d/jenkins"],
path => ["/usr/bin","/usr/sbin"],
command => "chmod a+x /etc/init.d/jenkins",
}

file { '/etc/sysconfig/jenkins':
ensure => present,
content => template('jenkins/jenkins.conf.erb'),
}

exec { 'jenkins_start':
require => Exec["chmod2"],
path => ["/usr/bin","/usr/sbin"],
command => "runuser -l jenkins -c '/usr/local/jenkins/start-jenkins.sh'",
}

}
