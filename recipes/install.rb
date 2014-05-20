case node["platform"]
when "debian", "ubuntu"
  include_recipe "apt::default"
  apt_repository "logstash" do
    uri "http://packages.elasticsearch.org/logstash/1.4/debian/"
    distribution "stable"
    components ["main"]
    trusted true
  end
when "redhat", "centos", "fedora"
  yum_repository 'logstash' do
    description "Logstash repository for 1.4 packages from Elasticsearch"
    baseurl "http://packages.elasticsearch.org/logstash/1.4/centos/"
    gpgkey 'http://packages.elasticsearch.org/GPG-KEY-elasticsearch'
    action :create
  end
end

package 'logstash'

service "logstash" do
  supports :status => true, :restart => true, :start => true, :stop => true
  action [ :enable , :start ]
end
