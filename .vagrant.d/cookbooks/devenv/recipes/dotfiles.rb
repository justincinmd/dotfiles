include_recipe "git"

node['devenv']['users'].each do |user,config|
  dotfiles_dir = node['etc']['passwd'][user]['dir']

  ssh_known_hosts_entry "github.com for #{user}" do
    # Don't do this if the repo is setup
    host 'github.com'
    not_if "cd #{dotfiles_dir} && sudo -H -u #{user} git remote -v | grep #{config['repo']}"
  end

  execute "Setup Dotfiles Repo for #{user}" do
    cwd dotfiles_dir
    command "sudo -H -u #{user} git init"
  end

  execute "Add Remote for #{user}" do
    cwd dotfiles_dir
    command "git remote add origin #{config['repo']}"
    not_if "cd #{dotfiles_dir} && sudo -H -u #{user} git remote -v | grep #{config['repo']}"
  end

  file "#{dotfiles_dir}/.bashrc" do
    only_if "cd #{dotfiles_dir} && git status -uno | grep 'Initial commit'"
    action :delete
  end

  execute "Pull Origin for #{user}" do
    cwd dotfiles_dir
    command "sudo -H -u #{user} git pull origin master"
    only_if "cd #{dotfiles_dir} && git status -uno | grep 'Initial commit'"
  end

  execute "Get Submodules for #{user}" do
    cwd dotfiles_dir
    command "sudo -H -u #{user} git submodule update --init"
  end

  execute "#{dotfiles_dir}/configure.sh" do
    command "sudo -H -u #{user} #{dotfiles_dir}/configure.sh"
  end
end
