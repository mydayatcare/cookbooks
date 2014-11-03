Chef::Log.info "*** Begin Elasticsearch deployment ***"

elasticpopulator_home = "/home/ubuntu/elasticpopulator"
ubuntu_user_home = "/home/ubuntu"

execute "git clone if doesn't exist" do
  cwd ubuntu_user_home
  command "[ ! -d #{elasticpopulator_home} ] && git clone #{node[:elasticpopulator][:repo_url]} || echo repo exists"
  user "ubuntu"
end

execute "switch to #{node[:elasticpopulator][:branch]} branch" do
  cwd elasticpopulator_home 
  command "git checkout #{node[:elasticpopulator][:branch]}"
  user "ubuntu"
end

execute "pull latest code" do
  cwd elasticpopulator_home
  command "git pull"
  user "ubuntu"
end

execute "create play distribution" do
  cwd elasticpopulator_home
  command "ruby recreate_all_indexes.rb #{node[:elasticpopulator][:mongo_dump_uri]}"
  user "ubuntu"
end

Chef::Log.info "*** End elasticpopulator deployment ***"
