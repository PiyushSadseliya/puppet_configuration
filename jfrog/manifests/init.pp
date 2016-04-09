class jfrog {

require 'users::create_jfrog'
require 'unzip::install'
require 'maven::install'

file { '/tmp/jfrog-artifactory-oss-4.6.0.zip':
source => "puppet:///modules/jfrog/jfrog-artifactory-oss-4.6.0.zip",
owner => 'root',
}

exec { 'extract_jfrog':
path    => ["/usr/bin", "/usr/sbin", "/bin"],
require => File['/tmp/jfrog-artifactory-oss-4.6.0.zip'],
cwd => "/tmp",
command => "unzip jfrog-artifactory-oss-4.6.0.zip",
}

exec { 'make_dir':
path    => ["/usr/bin", "/usr/sbin", "/bin"],
cwd => "/opt",
require => Exec["extract_jfrog"],
command => "mkdir jfrog",
}

exec { 'move_dir':
path    => ["/usr/bin", "/usr/sbin", "/bin"],
cwd => "/tmp",
command => "mv artifactory-oss-4.6.0 /opt/jfrog/",
require => Exec["make_dir"],
}

file_line{'edit_conf':
path => '/opt/jfrog/artifactory-oss-4.6.0/bin/artifactory.default',
require => Exec["move_dir"],
line => 'export ARTIFACTORY_HOME=/opt/jfrog/artifactory-oss-4.6.0
export ARTIFACTORY_USER=jfrog
export JAVA_HOME=/opt/jdk1.8.0_77'
}

exec { 'ownership':
path    => ["/usr/bin", "/usr/sbin", "/bin"],
require => File_line["edit_conf"],
command => "chown -R jfrog. /opt/jfrog",
}

exec { 'run_artifactory':
path => ["/usr/bin","/usr/sbin"],
require => Exec["ownership"],
command => "runuser -l jfrog -c '/opt/jfrog/artifactory-oss-4.6.0/bin/artifactoryctl start'",
}
}

