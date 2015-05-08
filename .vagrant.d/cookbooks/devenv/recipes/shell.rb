include_recipe "git"

node['devenv']['users'].each do |user_name,config|
  unless config['shell'].nil?
    package config['shell']
    user user_name do
      shell "/bin/#{config['shell']}"
      action :modify
    end
  end
end
