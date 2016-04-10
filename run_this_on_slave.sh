red=$'\e[1;31m'
grn=$'\e[1;32m'
yel=$'\e[1;33m'
blu=$'\e[1;34m'
mag=$'\e[1;35m'
cyn=$'\e[1;36m'
end=$'\e[0m' 
/bin/echo "------------------------"
printf "%s\n" "${red}Deploying configuration${end}"
/bin/echo "------------------------"
puppet agent -t &&
/bin/echo "------------------------"
printf "%s\n" "${red}Deployment Completed${end}"
/bin/echo "------------------------"
facter check_java
facter check_jenkins
