{ user, agenix, config, pkgs, ... }:

{

  imports = [
    # ./secrets.nix
    ./home-manager.nix
    # ../shared 
    # ../shared/cachix
    # agenix.darwinModules.default
  ];

  # Auto upgrade nix package and the daemon service.
  services.nix-daemon.enable = true;

  # Setup user, packages, programs
  nix = {
    # this is for which nix version to be used.
    package = pkgs.nixUnstable;
    settings.trusted-users = [ "@admin" "${user}" ];

    gc = {
      user = "root";
      automatic = true;
      interval = { Weekday = 0; Hour = 2; Minute = 0; };
      options = "--delete-older-than 7d";
    };

    # Turn this on to make command line easier
    extraOptions = ''
      experimental-features = nix-command flakes
    '';

    # substituters = [
    #   # Replace official cache with a mirror located in China
    #   #
    #   # Feel free to remove this line if you are not in China
    #   "https://mirrors.ustc.edu.cn/nix-channels/store"
    #   "https://cache.nixos.org"
    # ];
  };

  # Turn off NIX_PATH warnings now that we're using flakes
  system.checks.verifyNixPath = false;

  # Load configuration that is shared across systems
  # environment.systemPackages = with pkgs; [
  #   agenix.packages."${pkgs.system}".default
  # ] ++ (import ../shared/packages.nix { inherit pkgs; });

  # Enable fonts management
  fonts.fontDir.enable = true;

  system = {
    stateVersion = 4;

    defaults = {
      LaunchServices = {
        # https://macos-defaults.com/misc/lsquarantine.html
        # Turn off the “Application Downloaded from Internet” quarantine warning.
        LSQuarantine = false;
      };

      NSGlobalDomain = {
        AppleShowAllExtensions = true;
        ApplePressAndHoldEnabled = false;

        # 120, 90, 60, 30, 12, 6, 2
        KeyRepeat = 2;

        # 120, 94, 68, 35, 25, 15
        InitialKeyRepeat = 15;

        "com.apple.mouse.tapBehavior" = 1;
 
      };

      dock = {
        autohide = true;
        show-recents = true;
        launchanim = true;
        orientation = "bottom";
        tilesize = 48;
      };

      finder = {
        _FXShowPosixPathInTitle = false;
      };

      trackpad = {
        Clicking = true;
        TrackpadThreeFingerDrag = true;
      };
    };
  };
}