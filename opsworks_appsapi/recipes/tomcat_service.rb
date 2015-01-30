service 'tomcat' do
  service_name node['opsworks_appsapi']['tomcat']['service_name']

  case node[:platform_family]
  when 'debian'
    supports :restart => true, :reload => false, :status => true
  when 'rhel'
    supports :restart => true, :reload => true, :status => true
  end

  action :nothing
end
