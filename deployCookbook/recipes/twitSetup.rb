Chef::Log.info "*** Begin STEMTwitDash setup ***"

## the default apt repo installs an old version of node which doesn't include npm
execute "add correct node repo" do
  cwd "/home/ubuntu"
  user "ubuntu"
  command "sudo add-apt-repository -y ppa:chris-lea/node.js" ## -y to auto answer yes
end

execute "update apt-get" do
  cwd "/home/ubuntu"
  user "ubuntu"
  command "sudo apt-get update"
end

execute "install nodejs" do
  cwd "/home/ubuntu"
  user "ubuntu"
  command "sudo apt-get -y install nodejs" ## included -y to automatically answer 'yes' to 'are you sure?'
end

execute "create forwarding rules in iptables" do
  cwd "/home/ubuntu"
  user "ubuntu"
  command "sudo iptables -t nat -A PREROUTING -p tcp --dport 80 -j REDIRECT --to-ports 3000"
end

execute "install forever" do
  cwd "/home/ubuntu"
  user "ubuntu"
  command "sudo npm install forever"
end

Chef::Log.info "*** End STEMTwitDash setup ***"
