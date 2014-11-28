define tkh-gitcrypt::git::repo::config::attrs::update(
  $pattern = '*',
  $local_path = '',
) {
  if $local_path == '' {
    fail("local git repo path isn't set")
  }
  file {'update_config_attributes':
    path => "$local_path/.git/info/attributes",
    content => template("tkh-gitcrypt/attributes.erb"),
  }
}
