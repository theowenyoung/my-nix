{ user, config, pkgs, agenix, secrets, ... }:

{

  age.identityPaths = [
    "/Users/${user}/.ssh/id_ed25519"
  ];



}
