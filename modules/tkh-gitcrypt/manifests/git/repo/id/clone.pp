define tkh-gitcrypt::git::repo::id::clone($repo_id = '') {
  if $repo_id == '' {
      fail("git repo ID isn't set")
  }
  $data = hiera('gitcrypt')
  $local_path =  $osfamily ? {
    /windows/ => $data[repo][id][$repo_id][local_path][windows],
    default => $data[repo][id][$repo_id][local_path][unknown],
  }
  tkh-gitcrypt::git::repo::clone{'clone_git_repo':
    repo_url => $data[repo][id][$repo_id][url],
    local_path => $local_path,
  }
}
