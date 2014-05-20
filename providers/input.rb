use_inline_resources

action :create do
  data = @new_resource.data 
  name = @new_resource.name
  template "/etc/logstash/conf.d/#{name}.conf" do
    source "input.erb"
    cookbook "lwrp_logstash"
    action :create
    variables({
     :data => data
    })
  end
end

