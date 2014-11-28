define tkh-gitcrypt::git::repo::clone(
  $repo_url = '',
  $local_path = ''
) {
  if $repo_url == '' {
    fail("git repo URL isn't set")
  }
  if $local_path == '' {
    fail("local path isn't set")
  }
  $dir = dirname($local_path)
  file {'dir_for_clone':
    path => dirname($local_path),
    ensure => directory,
  }
  $bak_path = bak_mv($local_path)
  exec {'clone_repo':
    path => [
      "C:\\Windows",
      "C:\\Windows\\System32",
      "C:\\Program Files (x86)\\Git\\cmd",
      "C:\\Program Files (x86)\\Git\\bin",
    ],
    cwd => $dir,
    command => "git clone $repo_url $local_path",
    require => File['dir_for_clone'],
  } 
}
