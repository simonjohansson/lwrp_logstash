action :create do
  data = @new_resource.data 
  name = @new_resource.name
  template "/etc/logstash/conf.d/#{name}.conf" do
    source "output.erb"
    cookbook "lwrp_cookbook"
    action :create
    variables({
     :data => data
    })
  end
end

