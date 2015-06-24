log "\n=========== Start MapR mapr_hs2.rb =============\n"


hive_install_version = "mapr-hiveserver2-#{node[:mapr][:hive_yum_version]}"

bash 'install_mapr-hs2' do
  code <<-EOH
  while (( `maprcli node list -columns hostname,svc|grep hivemeta|grep -v grep|wc -l` !=  1 )) 
    do
	sleep 5
    done
    sleep 60
    yum -y install #{hive_install_version} 
    /opt/mapr/server/configure.sh -R

  EOH
end
