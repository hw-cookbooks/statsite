default[:statsite][:path] = "/opt/statsite"
default[:statsite][:repo] = "git://github.com/armon/statsite.git"
default[:statsite][:ref] = "HEAD"
default[:statsite][:conf] = "/etc/statsite.conf"
default[:statsite][:owner] = "statsite"
default[:statsite][:group] = "statsite"
default[:statsite][:port] = 8125
default[:statsite][:loglevel] = "INFO"
default[:statsite][:flush_interval] = 10
default[:statsite][:timer_eps] = 0.01
default[:statsite][:stream_command] = ""

default[:statsite][:service_type] = "runit"
default[:statsite][:pid_file] = "/var/run/statsite/statsite.pid"
