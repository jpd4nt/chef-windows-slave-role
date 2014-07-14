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
  not_if {::File.exists?("#{ENV['localappdata']}/Apps/OpenCover/OpenCover.Console.exe")}
end
execute "register_opencover_x86" do
  cwd "#{ENV['localappdata']}/Apps/OpenCover"
  command "regsvr32 x86/OpenCover.Profiler.dll /s"
end
execute "register_opencover_x64" do
  cwd "#{ENV['localappdata']}/Apps/OpenCover"
  command "regsvr32 x64/OpenCover.Profiler.dll /s"
end

cookbook_file "FxCopCmd.exe.config" do
  path "C:/Program Files (x86)/Microsoft Fxcop 10.0/FxCopCmd.exe.config"
  action :create
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

windows_zipfile 'c:/reshaper' do
  source node['windows_slave']['reshaper']
  action :unzip
  not_if {::File.exists?('c:/reshaper')}
end

if !node['windows_slave']['Teamcity']['enable']
  # CI Stuff
  %w{ maven apache.ant Wget python2 }.each do |pack|
    chocolatey pack
    execute "install_#{pack}" do
      command "choco install #{pack}"
    end
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
  cookbook_file "JenkinsSpotSlave.xml" do
    path "C:/JenkinsSpotSlave.xml"
    action :create
  end
  execute "slave_task" do
    command "schtasks /Create /TN \"Jenkins Spot Slave\" /RU SYSTEM /F /xml C:/JenkinsSpotSlave.xml"
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
