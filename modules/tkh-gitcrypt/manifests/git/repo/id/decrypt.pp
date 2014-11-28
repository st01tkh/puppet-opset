define tkh-gitcrypt::git::repo::id::decrypt($repo_id = '') {
  if $repo_id == '' {
      fail("git repo ID isn't set")
  }
  $data = hiera('gitcrypt')
  $local_path =  $osfamily ? {
    /windows/ => $data[repo][id][$repo_id][local_path][windows],
    default => $data[repo][id][$repo_id][local_path][unknown],
  }
  tkh-gitcrypt::git::repo::decrypt {'decrypt_git_repo':
    local_path => $local_path,
    user_name => $data[repo][id][$repo_id][user_name],
    user_email => $data[repo][id][$repo_id][user_email],
    gitcrypt_salt => $data[repo][id][$repo_id][gitcrypt_salt],
    gitcrypt_pass => $data[repo][id][$repo_id][gitcrypt_pass],
  }
}
