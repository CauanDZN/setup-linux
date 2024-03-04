#!/bin/bash

# Função para exibir uma barra de progresso
progress_bar() {
    local duration=${1}
    local columns=$(tput cols)
    local progress_char="#"
    local space_char=" "
    local sleep_duration=$(echo "scale=2; $duration / $columns" | bc)
    
    for ((i = 0; i <= columns; i++)); do
        printf "\r%-${columns}s" "${progress_char:0:i}${space_char:i:columns}"
        sleep $sleep_duration
    done
}

# Função para exibir mensagens simplificadas
show_message() {
    local message="${1}"
    echo "${message}..."
    sleep 1
}

# Função para atualização do sistema e instalação de pacotes básicos
install_basic_packages() {
    show_message "Atualizando e instalando pacotes básicos"
    sudo apt update -y &>/dev/null
    sudo apt upgrade -y &>/dev/null
    sudo apt install -y curl git python3 python3-pip nano vim ffmpeg &>/dev/null
}

# Função para instalação do Homebrew
install_homebrew() {
    show_message "Instalando Homebrew"
    if ! command -v brew &>/dev/null; then
        /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)" &>/dev/null
    else
        echo "Homebrew já está instalado."
    fi
}

# Função para instalação de ferramentas adicionais via Snap
install_snap_tools() {
    show_message "Instalando ferramentas adicionais via Snap"
    if ! command -v code &>/dev/null; then
        sudo snap install code --classic &>/dev/null
    else
        echo "Ferramentas adicionais via Snap já estão instaladas."
    fi
}

# Função para instalação de softwares adicionais
install_additional_software() {
    show_message "Instalando softwares adicionais"
    if ! command -v obs &>/dev/null || ! command -v vlc &>/dev/null || ! command -v discord &>/dev/null || ! command -v spotify &>/dev/null; then
        sudo add-apt-repository -y ppa:obsproject/obs-studio &>/dev/null
        sudo apt update &>/dev/null
        sudo apt install -y obs-studio &>/dev/null
        sudo snap install vlc discord spotify &>/dev/null
    else
        echo "Softwares adicionais já estão instalados."
    fi
}

# Função para instalação do Docker
install_docker() {
    show_message "Instalando Docker"
    if ! command -v docker &>/dev/null; then
        sudo apt install -y apt-transport-https ca-certificates curl gnupg lsb-release &>/dev/null
        sudo mkdir -p /etc/apt/keyrings &>/dev/null
        sudo curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo gpg --dearmor -o /etc/apt/keyrings/docker-archive-keyring.gpg &>/dev/null
        echo "deb [arch=$(dpkg --print-architecture) signed-by=/etc/apt/keyrings/docker-archive-keyring.gpg] https://download.docker.com/linux/ubuntu $(lsb_release -cs) stable" | sudo tee /etc/apt/sources.list.d/docker.list > /dev/null
        sudo apt update &>/dev/null
        sudo apt install -y docker-ce docker-ce-cli containerd.io docker-buildx-plugin docker-compose-plugin &>/dev/null
    else
        echo "Docker já está instalado."
    fi
}

# Função para instalação do VirtualBox
install_virtualbox() {
    show_message "Instalando VirtualBox"
    if ! command -v vboxmanage &>/dev/null; then
        sudo apt install -y virtualbox &>/dev/null
    else
        echo "VirtualBox já está instalado."
    fi
}

# Função para instalação do Vagrant
install_vagrant() {
    show_message "Instalando Vagrant"
    if ! command -v vagrant &>/dev/null; then
        wget -O- https://apt.releases.hashicorp.com/gpg | sudo gpg --dearmor | sudo tee /usr/share/keyrings/hashicorp-archive-keyring.gpg &>/dev/null
        echo "deb [signed-by=/usr/share/keyrings/hashicorp-archive-keyring.gpg] https://apt.releases.hashicorp.com $(lsb_release -cs) main" | sudo tee /etc/apt/sources.list.d/hashicorp.list &>/dev/null
        sudo apt update &>/dev/null
        sudo apt install -y vagrant &>/dev/null
    else
        echo "Vagrant já está instalado."
    fi
}

# Função para instalação do Node.js e npm
install_nodejs_npm() {
    show_message "Instalando Node.js e npm"
    if ! command -v node &>/dev/null || ! command -v npm &>/dev/null; then
        curl -fsSL https://deb.nodesource.com/setup_16.x | sudo -E bash - &>/dev/null
        sudo apt install -y nodejs &>/dev/null
    else
        echo "Node.js e npm já estão instalados."
    fi
}

# Função principal para execução das instalações
main() {
    install_basic_packages
    install_homebrew
    install_snap_tools
    install_additional_software
    install_docker
    install_virtualbox
    install_vagrant
    install_nodejs_npm
}

# Execução da função principal com uma barra de progresso
main & progress_bar 80
