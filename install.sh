#!/bin/bash

# Update and Upgrade packages
sudo apt -y update && sudo apt -y upgrade;

mkdir $HOME/.config/

# Check and install some needed programs
for program in stow curl fuse fzf bat keychain; do
  if ! command -v $program &> /dev/null; then
    sudo apt -y install $program
  fi
done

# Symlink the dotfiles
stow $HOME/dotfiles/tmux
stow $HOME/dotfiles/zsh


# Install neovim
if ! command -v nvim &> /dev/null; then
  echo '---> Installing Neovim...'
  
  curl -L -O https://github.com/neovim/neovim/releases/download/v0.10.4/nvim.appimage
  sudo chmod u+x nvim.appimage
  sudo mv nvim.appimage /usr/bin/nvim

  git clone https://github.com/wichout/neovim-dotfiles.git $HOME/dotfiles/nvim
  stow $HOME/dotfiles/nvim
  
  clear
fi

# Install tmux
if ! command -v tmux &> /dev/null; then
  echo '---> Installing Tmux'
  
  sudo apt -y install tmux
  git clone https://github.com/tmux-plugins/tpm ~/.tmux/plugins/tpm
  tmux source ~/.tmux.conf

  # Plugins
  mkdir -p ~/.config/tmux/plugins/catppuccin
  git clone https://github.com/catppuccin/tmux.git ~/.config/tmux/plugins/catppuccin/tmux

  clear
fi

# Install uv
if ! command -v uv &> /dev/null; then
  echo '---> Installing uv'

  curl -LsSf https://astral.sh/uv/install.sh | sh

  clear
fi

# Install Git
if ! command -v git &> /dev/null; then
  echo '---> Installing Git'
  
  sudo apt -y install git-all
  git config --global user.name "wichout"
  git config --global user.email "luisadolfotaddeigonzalezs@gmail.com"
  
  clear
fi

# Install lazygit
if ! command -v lazygit &> /dev/null; then
  echo '---> Installing LazyGit'

  LAZYGIT_VERSION=$(curl -s "https://api.github.com/repos/jesseduffield/lazygit/releases/latest" | grep -Po '"tag_name": "v\K[^"]*')
  curl -Lo lazygit.tar.gz "https://github.com/jesseduffield/lazygit/releases/latest/download/lazygit_${LAZYGIT_VERSION}_Linux_x86_64.tar.gz"
  tar xf lazygit.tar.gz lazygit
  sudo install lazygit /usr/local/bin

  clear
fi

# Install Fast Node Manager
if ! command -v fnm &> /dev/null; then
  echo '---> Installing Fast Node Manager'
  curl -fsSL https://fnm.vercel.app/install | bash
  eval "$(fnm env --use-on-cd --shell zsh)"
  clear
fi


# Install zsh and oh-my-zsh
if ! command -v zsh &> /dev/null; then
  echo 'Installing Oh My Zsh and Sourcing files...'

  sudo apt -y install zsh
  sudo chsh -s $(which zsh)

  # Sourcing scripts
  for files in shell/*
  do
    fullpath=$(realpath $file)
    echo "source $fullpath" >> ~/.zshrc
  done
  
  sudo sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"
  git clone https://github.com/zsh-users/zsh-autosuggestions ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-autosuggestions
  git clone https://github.com/zsh-users/zsh-syntax-highlighting.git ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-syntax-highlighting

  clear
fi

