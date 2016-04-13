class wget::install{

file { '/tmp/wget-1.14-10.el7_0.1.x86_64.rpm':,
source => "puppet:///modules/wget/wget-1.14-10.el7_0.1.x86_64.rpm",
}

exec{ 'install_wget':
path => ["/usr/bin","/usr/sbin"],
cwd => "/tmp",
require => File["/tmp/wget-1.14-10.el7_0.1.x86_64.rpm"],
command => "rpm -i wget-1.14-10.el7_0.1.x86_64.rpm",
}

exec{ 'delete_wget':
path => ["/usr/bin","/usr/sbin"],
cwd => "/tmp",
require => Exec["install_wget"],
command => "rm -f wget-1.14-10.el7_0.1.x86_64.rpm",

}
}
