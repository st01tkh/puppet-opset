define tkh-gitcrypt::git::repo::id::cnd($repo_id = '') {
  if $repo_id == '' {
      fail("git repo ID isn't set")
  }
  $data = hiera('gitcrypt')
  $local_path =  $osfamily ? {
    /windows/ => $data[repo][id][$repo_id][local_path][windows],
    default => $data[repo][id][$repo_id][local_path][unknown],
  }
  tkh-gitcrypt::git::repo::cnd{'cnd_git_repo':
    repo_url => $data[repo][id][$repo_id][url],
    local_path => $local_path,
    gitcrypt_cipher => $data[repo][id][$repo_id][gitcrypt_cipher],
    filter_encrypt_smudge => $data[repo][id][$repo_id][filter_encrypt_smudge],
    filter_encrypt_clean => $data[repo][id][$repo_id][filter_encrypt_clean],
    diff_encrypt_textconv => $data[repo][id][$repo_id][diff_encrytp_textconv],
    user_name => $data[repo][id][$repo_id][user_name], 
    user_email => $data[repo][id][$repo_id][user_email],
    gitcrypt_salt => $data[repo][id][$repo_id][gitcrypt_salt],
    gitcrypt_pass => $data[repo][id][$repo_id][gitcrypt_pass],
    core_autocrlf => $data[repo][id][$repo_id][core_autocrlf],
  }
} 
