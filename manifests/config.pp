# == Class: powerdns_recursor::config
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

class powerdns_recursor::config {
  if $caller_module_name != $module_name {
    fail("Use of private class ${name} from ${caller_module_name}")
  }

  $default_config_path  = $::osfamily ? {
    'Debian' => '/etc/powerdns',
    'RedHat' => '/etc/pdns',
    default  => undef,
  }

  $config_purge  = pick($::powerdns_recursor::config_purge, true)
  $config_owner  = pick($::powerdns_recursor::config_owner, 'root')
  $config_group  = pick($::powerdns_recursor::config_group, 'root')
  $config_mode   = pick($::powerdns_recursor::config_mode,  '0600')
  $config_path   = pick($::powerdns_recursor::config_path,  $default_config_path)
  $config_quiet  = pick($::powerdns_recursor::config_quiet, 'yes' )
  $config_listen = pick($::powerdns_recursor::config_listen, '127.0.0.1' )
  $config_setuid = pick($::powerdns_recursor::config_setuid, 'pdns' )
  $config_setgid = pick($::powerdns_recursor::config_setuid, 'pdns' )

  validate_bool($config_purge)

  validate_string($config_owner)
  validate_string($config_group)
  validate_string($config_mode)
  validate_string($config_quiet)
  validate_string($config_listen)
  validate_string($config_setuid)
  validate_string($config_setgid)
  validate_re($config_listen, '^(([0-9]|[1-9][0-9]|1[0-9]{2}|2[0-4][0-9]|25[0-5])\.){3}([0-9]|[1-9][0-9]|1[0-9]{2}|2[0-4][0-9]|25[0-5])$')

  validate_absolute_path($config_path)

  file { $config_path:
    ensure  => directory,
    owner   => $config_owner,
    group   => $config_group,
    purge   => $config_purge,
    recurse => $config_purge,
    force   => $config_purge,
    mode    => '0755'
  } ->

  concat { "${config_path}/recursor.conf":
    ensure => present,
    path   => "${config_path}/recursor.conf",
    owner  => $config_owner,
    group  => $config_group,
    mode   => $config_mode,
  }

  powerdns_recursor::setting { 'config-dir':
    value => $config_path,
  }

  powerdns_recursor::setting { 'quiet':
    value => $config_quiet,
  }

  powerdns_recursor::setting { 'local-address':
    value => $config_listen,
  }

  powerdns_recursor::setting { 'setuid':
    value => $config_setuid,
  }

  powerdns_recursor::setting { 'setgid':
    value => $config_setgid,
  }

  if empty($::powerdns_recursor::settings) == false {
    $settings = $::powerdns_recursor::settings
    $convert  = "(@settings.inject({}){|o,(k,v)|;o[k]={'value'=>v};o})"
    $options  = parsejson(inline_template("<%= ${convert}.to_json %>"))
    create_resources('powerdns_recursor::setting', $options)
  }
}
