class git::install {

require 'dependencies::install'

file { "/tmp/git-2.4.0.tar.gz" :
ensure => "present",
source => "puppet:///modules/git/git-2.4.0.tar.gz",
}

exec { 'extract_git':
path    => ["/usr/bin", "/usr/sbin", "/bin"],
require => File["/tmp/git-2.4.0.tar.gz"],
cwd => "/tmp",
command => "tar -xzf git-2.4.0.tar.gz",
}

exec{ 'move_git':
path    => ["/usr/bin", "/usr/sbin", "/bin"],
require => Exec["extract_git"],
cwd => "/tmp",
command => "mv git-2.4.0 /opt/",
}

exec { 'install_git1':
path    => ["/usr/bin", "/usr/sbin", "/bin"],
require => Exec["move_git"],
cwd => "/opt/git-2.4.0",
command => "/opt/git-2.4.0/configure",
}

exec { 'install_git2':
path    => ["/usr/bin", "/usr/sbin", "/bin"],
require => Exec["install_git1"],
cwd => "/opt/git-2.4.0",
command => "make",
}

exec { 'install_git3':
path    => ["/usr/bin", "/usr/sbin", "/bin"],
require => Exec["install_git2"],
cwd => "/opt/git-2.4.0",
command => "make install",
}

}
