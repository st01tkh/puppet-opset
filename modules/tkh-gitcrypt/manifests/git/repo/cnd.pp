# clone and decrypt: cnd
define tkh-gitcrypt::git::repo::cnd(
  $repo_url = '',
  $local_path = '',
  $bin_path = '',
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
  tkh-gitcrypt::git::repo::clone{'clone_git_repo':
    repo_url => $repo_url,
    local_path => $local_path,
  }
  tkh-gitcrypt::git::repo::decrypt{'decrypt_git_repo':
    local_path => $local_path,
    bin_path => $bin_path,
    user_name => $user_name,
    user_email => $user_email,
	  gitcrypt_salt => $gitcrypt_salt,
	  gitcrypt_pass => $gitcrypt_pass,
    filter_encrypt_smudge => $filter_encrypt_smudge,
    filter_encrypt_clean => $filter_encrypt_clean,
    diff_encrypt_textconv => $diff_encrypt_textconv,
    gitcrypt_cipher => $gitcrypt_cipher,
    core_autocrlf => $core_autocrlf,
  }
  Tkh-gitcrypt::Git::Repo::Clone['clone_git_repo']->
  Tkh-gitcrypt::Git::Repo::Decrypt['decrypt_git_repo']
} 
