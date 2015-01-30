ruby_block 'remove the ROOT webapp' do
  block do
    ::FileUtils.rm_rf(::File.join(node['opsworks_appsapi'][node['opsworks_appsapi']['java_app_server']]['webapps_base_dir'], 'ROOT'), :secure => true)
  end
  only_if { ::File.exists?(::File.join(node['opsworks_appsapi'][node['opsworks_appsapi']['java_app_server']]['webapps_base_dir'], 'ROOT')) && !::File.symlink?(::File.join(node['opsworks_appsapi'][node['opsworks_appsapi']['java_app_server']]['webapps_base_dir'], 'ROOT')) }
end
