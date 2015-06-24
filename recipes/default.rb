#
# Cookbook Name:: mapr_hive
# Recipe:: default
#
# Copyright 2015, YOUR_COMPANY_NAME
#
# All rights reserved - Do Not Redistribute
#

log "\n=========== Start mapr_hive default.rb =============\n"

#Parameter settings, user definitions, etc
#include_recipe "mapr_installation"

ruby_block "Set HIVE_HOME in /etc/profile" do
  block do
        file  = Chef::Util::FileEdit.new("/etc/profile")

        file.search_file_delete_line("HIVE_HOME")

        file.insert_line_if_no_match("export HIVE_HOME=","export HIVE_HOME=#{node[:mapr][:home]}/hive/#{node[:mapr][:hive_version]}")
        file.insert_line_if_no_match("export PATH=\$PATH:\$HIVE_HOME/bin","export PATH=$PATH:$HIVE_HOME/bin")

        file.write_file
  end
end



#Install Hive service from attributes
node["mapr"]["hive"].each do |hive|
#if node['fqdn'] == node["mapr"]["hive"]
  log "  p#{node["mapr"]["hive"]}p  vs  p#{node['fqdn']}p\n" 
  if node['fqdn'] == "#{hive}"
    print "\nWill install hive on node: #{node['fqdn']}\n"
    include_recipe "mapr_hive::mapr_hive"
  end
end


#Install Hive Metastore service from attributes
#node["mapr"]["hive_metastore"].each do |meta|
  if node['fqdn'] == "#{node[:mapr][:hive_metastore]}"
    print "\nWill install Hive Metastore on node: #{node['fqdn']}\n"
    include_recipe "mapr_hive::mapr_metastore"
  end
#end

#Install Hiveserver2 service from attributes
#node["mapr"]["hs2"].each do |hs2|
  if node['fqdn'] == "#{node[:mapr][:hs2]}"
    print "\nWill install Hiveserver2 on node: #{node['fqdn']}\n"
    include_recipe "mapr_hive::mapr_hs2"
  end
#end


include_recipe "mapr_hive::mapr_hive-site_config"


#RUN /opt/mapr/server/configure.sh -R
