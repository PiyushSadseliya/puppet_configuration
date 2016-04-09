class ssh::install{

package{ 'openssh-server':
ensure => 'installed',
}

package{ 'openssh-clients':
require => Package["openssh-server"],
ensure => 'installed',
}

exec { 'chkcfg':
require => Package["openssh-clients"],
path => ["/usr/bin","/usr/sbin"],
command => "chkconfig sshd on",
}

exec {'restart':
require => Exec["chkcfg"],
path => ["/usr/bin","/usr/sbin"],
command => "service sshd start",
}

}
