define tkh-gitcrypt::git::repo::decrypt(
  $bin_path = '',
  $local_path = '',
  $gitcrypt_cipher = 'aes-256-ecb',
  $filter_encrypt_smudge = "gitcrypt smudge",
  $filter_encrypt_clean = "gitcrypt clean",
  $diff_encrypt_textconv = "gitcrypt diff",
  $user_name = '',
  $user_email = '',
  $gitcrypt_salt = '',
  $gitcrypt_pass = '',
  $core_autocrlf = '',
) {
  if $local_path == '' {
    fail("local git repo path isn't set")
  }

  if $gitcrypt_salt == '' {
    fail("gitcrypt salt isn't set")
  }

  if $gitcrypt_pass== '' {
    fail("gitcrypt pass isn't set")
  }
  
  tkh-gitcrypt::git::repo::config::update{'update_git_repo_config':
    local_path => $local_path,
    user_name => $user_name,
    user_email => $user_email,
    gitcrypt_salt => $gitcrypt_salt,
    gitcrypt_pass => $gitcrypt_pass,
    gitcrypt_cipher => $gitcrypt_cipher,
    filter_encrypt_smudge => $filter_encrypt_smudge,
    filter_encrypt_clean => $filter_encrypt_clean,
    diff_encrypt_textconv => $diff_encrypt_textconv,
    core_autocrlf => $core_autocrlf,
    bin_path => $bin_path,
  }
  tkh-gitcrypt::git::repo::config::attrs::update{'update_git_repo_attrs':
    local_path => $local_path,
  }
  if $bin_path == '' {
    $_bin_path = $osfamily ? {
      windows => "C:\\Program Files (x86)\\Git\\bin",
      default => '/usr/bin',
    }
  } else {
    $_bin_path = $bin_path
  }

  exec {'decrypt_by_reset_hard_head': path => $_bin_path, cwd => $local_path,
    command => "git reset --hard HEAD"
  } 
  Tkh-gitcrypt::Git::Repo::Config::Update['update_git_repo_config']->
  Tkh-gitcrypt::Git::Repo::Config::Attrs::Update['update_git_repo_attrs']->
  Exec['decrypt_by_reset_hard_head']
}
