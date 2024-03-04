#!/bin/bash

# Script para configuração inicial de um PC com Ubuntu/Debian
# Autor: Cauan Victor

echo " ";
echo "   ####     ###    ##   ##    ###    ##   ## ";
echo "  ##  ##   ## ##   ##   ##   ## ##   ###  ## ";
echo " ##       ##   ##  ##   ##  ##   ##  #### ## ";
echo " ##       ##   ##  ##   ##  ##   ##  ####### ";
echo " ##       #######  ##   ##  #######  ## #### ";
echo "  ##  ##  ##   ##  ##   ##  ##   ##  ##  ### ";
echo "   ####   ##   ##   #####   ##   ##  ##   ## ";
echo " ";

# Função para atualização do sistema e instalação de pacotes básicos
install_basic_packages() {
    echo "Atualizando pacotes básicos... "
    sudo apt update -y > /dev/null 2>&1
    sudo apt upgrade -y > /dev/null 2>&1
    sudo apt install -y curl git python3 python3-pip nano vim ffmpeg > /dev/null 2>&1
}

# Função para instalação do Homebrew
install_homebrew() {
    if ! command -v brew &>/dev/null; then
        /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)" > /dev/null 2>&1
    else
        echo "Homebrew já está instalado."
    fi

    echo "Instalação do Homebrew concluída."
}

# Função para instalação de ferramentas adicionais via Snap
install_snap_tools() {
    if ! command -v code &>/dev/null; then
        sudo snap install code --classic > /dev/null 2>&1
    else
        echo "Ferramentas adicionais via Snap já estão instaladas."
    fi

    echo "Instalação de ferramentas adicionais via Snap concluída."
}

# Função para instalação de softwares adicionais
install_additional_software() {
    if ! command -v obs &>/dev/null; then
        sudo add-apt-repository -y ppa:obsproject/obs-studio > /dev/null 2>&1
        sudo apt update > /dev/null 2>&1
        sudo apt install -y obs-studio > /dev/null 2>&1
    else
        echo "OBS Studio já está instalado."
    fi

    if ! command -v vlc &>/dev/null || ! command -v discord &>/dev/null || ! command -v spotify &>/dev/null; then
        sudo snap install vlc discord spotify > /dev/null 2>&1
    else
        echo "Softwares adicionais via Snap já estão instalados."
    fi

    echo "Instalação de softwares adicionais concluída."
}

# Função para instalação do Docker
install_docker() {
    if ! command -v docker &>/dev/null; then
        sudo apt install -y apt-transport-https ca-certificates curl gnupg lsb-release > /dev/null 2>&1
        sudo mkdir -p /etc/apt/keyrings
        sudo curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo gpg --dearmor -o /etc/apt/keyrings/docker-archive-keyring.gpg > /dev/null 2>&1
        echo "deb [arch=$(dpkg --print-architecture) signed-by=/etc/apt/keyrings/docker-archive-keyring.gpg] https://download.docker.com/linux/ubuntu $(lsb_release -cs) stable" | sudo tee /etc/apt/sources.list.d/docker.list > /dev/null
        sudo apt update > /dev/null 2>&1
        sudo apt install -y docker-ce docker-ce-cli containerd.io docker-buildx-plugin docker-compose-plugin > /dev/null 2>&1
    else
        echo "Docker já está instalado."
    fi

    echo "Instalação do Docker concluída."
}

# Função para instalação do VirtualBox
install_virtualbox() {
    if ! command -v vboxmanage &>/dev/null; then
        sudo apt install -y virtualbox > /dev/null 2>&1
    else
        echo "VirtualBox já está instalado."
    fi

    echo "Instalação do VirtualBox concluída."
}

# Função para instalação do Vagrant
install_vagrant() {
    if ! command -v vagrant &>/dev/null; then
        wget -O- https://apt.releases.hashicorp.com/gpg | sudo gpg --dearmor | sudo tee /usr/share/keyrings/hashicorp-archive-keyring.gpg > /dev/null 2>&1
        echo "deb [signed-by=/usr/share/keyrings/hashicorp-archive-keyring.gpg] https://apt.releases.hashicorp.com $(lsb_release -cs) main" | sudo tee /etc/apt/sources.list.d/hashicorp.list > /dev/null
        sudo apt update > /dev/null 2>&1
        sudo apt install -y vagrant > /dev/null 2>&1
    else
        echo "Vagrant já está instalado."
    fi

    echo "Instalação do Vagrant concluída."
}

