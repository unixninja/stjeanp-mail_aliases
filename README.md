#mail_aliases [![Build Status](https://travis-ci.org/stjeanp/stjeanp-mail_aliases.svg?branch=master)](https://travis-ci.org/stjeanp/stjeanp-mail_aliases)

####Table of Contents

1. [Overview](#overview)
2. [Module Description - What the module does and why it is useful](#module-description)
3. [Setup - The basics of getting started with mail_aliases](#setup)
    * [What mail_aliases affects](#what-mail_aliases-affects)
    * [Setup requirements](#setup-requirements)
    * [Beginning with mail_aliases](#beginning-with-mail_aliases)
4. [Usage - Configuration options and additional functionality](#usage)
5. [Reference - An under-the-hood peek at what the module is doing and how](#reference)
5. [Limitations - OS compatibility, etc.](#limitations)
6. [Development - Guide for contributing to the module](#development)

##Overview

This module uses data stored in hiera to manage mail aliases on Linux systems. Currently it works on any OS that sets $::osfamily to RedHat, Debian, or Suse.

##Module Description

The mail_aliases module manages mail aliases on the target systems using data stored in hiera. It is capable of both creating and removing aliases, with the default being to create them.

##Setup

###What mail_aliases affects

* The aliases file on the target systems.

###Setup Requirements **REQUIRED**

* You must enable deep hash merges in your hiera configuration.
* You must install the deep_merge gem for this module to function correctly.
	
###Beginning with mail_aliases	

Ensure that deep merges are enabled in hiera and that you've installed the deep_merge gem.

##Usage

In at least one level of your hiera data, create aliases you wish to manage.

```yaml
 mail_aliases:
   root:
     recipient: 'someone@somewhere.else.com'
   user:
     recipient: 'their@real.address'
   olduser:
     recipient: 'not@work.anymore'
     ensure: absent
```

The default behavior is to create an alias, so if you need to remove one, make sure to include the 'ensure: absent' line.

```puppet
include mail_aliases
```

##Reference

####Class: `mail_aliases`

##Limitations

This module has been tested on :
* Red Hat Enterprise Linux (RHEL) 6.5
* CentOs 6.5
* Debian 7.7.0
* OpenSUSE 13.1
* Ubuntu Server 14.04

It should work on :
* Red Hat Enterprise Linux (RHEL) 5,6,7
* CentOs 5,6,7
* Oracle Linux 5,6,7
* Scientific Linux 5,6,7
* Debian 6,7
* OpenSuSE 13
* Ubuntu 14

##Development

Updates and tweaks are welcome.
