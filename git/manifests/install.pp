class git::install {

exec{ 'git':
path => ["/usr/bin","/usr/sbin"],
command => "yum install -y git",
timeout => 8000,
}
}