# Função para instalação do Node.js LTS
install_nodejs() {
    if ! command -v node &>/dev/null || ! node -v | grep -q "v14"; then
        curl -fsSL https://deb.nodesource.com/setup_lts.x | sudo -E bash - > /dev/null 2>&1
        sudo apt install -y nodejs > /dev/null 2>&1
        sudo npm install -g npm@latest > /dev/null 2>&1
    else
        echo "Node.js LTS já está instalado."
    fi

    echo "Instalação do Node.js LTS concluída."
}

# Função para instalação do Yarn
install_yarn() {
    if ! command -v yarn &>/dev/null; then
        sudo npm install -g yarn@latest > /dev/null 2>&1
    else
        echo "Yarn já está instalado."
    fi

    echo "Instalação do Yarn concluída."
}

# Função para instalar a fonte Inter
install_inter_font() {
    if [ ! -d /usr/share/fonts/inter ]; then
        wget -O /tmp/Inter-4.0.zip https://github.com/rsms/inter/releases/download/v4.0/Inter-4.0.zip > /dev/null 2>&1
        sudo unzip -o /tmp/Inter-4.0.zip -d /usr/share/fonts/inter > /dev/null 2>&1
        rm /tmp/Inter-4.0.zip
        sudo fc-cache -f -v > /dev/null 2>&1
        echo "Fonte Inter instalada com sucesso."
    else
        echo "A pasta da fonte Inter já existe."
    fi

    echo "Instalação da fonte Inter concluída."
}

# Função para instalar a fonte JetBrains Mono
install_jetbrains_mono_font() {
    if [ ! -d /usr/share/fonts/jetbrains-mono ]; then
        wget -O /tmp/JetBrainsMono-2.304.zip https://github.com/JetBrains/JetBrainsMono/releases/download/v2.304/JetBrainsMono-2.304.zip > /dev/null 2>&1
        sudo unzip -o /tmp/JetBrainsMono-2.304.zip -d /usr/share/fonts/jetbrains-mono > /dev/null 2>&1
        rm /tmp/JetBrainsMono-2.304.zip
        sudo fc-cache -f -v > /dev/null 2>&1
        echo "Fonte JetBrains Mono instalada com sucesso."
    else
        echo "A pasta da fonte JetBrains Mono já existe."
    fi

    echo "Instalação da fonte JetBrains Mono concluída."
}

# Função para instalação do Oh My Zsh e configuração do tema Powerlevel9k
install_oh_my_zsh() {
    if [ ! -d ~/.oh-my-zsh ]; then
        sudo apt install -y zsh > /dev/null 2>&1
        sudo usermod -s /usr/bin/zsh $(whoami)
        sudo apt install -y zsh-theme-powerlevel9k > /dev/null 2>&1
        echo "source /usr/share/powerlevel9k/powerlevel9k.zsh-theme" >> ~/.zshrc
        sudo apt install -y zsh-syntax-highlighting > /dev/null 2>&1
        echo "source /usr/share/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh" >> ~/.zshrc
        for user in $(ls /home); do
            sudo usermod -s /usr/bin/zsh $user
            sudo chsh -s /usr/bin/zsh $user
            sudo cp ~/.zshrc /home/$user/
            sudo chown $user:$user /home/$user/.zshrc
            sudo -u $user bash -c 'sudo apt install -y zsh' > /dev/null 2>&1
            sudo -u $user bash -c 'sudo apt install -y zsh-theme-powerlevel9k' > /dev/null 2>&1
            sudo -u $user bash -c 'echo "source /usr/share/powerlevel9k/powerlevel9k.zsh-theme" >> ~/.zshrc'
            sudo -u $user bash -c 'sudo apt install -y zsh-syntax-highlighting' > /dev/null 2>&1
            sudo -u $user bash -c 'echo "source /usr/share/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh" >> ~/.zshrc'
            sudo -u $user bash -c 'sh -c "$(curl -fsSL https://raw.github.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"' > /dev/null 2>&1
        done
    else
        echo "Oh My Zsh já está instalado."
    fi

    echo "Instalação do Oh My Zsh e configuração do tema Powerlevel9k concluídas."
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
install_inter_font
install_jetbrains_mono_font
install_oh_my_zsh
