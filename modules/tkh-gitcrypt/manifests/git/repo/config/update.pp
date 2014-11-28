define tkh-gitcrypt::git::repo::config::update(
  $gitcrypt_cipher = 'aes-256-ecb',
  $filter_encrypt_smudge = "gitcrypt smudge",
  $filter_encrypt_clean = "gitcrypt clean",
  $diff_encrypt_textconv = "gitcrypt diff",
  $bin_path = '',
  $local_path = '',
  $user_name = '',
  $user_email = '',
  $gitcrypt_salt = '',
  $gitcrypt_pass = '',
  $core_autocrlf = '',
) {
  if $local_path == '' {
    fail("local git repo path isn't set")
  }
  if $bin_path == '' {
    $_bin_path = $osfamily ? {
      windows => "C:\\Program Files (x86)\\Git\\bin",
      default => '/usr/bin',
    }
  } else {
    $_bin_path = $bin_path
  }

  exec {'set_filter_encrypt_smudge': path => $_bin_path, cwd => $local_path,
    command => "git config filter.encrypt.smudge \"$filter_encrypt_smudge\"",
  } 

  exec {'set_filter_encrypt_clean': path => $_bin_path, cwd => $local_path,
    command => "git config filter.encrypt.clean \"$filter_encrypt_clean\"",
  } 
  
  exec {'set_diff_encrypt_textconv': path => $_bin_path, cwd => $local_path,
    command => "git config diff.encrypt.textconv \"$diff_encrypt_textconv\"",
  } 

  exec {'set_gitcrypt_cipher': path => $_bin_path, cwd => $local_path,
    command => "git config gitcrypt.cipher $gitcrypt_cipher",
  } 

  exec {'set_gitcrypt_salt': path => $_bin_path, cwd => $local_path,
    command => "git config gitcrypt.salt $gitcrypt_salt",
  } 

  exec {'set_gitcrypt_pass': path => $_bin_path, cwd => $local_path,
    command => "git config gitcrypt.pass $gitcrypt_pass",
  } 

  if $user_email != '' {
    exec {'set_user_email': path => $_bin_path, cwd => $local_path,
      command => "git config user.email $user_email",
    } 
  }

  if $user_name != '' {
    exec {'set_user_name': path => $_bin_path, cwd => $local_path,
      command => "git config user.name $user_name",
    } 
  }

  if $core_autocrlf !=  '' {
    $core_autocrlf = $osfamily ? {
      windows => "false",
      default => "false",
    }
    exec {'set_core_autocrlf': path => $_bin_path, cwd => $local_path,
      command => "git config core.autocrlf $core_autocrlf",
    } 
  }
}
