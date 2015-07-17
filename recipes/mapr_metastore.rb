log "\n=========== Start MapR mapr_metastore.rb =============\n"

#hive_install_version = "mapr-hivemetastore-#{node[:mapr][:hive_yum_version]}"
hive_meta_version=`yum list --showduplicates mapr-hive|grep "#{node[:mapr][:hive_version]}"|awk '{print $2}'|tail -1 - |tr -d '\n'`
#hive_meta_version=`yum --showduplicates list mapr-hive|grep "#{node[:mapr][:hive_version]}"`

print "\n\n\n\n\n\n\n\HIVE_VERSION_META = \"#{hive_meta_version}\"\n\n\n\n\n\n\n"

meta_server="#{node[:mapr][:hive_metastore]}"

bash 'install_mapr-hivemetastore' do
  code <<-EOH
    yum -y install "mapr-hivemetastore-#{hive_meta_version}"
    /opt/mapr/server/configure.sh -R
  EOH
end

include_recipe "mapr_hive::mapr_hive-site_config"
