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

Usage
=====

`recipe[statsite]` install, build and start with runit
