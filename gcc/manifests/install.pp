class gcc::install{

#exec { 'delta':
#path => ["/usr/bin","/usr/sbin"],
#command => "yum install -y deltarpm",
#timeout => 8000,
#}

package{ 'gcc':
#require => Exec["delta"],
ensure => 'installed',
}
}
