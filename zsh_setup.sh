#!/bin/env bash

PACKAGES=("zsh" "git" "curl")

required_packages_error () {
    echo "Required packages:"
    for PACKAGE in "${PACKAGES[@]}"; do
        echo -e "- $PACKAGE"
    done

    echo "Please install these before running this script."
    exit 1
}

check_installed () {
    which ${1}

    if [ $? -ne 0 ]; then
        echo "${1} not installed."
        required_packages_error
    fi
}

for PACKAGE in "${PACKAGES[@]}"; do
    check_installed "$PACKAGE"
done

# ohmyzsh
sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)" "" --unattended

# autosuggestions
git clone --depth=1 https://github.com/zsh-users/zsh-autosuggestions ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-autosuggestions

# syntax-highlighting
git clone --depth=1 https://github.com/zsh-users/zsh-syntax-highlighting ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-syntax-highlighting

# p10k
git clone --depth=1 https://github.com/romkatv/powerlevel10k.git ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/themes/powerlevel10k

# .zshrc
curl -fsSL https://raw.githubusercontent.com/gsistelos/dotfiles/main/.zshrc -o ~/.zshrc
