# Class: vim
#
# This module manages vim and set it as default editor.
#
# Parameters:
#   [*set_as_default*]
#     Set editor as default editor.
#     Default: true
#
#   [*ensure*]
#     Ensure if present or absent.
#     Default: present
#
#   [*autoupgrade*]
#     Upgrade package automatically, if there is a newer version.
#     Default: false
#
#   [*package*]
#     Name of the package.
#     Only set this, if your platform is not supported or you know, what you're doing.
#     Default: auto-set, platform specific
#
#   [*set_editor_cmd*]
#     Command to set editor as default editor.
#     Only set this, if your platform is not supported or you know, what you're doing.
#     Default: auto-set, platform specific
#
#   [*test_editor_set*]
#     Command to check, if editor is set as default.
#     Only set this, if your platform is not supported or you know, what you're doing.
#     Default: auto-set, platform specific
#
#   [*jump_last*]
#     Configures vim to jump to last place open in the file
#     Default: true
#
#   [*indent*]
#     Turns on automatic indent rules
#     Default: true
#
#   [*showcmd*]
#     Show (partial) command in status line.
#     Default: true
#
#   [*showmatch*]
#     Show matching brackets.
#     Default: true
#
#   [*ignorecase*]
#     Do case insensitive matching
#     Default: false
#
#   [*smartcase*]
#     Do smart case matching
#     Default: true
#
#   [*incsearch*]
#     Incremental search
#     Default: true
#
# Actions:
#   Installs vim and, if enabled, set it as default editor.
#
# Requires:
#   Nothing
#
# Sample Usage:
#   class { 'vim': }
#
# [Remember: No empty lines between comments and class definition]
class vim(
  $set_as_default = $vim::params::set_as_default,
  $ensure = 'present',
  $autoupgrade = false,
  $package = $vim::params::package,
  $set_editor_cmd = $vim::params::set_editor_cmd,
  $test_editor_set = $vim::params::test_editor_set,
  $jump_last = $vim::params::jump_last,
  $indent = $vim::params::indent,
  $showcmd = $vim::params::showcmd,
  $showmatch = $vim::params::showmatch,
  $ignorecase = $vim::params::ignorecase,
  $smartcase = $vim::params::smartcase,
  $incsearch = $vim::params::incsearch
) inherits vim::params {

  case $ensure {
    /(present)/: {
      if $autoupgrade == true {
        $package_ensure = 'latest'
      } else {
        $package_ensure = 'present'
      }
    }
    /(absent)/: {
      $package_ensure = 'absent'
    }
    default: {
      fail('ensure parameter must be present or absent')
    }
  }

  package { $package:
    ensure => $package_ensure,
  }

  if $set_as_default {
    exec { $set_editor_cmd:
      path    => '/usr/bin:/usr/sbin',
      unless  => $test_editor_set,
      require => Package[$package],
    }
  }

  file { '/etc/vim/vimrc.local':
    ensure => present,
    owner  => 'root',
    group => 'root',
    mode => 444,
    content => template('vim/vimrc.local.erb'),
    replace => 'true',
  }

}
