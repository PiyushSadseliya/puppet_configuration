class mysql::pass($mysql_password="Admin@123")
{
require 'mysql::install'

service { 'mysqld':
ensure => running,
}

exec { "set-mysql-password":
    unless => "mysqladmin -uroot -p$mysql_password status",
    path => ["/bin", "/usr/bin"],
    command => "mysqladmin -uroot password $mysql_password",
    require => Service["mysqld"],
}
}
