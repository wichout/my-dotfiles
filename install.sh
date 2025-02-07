#!/bin/bash

# Update and Upgrade packages
sudo apt -y update && sudo apt -y upgrade;

# Check and install some needed programs
for program in stow curl fuse fzf bat keychain; do
  if ! command -v $program &> /dev/null; then
    sudo apt -y install $program
  fi
done

# Symlink the dotfiles
stow ~/dotfiles/nvim
stow ~/dotfiles/tmux
stow ~/dotfiles/zsh

# Install zsh and oh-my-zsh
if ! command -v zsh &> /dev/null; then
  sudo apt -y install zsh
  sudo chsh -s $(which zsh)
  sudo sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"
  git clone https://github.com/zsh-users/zsh-autosuggestions ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-autosuggestions
  git clone https://github.com/zsh-users/zsh-syntax-highlighting.git ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-syntax-highlighting
fi

# Install neovim
if ! command -v nvim &> /dev/null; then
  curl -L -O https://github.com/neovim/neovim/releases/download/v0.10.1/nvim.appimage
  sudo chmod u+x nvim.appimage
  sudo mv nvim.appimage /usr/bin/nvim
fi

# Install tmux
if ! command -v tmux &> /dev/null; then
  sudo apt -y install tmux
  git clone https://github.com/tmux-plugins/tpm ~/.tmux/plugins/tpm
  tmux source ~/.tmux.conf

  # Plugins
  mkdir -p ~/.config/tmux/plugins/catppuccin
  git clone https://github.com/catppuccin/tmux.git ~/.config/tmux/plugins/catppuccin/tmux
fi

# Install lazygit
if ! command -v lazygit &> /dev/null; then
  LAZYGIT_VERSION=$(curl -s "https://api.github.com/repos/jesseduffield/lazygit/releases/latest" | grep -Po '"tag_name": "v\K[^"]*')
  curl -Lo lazygit.tar.gz "https://github.com/jesseduffield/lazygit/releases/latest/download/lazygit_${LAZYGIT_VERSION}_Linux_x86_64.tar.gz"
  tar xf lazygit.tar.gz lazygit
  sudo install lazygit /usr/local/bin
fi

# Sourcing scripts
for files in shell/*
do
  fullpath=$(realpath $file)
  echo "source $fullpath" >> ~/.zshrc
done
