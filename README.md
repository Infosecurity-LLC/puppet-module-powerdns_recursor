# Yet Another Puppet ::powerdns Module

[![Puppet Forge]
[![Build Status]

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

    powerdns::backend::gpgsql::host:     '127.0.0.1'
    powerdns::backend::gpgsql::user:     'username'
    powerdns::backend::gpgsql::password: 'password'
    powerdns::backend::gpgsql::dbname:   'powerdns'
    powerdns::backend::gpgsql::port:     5432
    powerdns::backend::gpgsql::dnssec:   'no'

## Todo

  * Consider supporting a chrooted installation.
  * Extend support to other distributions.
  * Add more tests.

