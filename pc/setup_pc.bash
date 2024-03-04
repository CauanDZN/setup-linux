#!/bin/bash

# Função para atualização do sistema e instalação de pacotes básicos
install_basic_packages() {
    sudo apt update -y
    sudo apt upgrade -y
    sudo apt install -y curl git python3 python3-pip nano vim ffmpeg
}

# Função para instalação do Homebrew
install_homebrew() {
    /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
}

# Função para instalação de ferramentas adicionais via Snap
install_snap_tools() {
    sudo snap install code --classic
}

# Função para instalação de softwares adicionais
install_additional_software() {
    sudo add-apt-repository -y ppa:obsproject/obs-studio
    sudo apt update
    sudo apt install -y obs-studio
    sudo snap install vlc discord spotify
}

# Função para instalação do Docker
install_docker() {
    sudo apt install -y apt-transport-https ca-certificates curl gnupg lsb-release
    sudo mkdir -p /etc/apt/keyrings
    sudo curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo gpg --dearmor -o /etc/apt/keyrings/docker-archive-keyring.gpg
    echo "deb [arch=$(dpkg --print-architecture) signed-by=/etc/apt/keyrings/docker-archive-keyring.gpg] https://download.docker.com/linux/ubuntu $(lsb_release -cs) stable" | sudo tee /etc/apt/sources.list.d/docker.list > /dev/null
    sudo apt update
    sudo apt install -y docker-ce docker-ce-cli containerd.io docker-buildx-plugin docker-compose-plugin
}

# Função para instalação do VirtualBox
install_virtualbox() {
    sudo apt install -y virtualbox
}

# Função para instalação do Vagrant
install_vagrant() {
    wget -O- https://apt.releases.hashicorp.com/gpg | sudo gpg --dearmor | sudo tee /usr/share/keyrings/hashicorp-archive-keyring.gpg
    echo "deb [signed-by=/usr/share/keyrings/hashicorp-archive-keyring.gpg] https://apt.releases.hashicorp.com $(lsb_release -cs) main" | sudo tee /etc/apt/sources.list.d/hashicorp.list
    sudo apt update
    sudo apt install -y vagrant
}

# Função para instalação do Node.js LTS
install_nodejs() {
    curl -fsSL https://deb.nodesource.com/setup_lts.x | sudo -E bash -
    sudo apt install -y nodejs
}

# Função para instalação do Yarn
install_yarn() {
    sudo npm install -g yarn@latest
}

# Função para atualização do NPM
update_npm() {
    sudo npm install -g npm@latest
}

# Função para instalar a fonte Inter
install_inter_font() {
    wget -O /tmp/Inter-4.0.zip https://github.com/rsms/inter/releases/download/v4.0/Inter-4.0.zip
    sudo unzip -o /tmp/Inter-4.0.zip -d /usr/share/fonts/inter
    rm /tmp/Inter-4.0.zip
    sudo fc-cache -f -v
    echo "Fonte Inter instalada com sucesso."
}

# Função para instalar a fonte JetBrains Mono
install_jetbrains_mono_font() {
    wget -O /tmp/JetBrainsMono-2.304.zip https://github.com/JetBrains/JetBrainsMono/releases/download/v2.304/JetBrainsMono-2.304.zip
    sudo unzip -o /tmp/JetBrainsMono-2.304.zip -d /usr/share/fonts/jetbrains-mono
    rm /tmp/JetBrainsMono-2.304.zip
    sudo fc-cache -f -v
    echo "Fonte JetBrains Mono instalada com sucesso."
}

# Função para instalar o Oh My Zsh e configurar o tema Powerlevel9k
install_oh_my_zsh() {
    sudo apt install -y zsh
    sudo usermod -s /usr/bin/zsh $(whoami)
    sudo apt install -y zsh-theme-powerlevel9k
    echo "source /usr/share/powerlevel9k/powerlevel9k.zsh-theme" >> ~/.zshrc
    sudo apt install -y zsh-syntax-highlighting
    echo "source /usr/share/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh" >> ~/.zshrc
    for user in $(ls /home); do
        sudo usermod -s /usr/bin/zsh $user
        sudo chsh -s /usr/bin/zsh $user
        sudo cp ~/.zshrc /home/$user/
        sudo chown $user:$user /home/$user/.zshrc
        sudo -u $user bash -c 'sudo apt install -y zsh-theme-powerlevel9k'
        sudo -u $user bash -c 'echo "source /usr/share/powerlevel9k/powerlevel9k.zsh-theme" >> ~/.zshrc'
        sudo -u $user bash -c 'sudo apt install -y zsh-syntax-highlighting'
        sudo -u $user bash -c 'echo "source /usr/share/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh" >> ~/.zshrc'
    done
    /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"    
}

# Execução das funções
install_basic_packages
install_homebrew
install_snap_tools
install_additional_software
install_docker
install_virtualbox
install_vagrant
install_nodejs
install_yarn
update_npm
install_inter_font
install_jetbrains_mono_font
install_oh_my_zsh
