#
# Cookbook Name:: windows_slave
# Recipe:: default
#
# Copyright 2014, National Theatre
#
# All rights reserved - Do Not Redistribute
#
include_recipe 'powershell::powershell5'

# C# build stuff
%w{ VisualStudio2013ExpressWeb webdeploy git.commandline  }.each do |pack|
  chocolatey pack
end

# C# build tools
%w{ specflow XUnit stylecop PhantomJS }.each do |pack|
  chocolatey pack
end

# Extra packages
node['windows_slave']['extra_pakages'].each do |pack|
  chocolatey pack
end

windows_package 'opencover' do
  source node['windows_slave']['opencover']
  action :install
end

windows_zipfile 'c:/pickles' do
  source node['windows_slave']['pickles']
  action :unzip
  not_if {::File.exists?('c:/pickles')}
end

if !node['windows_slave']['Teamcity']['enable']
  # CI Stuff
  %w{ javaruntime Sonar-runner maven apache.ant }.each do |pack|
    chocolatey pack
  end
else
  chocolatey javaruntime
  chocolatey TeamCityAgent do
    args "serverurl=#{node['windows_slave']['Teamcity']['serverurl']} agentName=#{node['fqdn']} agentDir=#{node['windows_slave']['Teamcity']['local_path']}"
  end
  directory node['windows_slave']['Teamcity']['local_path'] do
    action :create
  end
end