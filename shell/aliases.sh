# ALIASES -------------------
alias ls="eza --icons"
alias ll="eza -lh --icons"
alias la="eza -lah --icons"
alias llt="eza -tree --icons"

alias cls="clear"
alias mv='mv -i'
alias cp='cp -i'
alias ln='ln -i'
alias rm='rm -l --preserve-root'
alias ports='sudo netstat -tulanp'

alias nv="nvim"
alias vim='nvim'
alias vi='nvim'

alias g='git'
alias gs="git status"
alias gl='git log'
alias ga="git add"
alias gal='git add .'
alias gpo='git push -u origin'
alias gp='git pull'
alias gc='git commit -m'

alias d="docker"
alias dc="docker compose"
alias dl='sudo docker ps -l -q'
alias dps="sudo docker ps"
alias di='sudo docker images'

if command -v bat &>/dev/null; then
    alias cat="bat"
fi