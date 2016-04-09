class ntp{

package{ 'ntp':
ensure => "installed",
}

exec {'update_ntp':
path => ["/usr/bin","/usr/sbin"],
require => Package["ntp"],
command => "ntpdate -u pool.ntp.org",
notify => Service["ntpd"],
}

service { 'ntpd':
ensure => running,
require => Package["ntp"],
}

exec {'startup_ntp':
path => ["/usr/bin","/usr/sbin"],
require => Exec["update_ntp"],
command => "chkconfig ntpd on",
}
}



