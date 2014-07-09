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
%w{ VisualStudio2013ExpressWeb webdeploy git git.commandline  }.each do |pack|
  chocolatey pack
  execute "install_#{pack}" do
    command "choco install #{pack}"
  end
end

# C# build tools
%w{ specflow XUnit stylecop fxcop PhantomJS javaruntime Sonar-runner  }.each do |pack|
  chocolatey pack
  execute "install_#{pack}" do
    command "choco install #{pack}"
  end
end

# Extra packages
node['windows_slave']['extra_pakages'].each do |pack|
  chocolatey pack
  execute "install_#{pack}" do
    command "choco install #{pack}"
  end
end

windows_package 'opencover' do
  source node['windows_slave']['opencover']
  action :install
  not_if {::File.exists?('c:/Windows/SysWOW64/config/systemprofile/AppData/Local/Apps/OpenCover/OpenCover.Console')}
end

windows_zipfile 'c:/pickles' do
  source node['windows_slave']['pickles']
  action :unzip
  not_if {::File.exists?('c:/pickles')}
end

windows_zipfile 'c:/Sonarqube' do
  source "http://repo1.maven.org/maven2/org/codehaus/sonar/runner/sonar-runner-dist/#{node['windows_slave']['sonar_version']}/sonar-runner-dist-#{node['windows_slave']['sonar_version']}.zip" 
  action :unzip
  not_if {::File.exists?("c:/Sonarqube/sonar-runner-#{node['windows_slave']['sonar_version']}")}
end

if !node['windows_slave']['Teamcity']['enable']
  # CI Stuff
  %w{ maven apache.ant Wget python2 }.each do |pack|
    chocolatey pack
  end
  hostsfile_entry node['windows_slave']['jenkins']['master_ip'] do
    hostname  'ci.ntstaging.org'
    unique    true
    action    :create_if_missing
  end
  template "c:/slave-startup.py" do
    source "jenkins.erb"
    variables(
      :user => node['windows_slave']['jenkins']['username'],
      :pass => node['windows_slave']['jenkins']['password'],
      :java => node['windows_slave']['jre'],
      :wget => node['windows_slave']['wget']
    )
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
