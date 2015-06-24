log "\n=========== Start MapR mapr_metastore.rb =============\n"

hive_install_version = "mapr-hivemetastore-#{node[:mapr][:hive_yum_version]}"
meta_server="#{node[:mapr][:hive_metastore]}"

bash 'install_mapr-hivemetastore' do
  code <<-EOH
    yum -y install #{hive_install_version} 
    /opt/mapr/server/configure.sh -R
  EOH
end
