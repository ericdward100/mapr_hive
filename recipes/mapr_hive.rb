log "\n=========== Start MapR mapr_hive.rb =============\n"

#Use bash block and do:
 #       yum -y install mapr-hive [:hive][:hive_yum_version]

#hive_install_version = "mapr-hive-#{node[:mapr][:hive_yum_version]}"
hive_install_version=`yum list --showduplicates mapr-hive|grep "#{node[:mapr][:hive_version]}"|awk '{print $2}'|tail -1 - |tr -d '\n'`

print "\n\n\n\hive_version = \"#{hive_install_version}\"\n\n\n"

bash 'install_mapr-hive' do
  code <<-EOH
    yum -y install "mapr-hive-#{hive_install_version}"
  EOH
end

include_recipe "mapr_hive::mapr_hive-site_config"
