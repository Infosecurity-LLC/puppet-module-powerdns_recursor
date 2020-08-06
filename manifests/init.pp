# == Class: powerdns_recursor
#
# Copyright 2016 Joshua M. Keyes <joshua.michael.keyes@gmail.com>
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

class powerdns_recursor (
  Hash              $settings       = {},
  Optional[String]  $package_name   = undef,
  Optional[String]  $package_ensure = undef,
  Optional[String]  $service_name   = undef,
  Optional[String]  $service_ensure = undef,
  Optional[String]  $service_enable = undef,
  Optional[String]  $config_owner   = undef,
  Optional[String]  $config_group   = undef,
  Optional[String]  $config_mode    = undef,
  Optional[String]  $config_path    = undef,
  Optional[Boolean] $config_purge   = undef,
  Optional[String]  $config_listen  = undef,
  Optional[String]  $config_setuid  = undef,
  Optional[String]  $config_setgid  = undef,
) {
  # Fail fast if we're not using a new Puppet version.
  if versioncmp($::puppetversion, '3.7.0') < 0 {
    fail('This module requires the use of Puppet v3.7.0 or newer.')
  }

  validate_hash($settings)

  contain '::powerdns_recursor::install'
  contain '::powerdns_recursor::config'
  contain '::powerdns_recursor::service'

  Class['::powerdns_recursor::install'] ->
  Class['::powerdns_recursor::config'] ~>
  Class['::powerdns_recursor::service']

}
