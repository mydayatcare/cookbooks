#extend the chef recipe class
class Chef::Recipe::EnvironmentVariableHelper
  def self.configure_env_for_application!(env, node)

    env['APP_SECRET'] = node[:app_secret] if node[:app_secret]

    if node[:aws]
      env['AWS_ACCESS_KEY'] = node[:aws][:access_key]
      env['AWS_SECRET_KEY'] = node[:aws][:secret_key]
      env['AWS_S3_BUCKET'] = node[:aws][:s3_bucket]
    end

    if node[:db]
      env['DB_DRIVER']=node[:db][:driver]
      env['DB_JDBC_URL']=node[:db][:url]
      env['DB_USER']=node[:db][:user]
      env['DB_PASSWORD']=node[:db][:password]
    end

    if node[:duns]
      env['DUNS_AUTH_URL']=node[:duns][:auth][:url]
      env['DUNS_AUTH_NAME']=node[:duns][:auth][:name]
      env['DUNS_AUTH_PWD']=node[:duns][:auth][:password]
      env['DUNS_SERVICES_URL']=node[:duns][:services][:url]
    end

    env['ELASTICSEARCH_URI'] = node[:elasticsearch_connection][:uri]
    env['ELASTICSEARCH_USERNAME'] = node[:elasticsearch_connection][:username]
    env['ELASTICSEARCH_PASSWORD'] = node[:elasticsearch_connection][:password]
    
    env['GOOGLE_ANALYTICS_ID'] = node[:google_analytics_id]

    env['INDEED_PUBLISHER_ID'] = node[:indeed_publisher_id]

    env['MC_API_KEY'] = node[:mail_chimp][:api_key]

    env['MC_EVENTS_LIST'] = node[:mail_chimp][:events_list]

    env['MC_NEWS_LIST'] = node[:mail_chimp][:news_list]

    env['MC_STUDENTS_LIST'] = node[:mail_chimp][:students_list]

    env['MONGODB_URI'] = node[:mongodb_uri]

    env['PUBLIC_SITE'] = node[:public_site]

    if node[:smtp]
      env['SMTP_HOST'] = node[:smtp][:host]
      env['SMTP_PASSWORD'] = node[:smtp][:password]
      env['SMTP_USER'] = node[:smtp][:user]
    end

    if node[:sso]
      if node[:sso][:facebook]
        env['SSO_FACEBOOK_CLIENT_ID'] = node[:sso][:facebook][:client_id]
	      env['SSO_FACEBOOK_CLIENT_SECRET'] = node[:sso][:facebook][:client_secret]
      end
      if node[:sso][:google]
        env['SSO_GOOGLE_CLIENT_ID'] = node[:sso][:google][:client_id]
        env['SSO_GOOGLE_CLIENT_SECRET'] = node[:sso][:google][:client_secret]
      end
      if node[:sso][:linkedin]
        env['SSO_LINKEDIN_CONSUMER_KEY'] = node[:sso][:linkedin][:consumer_key]
        env['SSO_LINKEDIN_CONSUMER_SECRET'] = node[:sso][:linkedin][:consumer_secret]
      end
      if node[:sso][:twitter]
        env['SSO_TWITTER_CONSUMER_KEY'] = node[:sso][:twitter][:consumer_key]
        env['SSO_TWITTER_CONSUMER_SECRET'] = node[:sso][:twitter][:consumer_secret]
      end
    end

    if node[:stripe]
      env['STRIPE_SECRET_KEY'] = node[:stripe][:secret_key]
      env['STRIPE_PUBLISHABLE_KEY'] = node[:stripe][:publishable_key]
    end

    if node[:twit]
      env['TWIT_CONSUMER_KEY'] = node[:twit][:consumer_key]
      env['TWIT_CONSUMER_SECRET'] = node[:twit][:consumer_secret]
      env['TWIT_ACCESS_TOKEN'] = node[:twit][:access_token]
      env['TWIT_ACCESS_SECRET'] = node[:twit][:access_secret]
      env['TWIT_MONGO_DB'] = node[:twit][:mongo_db]
    end

    env['VIMEO_OAUTH_ACCESS_TOKEN'] = node[:vimeo][:oauth][:access_token]
    env['VIMEO_OAUTH_ACCESS_SECRET'] = node[:vimeo][:oauth][:access_secret]
    env['VIMEO_OAUTH_CONSUMER_KEY'] = node[:vimeo][:oauth][:consumer_key]
    env['VIMEO_OAUTH_CONSUMER_SECRET'] = node[:vimeo][:oauth][:consumer_secret]

    env['MEMCACHED_1_HOST'] = node[:memcached_host_1]
    env['MEMCACHED_2_HOST'] = node[:memcached_host_2]

    if node[:jongo]
      env['PLAYJONGO_URI'] = node[:jongo][:playjongo_uri]
    end

    env['DROPBOX_APP_KEY'] = node[:dropbox][:app_key]

    env['GOOGLE_PICKER_CLIENT_ID'] = node[:google][:client_id]
    env['GOOGLE_PICKER_API_KEY'] = node[:google][:api_key]

  end

end
