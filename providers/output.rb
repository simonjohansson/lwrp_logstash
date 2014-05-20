action :create do
  data = @new_resource.data 
  name = @new_resource.name
  template "/etc/logstash/conf.d/#{name}.conf" do
    source "output.erb"
    cookbook "lwrp_logstash"
    action :create
    variables({
     :data => data
    })
    notifies :restart, resources(:service => "logstash"), :delayed
  end
end

