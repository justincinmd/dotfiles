# See https://github.com/mitchellh/vagrant/issues/1303
# This works around an issue with ssh agent forwarding not working out of the
# box.
file "/etc/sudoers.d/root_ssh_agent" do
  owner 'root'
  group 'root'
  mode '0440'
  content "Defaults    env_keep += \"SSH_AUTH_SOCK\"\n"
  action :create
end
