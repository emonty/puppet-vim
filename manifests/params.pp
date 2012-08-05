class vim::params {
  case $::operatingsystem {
    ubuntu, debian: {
      $package = 'vim-nox'
      $editor_name = 'vim.nox'
      $set_as_default = true
      $set_editor_cmd = "update-alternatives --set editor /usr/bin/${editor_name}"
      $test_editor_set = "test /etc/alternatives/editor -ef /usr/bin/${editor_name}"
    }
    default: {
      fail("Unsupported platform: ${::operatingsystem}")
    }
  }
  $jump_last = true
  $indent = true
  $showcmd = true
  $showmatch = true
  $ignorecase = false
  $smartcase = true
  $incsearch = true
}
