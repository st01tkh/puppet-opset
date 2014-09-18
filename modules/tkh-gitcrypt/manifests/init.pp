# == Class: tkh-gitcrypt
#
# gitcrypt setup
#
# === Parameters
#
# Document parameters here.
#
# [*sample_parameter*]
#   Explanation
#
# === Variables
#
# Here you should define a list of variables that this module would require.
#
# [*sample_variable*]
#   Explanation
#
# === Examples
#
#  class { 'tkh-gitcrypt':
#  }
#
# === Authors
#
# tkh <st01.tkh@gmail.com>
#
# === Copyright
#
# Copyright 2014 tkh
#
class tkh-gitcrypt {
  file {'gitcrypt_dir':
    path => 'C:/ProgramData/git-crypt',
    ensure => directory,
  }
  $cdate = strftime("%Y%m%d%H%M%S")
  exec {'bak_git-encrypt':
    path => [
      'C:/Windows',
      'C:/Windows/System32',
    ],
    cwd => "C:/ProgramData/git-crypt",
    command => "cmd /c move git-encrypt git-encrypt.$cdate.bak",
    onlyif => 'cmd /c if exist C:\ProgramData\git-crypte\git-encrypt (exit /b 0) else (exit /b 0)'
  }
  exec {"git_clone_gitcrypt":
    path => [
      "C:/Program Files (x86)/Git/cmd",
      "C:/Chocolatey/bin",
      "C:/Windows",
      "C:/Windows/System32",
      'C:/Windows/System32/WindowsPowerShell/v1.0',
    ],
    cwd => 'C:/ProgramData/git-crypt',
    command => "git clone https://github.com/shadowhand/git-encrypt.git",
  }
  file {"gitcrypt_cmd":
    path => "C:/Program Files (x86)/Git/cmd/gitcrypt.cmd",
    source => 'puppet:///modules/tkh-gitcrypt/gitcrypt.cmd',
    source_permissions => ignore,
    ensure => present,
  }
  file {"gitcrypt_bash_cmd":
    path => "C:/Program Files (x86)/Git/cmd/gitcrypt_bash.cmd",
    source => 'puppet:///modules/tkh-gitcrypt/gitcrypt_bash.cmd',
    source_permissions => ignore,
    ensure => present,
  }
  File['gitcrypt_dir']->Exec['bak_git-encrypt']->
  Exec['git_clone_gitcrypt']->File['gitcrypt_cmd']->File['gitcrypt_bash_cmd']
}
