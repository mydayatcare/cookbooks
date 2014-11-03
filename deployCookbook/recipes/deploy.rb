#
# include_recipe "Chef::Log"
Chef::Log.info "*** Begin Stempremier deployment ***"
#directory "/home/ubuntu/STEMPremier" do
#  owner "root"
#  group "root"
#  mode 00755
#  action :create
# end

stem_premier_home = "/home/ubuntu/STEMPremier"
ubuntu_user_home = "/home/ubuntu"

execute "kill" do
  command "sudo pkill java &"
end

execute "switch to #{node[:branch]} branch" do
  cwd stem_premier_home 
  command "git checkout #{node[:branch]}"
  user "ubuntu"
end

execute "pull latest code" do
  cwd stem_premier_home
  command "git pull"
  user "ubuntu"
end

#play stage can not be performed efficiently with openjdk, 
#the forked process for chmod doubles memory usage
execute "create play distribution" do
  cwd stem_premier_home
  command "/home/ubuntu/activator-1.2.3-minimal/activator dist"
  user "ubuntu"
end

execute "unzip play distribution" do
  user "ubuntu"
  cwd ubuntu_user_home
  command "unzip -o #{stem_premier_home}/target/universal/stemPremier-1.0-SNAPSHOT.zip"
end

execute "make start script executeable" do
  command "sudo chmod +x #{ubuntu_user_home}/stemPremier-1.0-SNAPSHOT/bin/stempremier"
  user "ubuntu"
end

Chef::Recipe::EnvironmentVariableHelper.configure_env_for_application!(ENV, node)

execute "start" do
  cwd ubuntu_user_home
  command "sudo -E #{ubuntu_user_home}/stemPremier-1.0-SNAPSHOT/bin/stempremier -Dhttp.port=80 -DapplyEvolutions.default=true -DapplyDownEvolutions.default=false -mem #{node[:java][:java_memory]} &"
  user "ubuntu"
end

Chef::Log.info "*** End Stempremier deployment ***"
