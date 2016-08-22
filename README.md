# Yet Another Puppet ::powerdns_recursor Module


#### Table of Contents

 1. [Overview](#overview)
 2. [Description](#description)
 3. [Todo](#todo)

## Overview

This is yet another Puppet module to manage a PowerDNS DNS recursor. It currently targets the
latest stable release of Puppet, and should support both Debian and RedHat family distributions.
Although RedHat wasn't tested yet.

*Beware that this module will recursively purge your distribution's default PowerDNS configuration.*

## Description

To use this module, use either an include-like or resource-like declaration:

    # An include-like declaration for Hiera integration.
    include ::powerdns_recursor

    # A resource-like declaration for manual overrides.
    class { '::powerdns_recursor': }

This module is intended to work with Puppet 4.x.

## Configuration

All configuration can be handled either through Hiera or by arguments to the `powerdns_recursor` class.

### PowerDNS recursor (using manifests)

    # Install PowerDNS:
    class { '::powerdns_recursor': }

### PowerDNS recursor (using Hiera)

    # In Hiera configuration:
    classes:
      - 'powerdns_recursor'

    powerdns_recursor::config_listen: '0.0.0.0'
    powerdns_recursor::settings:
      allow-from: "10.0.0.0/8"
      forward-zones: "localdomain=10.0.0.1,localdomain2=10.0.0.2"

## Todo

  * Consider supporting a chrooted installation.
  * Extend support to other distributions.
  * Add more tests.

