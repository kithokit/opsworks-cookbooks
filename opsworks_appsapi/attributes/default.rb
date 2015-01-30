###
# Do not use this file to override the opsworks_appsapi cookbook's default
# attributes.  Instead, please use the customize.rb attributes file,
# which will keep your adjustments separate from the AWS OpsWorks
# codebase and make it easier to upgrade.
#
# However, you should not edit customize.rb directly. Instead, create
# "opsworks_appsapi/attributes/customize.rb" in your cookbook repository and
# put the overrides in YOUR customize.rb file.
#
# Do NOT create an 'opsworks_appsapi/attributes/default.rb' in your cookbooks. Doing so
# would completely override this file and might cause upgrade issues.
#
# See also: http://docs.aws.amazon.com/opsworks/latest/userguide/customizing.html
###

default['opsworks_appsapi'] = {}

default['opsworks_appsapi']['jvm'] = 'openjdk'
default['opsworks_appsapi']['jvm_version'] = '7'
default['opsworks_appsapi']['jvm_options'] = ''
default['opsworks_appsapi']['java_app_server'] = 'tomcat'
default['opsworks_appsapi']['java_app_server_version'] = '7.0'

default['opsworks_appsapi']['jvm_pkg'] = {}
default['opsworks_appsapi']['jvm_pkg']['use_custom_pkg_location'] = false
default['opsworks_appsapi']['jvm_pkg']['custom_pkg_location_url_debian'] = 'http://aws.amazon.com/'
default['opsworks_appsapi']['jvm_pkg']['custom_pkg_location_url_rhel'] = 'https://aws.amazon.com/'
case node[:platform_family]
when 'debian'
  default['opsworks_appsapi']['jvm_pkg']['name'] = "openjdk-#{node['opsworks_appsapi']['jvm_version']}-jdk"
when 'rhel'
  default['opsworks_appsapi']['jvm_pkg']['name'] = "java-1.#{node['opsworks_appsapi']['jvm_version']}.0-openjdk-devel"
end
default['opsworks_appsapi']['jvm_pkg']['java_home_basedir'] = '/usr/local'

default['opsworks_appsapi']['datasources'] = {}

default['opsworks_appsapi']['tomcat']['base_version'] = node['opsworks_appsapi']['java_app_server_version'].to_i
default['opsworks_appsapi']['tomcat']['service_name'] = "tomcat#{node['opsworks_appsapi']['tomcat']['base_version']}"
default['opsworks_appsapi']['tomcat']['port'] = 8080
default['opsworks_appsapi']['tomcat']['secure_port'] = 8443
default['opsworks_appsapi']['tomcat']['ajp_port'] = 8009
default['opsworks_appsapi']['tomcat']['shutdown_port'] = 8005
default['opsworks_appsapi']['tomcat']['uri_encoding'] = 'UTF-8'
default['opsworks_appsapi']['tomcat']['unpack_wars'] = true
default['opsworks_appsapi']['tomcat']['auto_deploy'] = true
default['opsworks_appsapi']['tomcat']['java_opts'] = node['opsworks_appsapi']['jvm_options']
default['opsworks_appsapi']['tomcat']['userdatabase_pathname'] = 'conf/tomcat-users.xml'
default['opsworks_appsapi']['tomcat']['use_ssl_connector'] = false
default['opsworks_appsapi']['tomcat']['use_threadpool'] = false
default['opsworks_appsapi']['tomcat']['threadpool_max_threads'] = 150
default['opsworks_appsapi']['tomcat']['threadpool_min_spare_threads'] = 4
default['opsworks_appsapi']['tomcat']['connection_timeout'] = 20000
default['opsworks_appsapi']['tomcat']['catalina_base_dir'] = "/etc/tomcat#{node['opsworks_appsapi']['tomcat']['base_version']}"
default['opsworks_appsapi']['tomcat']['webapps_base_dir'] = "/var/lib/tomcat#{node['opsworks_appsapi']['tomcat']['base_version']}/webapps"
default['opsworks_appsapi']['tomcat']['lib_dir'] = "/usr/share/tomcat#{node['opsworks_appsapi']['tomcat']['base_version']}/lib"
default['opsworks_appsapi']['tomcat']['java_shared_lib_dir'] = '/usr/share/java'
default['opsworks_appsapi']['tomcat']['context_dir'] = ::File.join(node['opsworks_appsapi']['tomcat']['catalina_base_dir'], 'Catalina', 'localhost')
default['opsworks_appsapi']['tomcat']['mysql_connector_jar'] = 'mysql-connector-java.jar'
default['opsworks_appsapi']['tomcat']['apache_tomcat_bind_mod'] = 'proxy_http' # or: 'proxy_ajp'
default['opsworks_appsapi']['tomcat']['apache_tomcat_bind_path'] = '/'
default['opsworks_appsapi']['tomcat']['webapps_dir_entries_to_delete'] = %w(config log public tmp)
case node[:platform_family]
when 'debian'
  default['opsworks_appsapi']['tomcat']['user'] = "tomcat#{node['opsworks_appsapi']['tomcat']['base_version']}"
  default['opsworks_appsapi']['tomcat']['group'] = "tomcat#{node['opsworks_appsapi']['tomcat']['base_version']}"
  default['opsworks_appsapi']['tomcat']['system_env_dir'] = '/etc/default'
when 'rhel'
  default['opsworks_appsapi']['tomcat']['user'] = 'tomcat'
  default['opsworks_appsapi']['tomcat']['group'] = 'tomcat'
  default['opsworks_appsapi']['tomcat']['system_env_dir'] = '/etc/sysconfig'
end

include_attribute "opsworks_appsapi::customize"
