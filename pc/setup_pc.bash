#!/bin/bash

# Script para configuração inicial de um PC com Ubuntu/Debian
# Autor: Cauan Victor

echo " ";
echo -e "\e[34m   ####     ###    ##   ##    ###    ##   ## \e[0m";
echo -e "\e[34m  ##  ##   ## ##   ##   ##   ## ##   ###  ## \e[0m";
echo -e "\e[34m ##       ##   ##  ##   ##  ##   ##  #### ## \e[0m";
echo -e "\e[34m ##       ##   ##  ##   ##  ##   ##  ####### \e[0m";
echo -e "\e[34m ##       #######  ##   ##  #######  ## #### \e[0m";
echo -e "\e[34m  ##  ##  ##   ##  ##   ##  ##   ##  ##  ### \e[0m";
echo -e "\e[34m   ####   ##   ##   #####   ##   ##  ##   ## \e[0m";
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
        echo -e "Homebrew já está instalado. \e[32m✅\e[0m"
    fi

    echo -e "Instalação do Homebrew concluída. \e[32m✅\e[0m"
}

# Função para instalação de ferramentas adicionais via Snap
install_snap_tools() {
    if ! command -v code &>/dev/null; then
        sudo snap install code --classic > /dev/null 2>&1
    else
        echo -e "Ferramentas adicionais via Snap já estão instaladas. \e[32m✅\e[0m"
    fi

    echo -e "Instalação de ferramentas adicionais via Snap concluída. \e[32m✅\e[0m"
}

# Função para instalação de softwares adicionais
install_additional_software() {
    if ! command -v obs &>/dev/null; then
        sudo add-apt-repository -y ppa:obsproject/obs-studio > /dev/null 2>&1
        sudo apt update > /dev/null 2>&1
        sudo apt install -y obs-studio > /dev/null 2>&1
    else
        echo -e "OBS Studio já está instalado. \e[32m✅\e[0m"
    fi

    if ! command -v vlc &>/dev/null || ! command -v discord &>/dev/null || ! command -v spotify &>/dev/null; then
        sudo snap install vlc discord spotify > /dev/null 2>&1
    else
        echo -e "Softwares adicionais via Snap já estão instalados. \e[32m✅\e[0m"
    fi

    echo -e "Instalação de softwares adicionais concluída. \e[32m✅\e[0m"
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
        echo -e "\e[34mDocker\e[0m já está instalado. \e[32m✅\e[0m"
    fi

    echo -e "Instalação do \e[34mDocker\e[0m concluída. \e[32m✅\e[0m"
}

# Função para instalação do VirtualBox
install_virtualbox() {
    if ! command -v vboxmanage &>/dev/null; then
        sudo apt install -y virtualbox > /dev/null 2>&1
    else
        echo -e "\e[34mVirtualBox\e[0m já está instalado. \e[32m✅\e[0m"
    fi

    echo -e "Instalação do \e[34mVirtualBox\e[0m concluída. \e[32m✅\e[0m"
}

# Função para instalação do Vagrant
install_vagrant() {
    if ! command -v vagrant &>/dev/null; then
        wget -O- https://apt.releases.hashicorp.com/gpg | sudo gpg --dearmor | sudo tee /usr/share/keyrings/hashicorp-archive-keyring.gpg > /dev/null 2>&1
        echo "deb [signed-by=/usr/share/keyrings/hashicorp-archive-keyring.gpg] https://apt.releases.hashicorp.com $(lsb_release -cs) main" | sudo tee /etc/apt/sources.list.d/hashicorp.list > /dev/null
        sudo apt update > /dev/null 2>&1
        sudo apt install -y vagrant > /dev/null 2>&1
    else
        echo -e "\e[34mVagrant\e[0m já está instalado. \e[32m✅\e[0m"
    fi

    echo -e "Instalação do \e[34mVagrant\e[0m concluída. \e[32m✅\e[0m"
}

# Função para instalação do Node.js LTS
install_nodejs() {
    if ! command -v node &>/dev/null || ! node -v | grep -q "v14"; then
        curl -fsSL https://deb.nodesource.com/setup_lts.x | sudo -E bash - > /dev/null 2>&1
        sudo apt install -y nodejs > /dev/null 2>&1
        sudo npm install -g npm@latest > /dev/null 2>&1
    else
        echo -e "\e[32mNode.js LTS\e[0m já está instalado. \e[32m✅\e[0m"
    fi

    echo -e "Instalação do \e[32mNode.js LTS\e[0m concluída. \e[32m✅\e[0m"
}

# Função para instalação do Yarn
install_yarn() {
    if ! command -v yarn &>/dev/null; then
        sudo npm install -g yarn@latest > /dev/null 2>&1
    else
        echo -e "\e[32mYarn\e[0m já está instalado. \e[32m✅\e[0m"
    fi

    echo -e "Instalação do \e[32mYarn\e[0m concluída. \e[32m✅\e[0m"
}

# Função para instalar a fonte Inter
install_inter_font() {
    if [ ! -d /usr/share/fonts/inter ]; then
        wget -O /tmp/Inter-4.0.zip https://github.com/rsms/inter/releases/download/v4.0/Inter-4.0.zip > /dev/null 2>&1
        sudo unzip -o /tmp/Inter-4.0.zip -d /usr/share/fonts/inter > /dev/null 2>&1
        rm /tmp/Inter-4.0.zip
        sudo fc-cache -f -v > /dev/null 2>&1
        echo -e "Fonte Inter instalada com sucesso. \e[32m✅\e[0m"
    else
        echo -e "A pasta da fonte Inter já existe. \e[32m✅\e[0m"
    fi

    echo -e "Instalação da fonte Inter concluída. \e[32m✅\e[0m"
}

# Função para instalar a fonte JetBrains Mono
install_jetbrains_mono_font() {
    if [ ! -d /usr/share/fonts/jetbrains-mono ]; then
        wget -O /tmp/JetBrainsMono-2.304.zip https://github.com/JetBrains/JetBrainsMono/releases/download/v2.304/JetBrainsMono-2.304.zip > /dev/null 2>&1
        sudo unzip -o /tmp/JetBrainsMono-2.304.zip -d /usr/share/fonts/jetbrains-mono > /dev/null 2>&1
        rm /tmp/JetBrainsMono-2.304.zip
        sudo fc-cache -f -v > /dev/null 2>&1
        echo -e "Fonte JetBrains Mono instalada com sucesso. \e[32m✅\e[0m"
    else
        echo -e "A pasta da fonte JetBrains Mono já existe. \e[32m✅\e[0m"
    fi

    echo -e "Instalação da fonte JetBrains Mono concluída. \e[32m✅\e[0m"
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
        echo -e "\e[32mOh My Zsh\e[0m já está instalado. \e[32m✅\e[0m"
    fi

    echo -e "Instalação do Oh My Zsh e configuração do tema Powerlevel9k concluídas. \e[32m✅\e[0m"
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
