node 'slave.puppet'{
include 'ssh::install'
include 'jfrog'
include 'jenkins'
include 'mysql::pass'
include 'ntp'

}
