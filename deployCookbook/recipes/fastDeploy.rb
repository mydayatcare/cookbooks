#
# include_recipe "Chef::Log"
Chef::Log.info "*** Begin Stempremier deployment ***"

stem_premier_home = "/home/ubuntu/STEMPremier"
ubuntu_user_home = "/home/ubuntu"
play_home = "#{ubuntu_user_home}/play-#{node[:play_version]}"

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

execute "run" do

  Chef::Recipe::EnvironmentVariableHelper.configure_env_for_application!(ENV, node)

  cwd stem_premier_home

  command "sudo -E #{play_home}/play \"run 80\""
end

Chef::Log.info "*** End Stempremier deployment ***"
