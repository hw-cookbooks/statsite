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
  action :run
  creates "statsite"
end

# configure
user node[:statsite][:owner]
group node[:statsite][:group]

template node[:statsite][:conf] do
  owner node[:statsite][:owner]
end

# runit_service
include_recipe "runit"

runit_service "statsite"
