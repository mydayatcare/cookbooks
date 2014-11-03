Chef::Log.info "*** Begin Stempremier setup ***"

execute "downloadPlay" do
  cwd "/home/ubuntu"
  user "ubuntu"
  command "wget http://downloads.typesafe.com/typesafe-activator/1.2.3/typesafe-activator-1.2.3-minimal.zip"
end

execute "unzipPlay" do
  user "ubuntu"
  cwd "/home/ubuntu"
  command "unzip -o typesafe-activator-1.2.3-minimal.zip"
end

execute "get project" do
  Chef::Log.info node[:repo_url]
  user "ubuntu"
  cwd "/home/ubuntu"
  command "git clone #{node[:repo_url]}"
end
