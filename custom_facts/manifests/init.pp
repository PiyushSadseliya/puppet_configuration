class custom_facts{

exec { 'make_direc':
path => ["/usr/bin","/usr/sbin"],
command => "mkdir -p /root/lib/ruby/facter",
}

file_line { 'add_path_bash':
path => '/root/.bashrc',
line => 'export RUBYLIB=/root/lib/ruby',
}

file { '/root/lib/ruby/facter/java_check.rb':
require => Exec["make_direc"],
ensure => present,
content => template('custom_facts/java_check.conf.erb'),
}

file { '/root/lib/ruby/facter/jenkins_check.rb':
require => Exec["make_direc"],
ensure => present,
content => template('custom_facts/jenkins_check.conf.erb'),
}
}

