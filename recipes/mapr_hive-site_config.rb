ruby_block "Set HIVE_HOME in /etc/profile" do
  block do
        file  = Chef::Util::FileEdit.new("/opt/mapr/hive/hive-0.13/conf/hive-site.xml")



	file.search_file_replace_line("<configuration>","<configuration>
 

<property>
    <name>javax.jdo.option.ConnectionURL</name>
    <value>jdbc:mysql://#{node[:mapr][:mysql_server]}:3306/hive?createDatabaseIfNotExist=true</value>
    <description>JDBC connect string for a JDBC metastore</description>
</property>
 
 <property>
    <name>javax.jdo.option.ConnectionDriverName</name>
    <value>com.mysql.jdbc.Driver</value>
    <description>Driver class name for a JDBC metastore</description>
 </property>
 
 <property>
    <name>javax.jdo.option.ConnectionUserName</name>
    <value>#{node[:mapr][:mysql_user]}</value>
    <description>username to use against metastore database</description>
 </property>
 
 <property>
    <name>javax.jdo.option.ConnectionPassword</name>
    <value>#{node[:mapr][:mysql_pw]}</value>
    <description>password to use against metastore database</description>
 </property>
 
 <property>
    <name>hive.metastore.uris</name>
    <value>thrift://#{node[:mapr][:hive_metastore]}:9083</value>
 </property>

")
  file.write_file
  end
end
