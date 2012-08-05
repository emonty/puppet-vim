# puppet-vim

Manage vim via puppet and set it as default editor

## Usage

```
    class { 'vim': }
```

## Other class parameters
* set_as_default: true or false, default: true.
* ensure: present or absent, default: present.
* autoupgrade: true or false, default: false. 
* set_editor_cmd: string, default: OS specific. Set set_editor_cmd, if platform is not supported.
* test_editor_set: string, default: OS specific. Set test_editor_set, if platform is not supported.
* jump_last: true or false, default: true. Jump to the last position when reopening a file
* indent: true or false, default: true. Load indentation rules and plugins according to the detected filetype.
* showcmd: true or false, default: true. Show (partial) command in status line.
* showmatch: true or false, default: true. Show matching brackets.
* ignorecase: true or false, default: false. Do case insensitive matching
* smartcase: true or false, default: true. Do smart case matching
* incsearch: true or false, default: true. Incremental search
