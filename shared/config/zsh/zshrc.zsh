# My zsh includes

# source global first

source ~/.zsh/custom/global.zsh

for file in ~/.zsh/custom/includes/*; do
  source "$file"
done


# Tab completion
autoload -Uz compinit && compinit -u

# load general config
source ~/.zsh/custom/general_config.zsh


# pnpm
export PNPM_HOME="/home/green/.local/share/pnpm"
export PATH="$PNPM_HOME:$PATH"
# pnpm end
# bun completions
[ -s "/Users/green/.bun/_bun" ] && source "/Users/green/.bun/_bun"

# bun
export BUN_INSTALL="$HOME/.bun"
export PATH="$BUN_INSTALL/bin:$PATH"

# Add RVM to PATH for scripting. Make sure this is the last PATH variable change.
export PATH="$PATH:$HOME/.rvm/bin"
