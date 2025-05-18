# ALIASES -------------------
alias ls="exa --icons"
alias ll="exa -lh --icons"
alias la="exa -lah --icons"
alias lt="exa -tree --icons"

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

alias d="docker"
alias dc="docker compose"
alias dl='sudo docker ps -l -q'
alias dps="sudo docker ps"
alias di='sudo docker images'

if command -v bat &>/dev/null; then
    alias cat="bat"
fi