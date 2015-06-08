# == Class: mail_aliases
#
# The mail_aliases module manages /etc/aliases entries via hiera lookups.
#
# === Parameters
#
# The aliases are stored in hiera and should look like this. The default is
# ensure => present, so if you want the account removed make sure to include
# the ensure: absent line.
#
# ---
# mail_aliases:
#   root:
#     recipient: 'someone@somewhere.else.com'
#   user:
#     recipient: 'their@real.address'
#   olduser:
#     recipient: 'not@work.anymore'
#     ensure: absent
#
# === Examples
#
# include mail_aliases
#
# === Authors
#
# Patrick St. Jean <stjeanp@pat-st-jean.com>
#
# === Copyright
#
# Copyright 2014 Patrick St. Jean.
#
# Create mail aliases based on hiera data and run newaliases if there's
# been a change

class mail_aliases ( $default_aliases = false ) {
  case $::osfamily {
    'RedHat': {
      $aliases_file = '/etc/aliases'
      $newaliases = '/usr/bin/newaliases'
    }
    'Debian': {
      $aliases_file = '/etc/aliases'
      $newaliases = '/usr/bin/newaliases'
    }
    'Suse': {
      $aliases_file = '/etc/aliases'
      $newaliases = '/usr/bin/newaliases'
    }
    default: {
      fail("OS family '${::osfamily}' is not supported by this module.")
    }
  }

  # Our command to refresh the aliases database
  exec { 'newaliases':
    command     => $newaliases,
    refreshonly => true,
  }
  Mailalias { notify => Exec['newaliases'] }

  # We need a default hash in case there's no hiera data
  $not_found = { 'not found' => 'not found' }

  # Do a deep merge of all matching 'mail_aliases' data from hiera
  $alias_hash = hiera_hash('mail_aliases', $not_found)

  # Allow someone to pass defaults as parameters when using roles and profiles
  if $default_aliases {
    if has_key($alias_hash, 'not found') {
      $merged_hash = $default_aliases
    } else {
      $merged_hash = merge($default_aliases, $alias_hash)
    }

    # Otherwise, process the resources...
    $defaults = {
      'ensure' => 'present',
    }
    create_resources(mailalias, $merged_hash, $defaults)
  }
  else {
    if has_key($alias_hash, 'not found') {
      # If we didn't have any matches, print out an informational
      info('No aliases found.')
    } else {
      # Otherwise, process the resources...
      $defaults = {
        'ensure' => 'present',
      }
      create_resources(mailalias, $alias_hash, $defaults)
    }
  }
}
