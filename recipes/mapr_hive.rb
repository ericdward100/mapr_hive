log "\n=========== Start MapR mapr_hive.rb =============\n"

#Use bash block and do:
 #       yum -y install mapr-hive [:hive][:hive_yum_version]

hive_install_version = "mapr-hive-#{node[:mapr][:hive_yum_version]}"

bash 'install_mapr-hive' do
  code <<-EOH
    yum -y install #{hive_install_version} 
  EOH
end

