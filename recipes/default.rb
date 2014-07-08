#
# Cookbook Name:: statsite
# Recipe:: default
#
# Copyright 2013, Heavy Water Ops, Inc
#
# Licensed under the Apache License, Version 2.0 (the "License");
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at
#
#     http://www.apache.org/licenses/LICENSE-2.0
#
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.
#

#checkout
include_recipe "git"

git node[:statsite][:path] do
  repository node[:statsite][:repo]
  reference node[:statsite][:ref]
  action :sync
  not_if { ::FileTest.directory?("#{node[:statsite][:path]}/.git") }
end

# build
include_recipe "build-essential"
include_recipe "python"

package "scons"

execute "scons" do
  cwd node[:statsite][:path]
  action  :run
  creates "statsite"
end

# configure
group node[:statsite][:group] do
  system true
  action :create
end

user node[:statsite][:owner] do
  system true
  group  node[:statsite][:group]
end

# template
template node[:statsite][:conf] do
  owner node[:statsite][:owner]
  notifies :restart, "service[statsite]", :delayed
end


# service
service_type = node[:statsite][:service_type]

case service_type
when 'upstart'
  service_resource = 'service[statsite]'

  template "/etc/init/statsite.conf" do
    source   "upstart.statsite.erb"
    mode     "0644"
    variables(
      :conf    => node[:statsite][:conf],
      :path    => node[:statsite][:path],
      :user    => node[:statsite][:owner],
      :group   => node[:statsite][:group]
    )
  end

  service "statsite" do
    provider Chef::Provider::Service::Upstart
    supports :restart => true, :status => true
    action   [:enable, :start]
  end

when 'init'
  service_resource = 'service[statsite]'

  template "/etc/init.d/statsite" do
    source "init.statsite.erb"
    mode "0755"
    variables(
      :conf    => node[:statsite][:conf],
      :path    => node[:statsite][:path],
      :user    => node[:statsite][:owner],
      :group   => node[:statsite][:group],
      :pidfile => node[:statsite][:pid_file]
    )
  end

  service "statsite" do
    action  [:enable, :start]
  end

else
  service_resource = 'runit_service[statsite]'

  include_recipe "runit"
  runit_service  "statsite"
end

