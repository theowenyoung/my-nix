{ user, name, email, config, pkgs, lib, ... }:

{


  # Shared shell configuration
  zsh = {
    enable = true;
     initExtra = ''
  source ~/.zsh/custom/zshrc.zsh
  '';
  };

  neovim = {
    enable = true;
    defaultEditor = true;
     viAlias = true;
  vimAlias = true;
  extraConfig = ''
      luafile ~/.config/nvim/NvChad/lua/init.lua
    '';

  };

  git = {
    enable = true;
    ignores = [ "*.swp" ".DS_Store" ];
    userName = name;
    userEmail = email;
    lfs = {
      enable = true;
    };
    extraConfig = {
      init.defaultBranch = "main";
      core = {
        editor = "vi";
        autocrlf = "input";
      };
      pull.rebase = true;
      rebase.autoStash = true;
    };
  };


  ssh = {
    enable = true;

    extraConfig = lib.mkMerge [
      ''
        Host github.com
          Hostname github.com
          IdentitiesOnly yes
      ''
      (lib.mkIf pkgs.stdenv.hostPlatform.isLinux
        ''
          IdentityFile /home/${user}/.ssh/id_ed25519
        '')
      (lib.mkIf pkgs.stdenv.hostPlatform.isDarwin
        ''
          IdentityFile /Users/${user}/.ssh/id_ed25519
        '')
    ];
  };

  tmux = {
    enable = true;
    extraConfig =  builtins.readFile ./config/dot_tmux.conf;
  };
}
