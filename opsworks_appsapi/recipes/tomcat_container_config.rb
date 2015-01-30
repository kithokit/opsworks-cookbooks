include_recipe 'opsworks_appsapi::tomcat_service'

template 'tomcat environment configuration' do
  path ::File.join(node['opsworks_appsapi']['tomcat']['system_env_dir'], "tomcat#{node['opsworks_appsapi']['tomcat']['base_version']}")
  source 'tomcat_env_config.erb'
  owner 'root'
  group 'root'
  mode 0644
  backup false
  notifies :restart, 'service[tomcat]'
end

template 'tomcat server configuration' do
  path ::File.join(node['opsworks_appsapi']['tomcat']['catalina_base_dir'], 'server.xml')
  source 'server.xml.erb'
  owner 'root'
  group 'root'
  mode 0644
  backup false
  notifies :restart, 'service[tomcat]'
end
