#!/bin/bash

set -e

echo "Starting dotfiles configuration"

sudo apt -y update && sudo apt -y upgrade
sudo apt -y install build-essential

# Creating nedeed directories
mkdir -p $HOME/.config $HOME/.local/bin $HOME/.local/env

# Variables
email="luisadolfotaddeigonzalezs@gmail.com"

# Installing some nedeed programs
for program in stow curl fzf bat keychain bat eza xclip ripgrep unzip python3-venv; do
  if ! command -v $program &>/dev/null; then
    echo "-> Installing $program ..."
    sudo apt -y install $program
    clear
  fi
done

# Stow the dotfiles
stow tmux
stow zsh

cd $HOME

# Symlinking batcat to bat if is needed
if [ -x "/usr/bin/batcat" ] && [ ! -e "$HOME/.local/bin/bat" ]; then
  ln -s /usr/bin/batcat "$HOME/.local/bin/bat"
fi

# Installing Git
if ! command -v git &>/dev/null; then
  echo '-> Installing Git ...'
  sudo apt -y install git-all
  clear
fi

git config --global user.name "wichout"
git config --global user.email $email

# Install neovim
if ! command -v nvim &>/dev/null; then
  echo '-> Installing Neovim ...'
  curl -LO https://github.com/neovim/neovim/releases/download/v0.11.1/nvim-linux-x86_64.tar.gz
  tar xzvf nvim-linux-x86_64.tar.gz
  cp -R nvim-linux-x86_64/* $HOME/.local/
  rm -rf nvim-linux-x86_64.tar.gz nvim-linux-x86_64
  git clone https://github.com/wichout/neovim-dotfiles.git $HOME/my-dotfiles/nvim/.config/nvim
  cd my-dotfiles && stow nvim
  cd $HOME
  clear
fi

# Installing tmux
if ! command -v tmux &>/dev/null; then
  echo '-> Installing Tmux ...'
  sudo apt -y install tmux
  git clone https://github.com/tmux-plugins/tpm $HOME/.tmux/plugins/tpm
  tmux source $HOME/.tmux.conf
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
  fnm install --lts
  clear
fi

# Install Btop
if ! command -v fnm &>/dev/null; then
  echo '--> Installing Btop ...'
  sudo apt install coreutils gcc-11 g++-11 lowdown
  git clone https://github.com/aristocratos/btop.git
  cd btop
  make
  cd $HOME
  clear
fi

# Install zsh
if ! command -v zsh &>/dev/null; then
  echo 'Installing Zsh...'
  sudo apt -y install zsh
  if [ $SHELL != $(which zsh) ]; then
    chsh -s $(which zsh)
  fi
  sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)" "" --unattended
  sudo rm $HOME/.zshrc
  sudo mv $HOME/.zshrc.pre-oh-my-zsh $HOME/.zshrc
  git clone https://github.com/zsh-users/zsh-syntax-highlighting.git ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-syntax-highlighting
  git clone https://github.com/zsh-users/zsh-autosuggestions ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-autosuggestions
  clear
fi

echo "-> Adding sourcing files to .zshrc..."
for file in $HOME/my-dotfiles/shell/*; do
  fullpath=$(realpath "$file")
  if ! grep -qxF "source $fullpath" "$HOME/.zshrc"; then
    echo -e "\nsource $fullpath" >>"$HOME/.zshrc"
  fi
done

# Creating ssh keys
echo "-> Creating SSH Keys..."
ssh-keygen -t ed25519 -C $email
clear

exec zsh

