Chef::Log.info "*** Begin Node Setup ***"

execute "addAptRepo" do
	cwd "/home/ubuntu"
	user "ubuntu"
	command "sudo add-apt-repository ppa:chris-lea/node.js"
end

execute "aptGetUpdate" do
	cwd "/home/ubuntu"
	user "ubuntu"
	command "sudo apt-get update"
end

execute "installNode" do
	cwd "/home/ubuntu"
	user "ubuntu"
	command "sudo apt-get -y install nodejs"
end

execute "createForwardingRules" do
	cwd "/home/ubuntu"
	user "ubuntu"
	command "sudo iptables -t nat -A PREROUTING -p tcp --dport 80 -j REDIRECT --to-ports 3000"
end

execute "installForever" do
	cwd "/home/ubuntu"
	user "ubuntu"
	command "sudo npm install forever"
end

execute "get project" do
	cwd "/home/ubuntu"
	user "ubuntu"
	command "git clone #{node[:repo_url_cms]}"
end