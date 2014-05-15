A quick, dirty and ugly cookbook to provide to providers to add inputs and outputs to logstash


```
	
input_syslog = {
    "syslog":{
        "type":"cf",
        "port": 10000
    }
}

input_gelf = {
    "gelf: {}
}

lwrp_logstash_input "syslog_for_cf" do
    data input_syslog
end

lwrp_logstash_input "gelf" do
    data input_gelf
end

```

yields 


```

$ ls /etc/logstash/conf.d/
syslog_for_cf.conf  gelf.conf

$ tail  /etc/logstash/conf.d/*
==> /etc/logstash/conf.d/syslog_for_cf.conf <==
input {  
  syslog {
      type => cf
      port => 10000
  }
}

==> /etc/logstash/conf.d/gelf.conf <==
input {  
  gelf {
  }
}

```
