log "\n=========== Start MapR mapr_hs2.rb =============\n"


#hive_install_version = "mapr-hiveserver2-#{node[:mapr][:hive_yum_version]}"
hive_install_version=`yum list --showduplicates mapr-hive|grep "#{node[:mapr][:hive_version]}"|awk '{print $2}'|tail -1 - |tr -d '\n'`

bash 'install_mapr-hs2' do
  code <<-EOH
  while (( `maprcli node list -columns hostname,svc|grep hivemeta|grep -v grep|wc -l` !=  1 )) 
    do
	sleep 5
    done
    sleep 60
    yum -y install mapr-hiveserver2-#{hive_install_version} 
    /opt/mapr/server/configure.sh -R

  EOH
end

bash 'create workspace dir' do
    code <<-EOH
      hadoop fs -mkdir -p /user/hive/warehouse
      hadoop fs -chown -R #{node[:mapr][:user]}:#{node[:mapr][:group]} /user/hive
      hadoop fs -chmod -R 777 /user/hive
    EOH
end

include_recipe "mapr_hive::mapr_hive-site_config"
