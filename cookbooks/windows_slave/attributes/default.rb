#
# Cookbook Name:: windows_slave
# Recipe:: default
#
# Copyright 2014, National Theatre
#
# All rights reserved - Do Not Redistribute
#

default['windows_slave']['extra_pakages'] = {}
default['windows_slave']['jre'] = "C:\\\\Program Files\\\\Java\\\\jre7\\\\bin\\\\java"
default['windows_slave']['wget'] = "C:\\\\Chocolatey\\\\bin\\\\wget"
default['windows_slave']['Teamcity']['enable'] = false
default['windows_slave']['Teamcity']['serverurl'] = 'http://localhost:8111'
default['windows_slave']['Teamcity']['local_path'] = 'Z:\\TeamCity'
default['windows_slave']['pickles'] = 'https://github.com/picklesdoc/pickles/releases/download/v0.17.4/pickles-0.17.4.zip'
default['windows_slave']['opencover'] = 'https://github.com/OpenCover/opencover/releases/download/4.5.2506/opencover.4.5.2506.msi'
default['windows_slave']['jenkins']['master_ip'] = '10.210.194.249'
default['windows_slave']['jenkins']['username'] = 'changeme'
default['windows_slave']['jenkins']['password'] = 'changeme'