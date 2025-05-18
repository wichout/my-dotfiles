#!/bin/bash

set -e

echo "Starting dotfiles configuration"

sudo apt -y update && sudo apt -y upgrade

# Creating nedeed directories
mkdir $HOME/.config $HOME/.local/bin $HOME/.local/env

# Installing some nedeed programs
for program in stow curl fzf bat keychain bat exa xclip ripgrep; do
  if ! command -v $program &>/dev/null; then
    echo "-> Installing $program ..."

    sudo apt -y install $program
    clear
  fi
done

# Symlink the dotfiles
stow tmux
stow zsh

if ! command -v bat &>/dev/null; then
  ln -s /usr/bin/batcat ~/.local/bin/bat
fi

# Installing Git
if ! command -v git &>/dev/null; then
  echo '-> Installing Git ...'
  sudo apt -y install git-all
  clear
fi

git config --global user.name "wichout"
git config --global user.email "luisadolfotaddeigonzalezs@gmail.com"

# Install neovim
if ! command -v nvim &>/dev/null; then
  echo '-> Installing Neovim ...'
  curl -O https://github.com/neovim/neovim/releases/download/v0.11.1/nvim-linux-x86_64.tar.gz
  tar xzvf nvim-linux-x86_64.tar.gz
  mv nvim-linux-x86_64/bin/nvim $HOME/.local/bin/
  rm -rf nvim-linux-x86_64.tar.gz nvim-linux-x86_64
  git clone https://github.com/wichout/neovim-dotfiles.git $HOME/dotfiles/nvim/.config/nvim
  stow nvim
  clear
fi

# Installing tmux
if ! command -v tmux &>/dev/null; then
  echo '-> Installing Tmux ...'
  sudo apt -y install tmux
  git clone https://github.com/tmux-plugins/tpm $HOME/.tmux/plugins/tpm
  tmux source $HOME/.tmux.conf
  mkdir -p $HOME/.config/tmux/plugins/catppuccin
  git clone https://github.com/catppuccin/tmux.git $HOME/.config/tmux/plugins/catppuccin/tmux
  clear
fi

# Installing fd
if ! command -v fdfind &>/dev/null; then
  echo "-> Installing fd ..."
  sudo apt install -y fd-find
  ln -s $(which fdfind) $HOME/.local/bin/fd
  clear
fi

# Installing uv
if ! command -v uv &>/dev/null; then
  echo '-> Installing UV ...'
  curl -LsSf https://astral.sh/uv/install.sh | sh
  clear
fi

# Install lazygit
if ! command -v lazygit &>/dev/null; then
  echo '-> Installing LazyGit ...'
  LAZYGIT_VERSION=$(curl -s "https://api.github.com/repos/jesseduffield/lazygit/releases/latest" | grep -Po '"tag_name": "v\K[^"]*')
  curl -Lo lazygit.tar.gz "https://github.com/jesseduffield/lazygit/releases/latest/download/lazygit_${LAZYGIT_VERSION}_Linux_x86_64.tar.gz"
  tar xf lazygit.tar.gz lazygit
  sudo install lazygit /usr/local/bin
  rm lazygit lazygit.tar.gz
  clear
fi

# Install Fast Node Manager
if ! command -v fnm &>/dev/null; then
  echo '--> Installing Fast Node Manager ...'
  curl -fsSL https://fnm.vercel.app/install | bash
  export PATH="$HOME/.fnm:$PATH"
  eval "$(fnm env --use-on-cd --shell zsh)"
  clear
fi

# Install zsh and oh-my-zsh
if ! command -v zsh &>/dev/null; then
  echo 'Installing Oh My Zsh and Sourcing files...'
  sudo apt -y install zsh
  if [ $SHELL != $(which zsh) ]; then
    chsh -s $(which zsh)
  fi
  # Sourcing scripts
  for file in shell/*; do
    fullpath=$(realpath "$file")
    if ! grep -qxF "source $fullpath" "$HOME/.zshrc"; then
      echo "source $fullpath" >> "$HOME/.zshrc"
    fi
  done
  sudo sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"
  git clone https://github.com/zsh-users/zsh-autosuggestions ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-autosuggestions
  git clone https://github.com/zsh-users/zsh-syntax-highlighting.git ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-syntax-highlighting
  rm $HOME/.zshrc
  mv $HOME/.zshrc.pre-oh-my-zsh ~/.zshrc
  clear
fi
