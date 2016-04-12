class ssh_keygen::install{

exec{ 'create_key':
path => ["/usr/bin","/usr/sbin"],
command => "ssh-keygen -t rsa -P \"\" -f /root/.ssh/id_rsa",
}
}
