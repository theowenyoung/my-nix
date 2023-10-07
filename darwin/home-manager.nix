{ user, name, system,  email,config, pkgs, lib, home-manager,nixpkgs-webextfixed, ... }:

let
  sharedFiles = import ../shared/files.nix { inherit config pkgs; };
  additionalFiles = import ./files.nix { inherit config pkgs; };
in
{
  imports = [
    ./dock
  ];

  # It me
  users.users.${user} = {
    name = "${user}";
    home = "/Users/${user}";
    isHidden = false;
    shell = pkgs.zsh;
  };

  homebrew.enable = true;
  homebrew.casks = pkgs.callPackage ./casks.nix { };

  # These app IDs are from using the mas CLI app
  # mas = mac app store
  # https://github.com/mas-cli/mas
  #
  # $ nix shell nixpkgs#mas
  # $ mas search <app name>
  #
  homebrew.masApps = {
    "ipic" = 1101244278;
    "s3-files" = 6447647340;
  };

  # Enable home-manager
  home-manager = {
    useGlobalPkgs = true;
    users.${user} = { pkgs, config, lib, ... }: {
      home.enableNixpkgsReleaseCheck = false;
      home.packages = [nixpkgs-webextfixed.legacyPackages.${system}.nodePackages."web-ext"] ++ pkgs.callPackage ./packages.nix { };
      home.file = lib.mkMerge [
        sharedFiles
        additionalFiles
      ];

      home.stateVersion = "21.11";
      programs = { } // import ../shared/home-manager.nix { inherit config pkgs lib name email user; };

      # Marked broken Oct 20, 2022 check later to remove this
      # https://github.com/nix-community/home-manager/issues/3344
      manual.manpages.enable = false;
    };
  };

  # Fully declarative dock using the latest from Nix Store
  local.dock.enable = true;
  local.dock.entries = [
    { path = "/System/Applications/Messages.app/"; }
    { path = "/System/Applications/Facetime.app/"; }
    { path = "/System/Applications/Home.app/"; }
  ];
}
