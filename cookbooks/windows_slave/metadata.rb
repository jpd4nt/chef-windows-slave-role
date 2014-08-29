name              'windows_slave'
maintainer        'JPDrawneek'
maintainer_email  'jpdrawneek@nationaltheatre.org.uk'
license           'All rights reserved'
description       'Installs packages needed for build activities'
long_description IO.read(File.join(File.dirname(__FILE__), 'README.md'))
version           '0.1.2'
supports          'windows'
depends           'chocolatey'
depends           'hostsfile'
depends           'visualstudio'