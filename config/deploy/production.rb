server '52.25.248.8', user: 'deploy', roles: %w{app db web}

set :rails_env, "production"
set :puma_env,  "production"
set :puma_config_file, "#{shared_path}/config/puma.rb"
set :puma_conf, "#{shared_path}/config/puma.rb"
