Chef::Log.info "*** Begin Landing Deploy ***"

execute "npmInstall" do
	cwd "/home/ubuntu/stempremier-cms"
	user "ubuntu"
	command "sudo npm install"
end

execute "installForever" do
	cwd "/home/ubuntu/stempremier-cms"
	user "ubuntu"
	command "sudo npm install forever -g"
end

file "/home/ubuntu/stempremier-cms/.env" do
	owner "ubuntu"
	group "ubuntu"
	mode "0755"
	action :create
	content "MONGO_URI=#{node[:mongo_uri_cms]}\n
			 S3_SECRET=#{node[:aws][:secret_key]}\n
			 S3_BUCKET=#{node[:aws][:s3_bucket_cms]}\n
			 S3_KEY=#{node[:aws][:access_key]}"
end

# ruby_block "insert mongo_uri in .env" do
# 	block do
# 		line = "MONGO_URI=#{node[:mongo_uri_cms]}"
# 		file = Chef::Util::FileEdit.new("/home/ubuntu/stempremier-cms/.env")
# 		file.insert_line_if_no_match("/#{line}/", line)
# 		file.write_file
# 	end
# end 

execute "foreverStartKeystone" do
	cwd "/home/ubuntu/stempremier-cms"
	user "ubuntu"
	command "sudo forever start keystone.js"
end

# execute "startKeystone" do
# 	cwd "/home/ubuntu/Landing-Page"
# 	user "ubuntu"
# 	command "node keystone"
# end