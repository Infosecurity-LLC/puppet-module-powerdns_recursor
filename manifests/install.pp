# == Class: powerdns_recursor::install
#
# Copyright 2016 Jan Kaufman <jan.kaufman@prozeta.eu>
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

class powerdns_recursor::install {
  if $caller_module_name != $module_name {
    fail("Use of private class ${name} from ${caller_module_name}")
  }

  if $::osfamily == 'RedHat' and defined('::epel') {
    warning('This module requires EPEL on RedHat-based distributions.')
  }

  $default_package_name   = $::osfamily ? {
    'Debian' => 'pdns-recursor',
    'RedHat' => 'pdns-recursor',
    default  => undef,
  }

  $package_name   = pick($::powerdns_recursor::package_name, $default_package_name)
  $package_ensure = pick($::powerdns_recursor::package_ensure, 'installed')

  validate_string($package_name)

  validate_string($package_ensure)
  validate_re($package_ensure, '^(present|latest|nstalled|[._0-9a-zA-Z:-]+)$')

  package { $package_name:
    ensure => $package_ensure,
  }
}
