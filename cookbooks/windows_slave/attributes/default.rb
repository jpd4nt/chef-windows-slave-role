#
# Cookbook Name:: windows_slave
# Recipe:: default
#
# Copyright 2014, National Theatre
#
# All rights reserved - Do Not Redistribute
#

default['windows_slave']['extra_pakages']          = {}
default['windows_slave']['jre']                    = "C:\\\\Program Files\\\\Java\\\\jre7\\\\bin\\\\java"
default['windows_slave']['wget']                   = "wget"
default['windows_slave']['Teamcity']['enable']     = false
default['windows_slave']['Teamcity']['serverurl']  = 'http://localhost:8111'
default['windows_slave']['Teamcity']['local_path'] = 'Z:\\TeamCity'
default['windows_slave']['pickles']              = 'https://github.com/picklesdoc/pickles/releases/download/v1.0.0/Pickles-exe-1.0.0.zip'
default['windows_slave']['opencover']            = 'https://github.com/OpenCover/opencover/releases/download/4.5.3522/opencover.4.5.3522.msi'
default['windows_slave']['jenkins']['master_ip'] = '10.210.194.249'
default['windows_slave']['jenkins']['username']  = 'changeme'
default['windows_slave']['jenkins']['password']  = 'changeme'
default['windows_slave']['sonar_version']        = '2.4'
default['windows_slave']['resharper']            = 'https://download.jetbrains.com/resharper/ReSharperCommandLineTools01Update1.zip'
default['windows_slave']['choco_path']           = 'C:/ProgramData/chocolatey/bin'