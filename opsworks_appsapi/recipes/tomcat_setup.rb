include_recipe 'opsworks_appsapi::tomcat_install'
include_recipe 'opsworks_appsapi::tomcat_service'

service 'tomcat' do
  action :enable
end

# for EBS-backed instances we rely on autofs
bash '(re-)start autofs earlier' do
  user 'root'
  code <<-EOC
    service autofs restart
  EOC
  notifies :restart, 'service[tomcat]'
end

include_recipe 'opsworks_appsapi::tomcat_container_config'
include_recipe 'apache2'
include_recipe 'opsworks_appsapi::apache_tomcat_bind'
