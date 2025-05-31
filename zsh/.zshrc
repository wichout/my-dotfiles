# If you come from bash you might have to change your $PATH.
# export PATH=$HOME/bin:$HOME/.local/bin:/usr/local/bin:$PATH

# Path to your oh-my-zsh installation.
export ZSH="$HOME/.oh-my-zsh"

# Setting PATH
for dir in "$HOME/bin" "$HOME/.local/bin"; do
	[ -d "$dir" ] && PATH="$dir:$PATH"
done

# Loading Env variables if exists
[ -f "$HOME/.local/bin/env" ] && . "$HOME/.local/bin/env"

# See https://github.com/ohmyzsh/ohmyzsh/wiki/Themes
ZSH_THEME="robbyrussell"

# Uncomment one of the following lines to change the auto-update behavior
zstyle ':omz:update' mode reminder # just remind me to update when it's time

# Uncomment the following line to change how often to auto-update (in days).
zstyle ':omz:update' frequency 13

# Uncomment the following line if pasting URLs and other text is messed up.
# DISABLE_MAGIC_FUNCTIONS="true"

# You can set one of the optional three formats:
# "mm/dd/yyyy"|"dd.mm.yyyy"|"yyyy-mm-dd"
HIST_STAMPS="dd.mm.yyyy"

plugins=(
	git
	zsh-autosuggestions
	zsh-syntax-highlighting
)

source $ZSH/oh-my-zsh.sh

# You may need to manually set your language environment
export LANG=en_US.UTF-8

# Preferred editor for local and remote sessions
if [[ -n $SSH_CONNECTION ]]; then
	export EDITOR='vim'
else
	export EDITOR='mvim'
fi

# Add github ssh keys to the ssh-agent
# eval $(keychain --quiet --eval --agents ssh id_ed25519)

# Support for uv
eval "$(uv generate-shell-completion zsh)"
eval "$(uvx --generate-shell-completion zsh)"

# Adding PNPM
export PNPM_HOME="/home/wichout/.local/share/pnpm"
case ":$PATH:" in
*":$PNPM_HOME:"*) ;;
*) export PATH="$PNPM_HOME:$PATH" ;;
esac

[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh

# fnm (Fast Node.js Manager)
FNM_PATH="/home/wichout/.local/share/fnm"
if [ -d "$FNM_PATH" ]; then
	export PATH="/home/wichout/.local/share/fnm:$PATH"
	eval "$(fnm env)"
fi

eval "$(fnm env --use-on-cd --shell zsh)"