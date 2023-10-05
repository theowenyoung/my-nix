{ config, pkgs, agenix, secrets, ... }:

let user = "green"; in
{

  age.identityPaths = [
    "/Users/${user}/.ssh/id_ed25519"
  ];



}
