Description
===========

Installs and configures statsite, statsd implementation. https://github.com/armon/statsite

Requirements
============

* Ubuntu 10.04 / Ubuntu 12.04
* python
* git
* runit

Attributes
==========

* `node[:statsite][:path]` - Default setting:  "/opt/statsite"
* `node[:statsite][:repo]` - Default setting:  "git://github.com/armon/statsite.git"
* `node[:statsite][:conf]` - Default setting:  "/etc/statsite.conf"
* `node[:statsite][:owner]` - Default setting:  "statsite"
* `node[:statsite][:group]` - Default setting:  "statsite"
* `node[:statsite][:port]` - Default setting:  8125
* `node[:statsite][:loglevel]` - Default setting:  "INFO"
* `node[:statsite][:flush_interval]` - Default setting:  10
* `node[:statsite][:timer_eps]` - Default setting:  0.01
* `node[:statsite][:stream_command]` - Optional handler. Default setting:  ''
* `default[:statsite][:service_type]`  - Can be "runit" or "upstart". Default: "runit"

Usage
=====

`recipe[statsite]` install, build and start with either runit or upstart

Histogram 
=========
Additional histograms can be defined in `node[:statsite][:histogram]` attribute.

Role example:
 
```
{
...
  "default_attributes": {
    "statsite": {
      "port": 18125,
      "stream_command": "python /opt/statsite/sinks/graphite.py graphite.recfut.com 2003 statsite",
      "service_type": "upstart",
      "histogram": {
        "histogram_api": {
          "prefix": "api",
          "min": 0,
          "max": 100,
          "width": 5
        }
      }
    }
  }
...  
}
```