class tkh-gitcrypt::setup {
  $gitcrypt_dir = $osfamily ? {
    /windows/ => "C:\\ProgramData\\gitcrypt",
    default => '/opt/gitcrypt'
  }
  $parent_dir = dirname($gitcrypt_dir)
  $dir_basename = basename($gitcrypt_dir)
  $bak_path = bak_mv($gitcrypt_dir)
  file {'gitcrypt_parent_dir':
    path => $parent_dir,
    ensure => directory,
  }
  if $osfamily == 'windows' {
    exec {"git_clone_gitcrypt":
      path => [
        "C:/Program Files (x86)/Git/cmd",
        "C:/Chocolatey/bin",
        "C:/Windows",
        "C:/Windows/System32",
        'C:/Windows/System32/WindowsPowerShell/v1.0',
      ],
      cwd => $parent_dir,
      command => "git clone https://github.com/shadowhand/git-encrypt.git $dir_basename",
    }
    #$gitcrypt_path = file_join($gitcrypt_dir, 'gitcrypt')
    $gitcrypt_path = file_join_win($gitcrypt_dir, 'gitcrypt')
    $git_cmd_dir = "C:\\Program Files (x86)\\Git\\cmd"
    $git_bash_path = "C:\\Program Files (x86)\\Git\\bin\\bash.exe"
    $gitcrypt_cmd = file_join($git_cmd_dir, 'gitcrypt.cmd')
    $gitcrypt_bash_cmd = file_join($git_cmd_dir, 'gitcrypt_bash.cmd')

    file {"gitcrypt_cmd":
      path => $gitcrypt_cmd,
      content => template('tkh-gitcrypt/gitcrypt.cmd.erb'),
      source_permissions => ignore,
      ensure => present,
    }
    file {"gitcrypt_bash_cmd":
      path => $gitcrypt_bash_cmd,
      content => template('tkh-gitcrypt/gitcrypt_bash.cmd.erb'),
      source_permissions => ignore,
      ensure => present,
    }
  } else {
  } 
  File['gitcrypt_parent_dir']->
  Exec['git_clone_gitcrypt']->File['gitcrypt_cmd']->File['gitcrypt_bash_cmd']
}
