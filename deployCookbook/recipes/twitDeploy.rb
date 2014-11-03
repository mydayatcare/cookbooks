Chef::Log.info "*** Begin Twitter Dashboard deployment ***"

stemtwitdash_home = "/home/ubuntu/stemtwitdash"
ubuntu_user_home = "/home/ubuntu"

execute "git clone" do
  Chef::Log.info node[:twit][:repo_url]
  cwd "/home/ubuntu"
  user "ubuntu"
  command "sudo git clone #{node[:twit][:repo_url]}"
end

execute "switch to #{node[:twit][:branch]} branch" do
  cwd "/home/ubuntu/stemtwitdash" 
  user "ubuntu"
  command "sudo git checkout #{node[:twit][:branch]}"
end

execute "pull latest code" do
  cwd "/home/ubuntu/stemtwitdash"
  user "ubuntu"
  command "sudo git pull"
end

execute "install app" do
  cwd "/home/ubuntu/stemtwitdash"
  user "ubuntu"
  command "sudo npm install"
end

env['TWIT_CONSUMER_KEY'] = node[:twit][:consumer_key]
env['TWIT_CONSUMER_SECRET'] = node[:twit][:consumer_secret]
env['TWIT_ACCESS_TOKEN'] = node[:twit][:access_token]
env['TWIT_ACCESS_SECRET'] = node[:twit][:access_secret]
env['TWIT_MONGO_DB'] = node[:twit][:mongo_db]

execute "run app" do
  cwd "/home/ubuntu/stemtwitdash"
  user "ubuntu"
  command "forever start #{node[:twit][:app_file]}"
end

Chef::Log.info "*** End Twitter Dashboard deployment ***"
