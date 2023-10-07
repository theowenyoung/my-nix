{ pkgs, config, ... }:

{
  # Initializes Emacs with org-mode so we can tangle the main config
  # ".emacs.d/init.el" = {
  #   text = builtins.readFile ../shared/config/emacs/init.el;
  # };
  ".zsh/custom" = {
    source = ./config/zsh;
  };
  # ".config/nvim/lua" = {
  #   source = ./config/nvim/NvChad/lua;
  # };
  #  ".config/nvim/snippets" = {
  #   source = ./config/nvim/NvChad/snippets;
  # };
}
