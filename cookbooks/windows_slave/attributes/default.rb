#
# Cookbook Name:: windows_slave
# Recipe:: default
#
# Copyright 2014, National Theatre
#
# All rights reserved - Do Not Redistribute
#

default['windows_slave']['extra_pakages'] = {}
default['windows_slave']['Teamcity']['enable'] = false
default['windows_slave']['Teamcity']['serverurl'] = 'http://localhost:8111'
default['windows_slave']['Teamcity']['local_path'] = 'Z:\\TeamCity'
default['windows_slave']['pickles'] = 'https://github.com/picklesdoc/pickles/releases/download/v0.17.4/pickles-0.17.4.zip'
default['windows_slave']['opencover'] = 'http://download-codeplex.sec.s-msft.com/Download/Release?ProjectName=opencover&DownloadId=721036&FileTime=130217356001900000&Build=20911'