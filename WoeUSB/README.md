Este README contém instruções detalhadas sobre como usar o WoeUSB, Grub Customizer, GParted e corrigir o MBR em sistemas baseados em Ubuntu.

## Instalação do WoeUSB

### Passo 1: Adicionar o repositório WebUpd8

```bash
sudo add-apt-repository ppa:nilarimogard/webupd8
```

### Passo 2: Atualizar a lista de pacotes

```bash
sudo apt update
```

### Passo 3: Instalar as ferramentas WIM

```bash
sudo apt install wimtools
```

### Passo 4: Baixar e Executar o Script WoeUSB

Faça o download do script WoeUSB na versão 5.2.4 [aqui](https://github.com/WoeUSB/WoeUSB/releases/download/v5.2.4/woeusb-5.2.4.bash) e, em seguida, execute-o:

```bash
sudo ./woeusb-5.2.4.bash --device Windows.iso /dev/sda
```

Substitua `Windows.iso` pelo caminho do arquivo ISO do Windows e `/dev/sda` pelo dispositivo USB que você deseja usar como mídia de instalação do Windows.

## Instalação do Grub Customizer

### Passo 1: Adicionar o repositório Grub Customizer

```bash
sudo add-apt-repository ppa:danielrichter2007/grub-customizer -y
```

### Passo 2: Atualizar a lista de pacotes

```bash
sudo apt update
```

### Passo 3: Instalar o Grub Customizer

```bash
sudo apt install grub-customizer -y
```

## Instalação do GParted

### Passo 1: Instalar o GParted

```bash
sudo apt install gparted -y
```

## Corrigir MBR

Se necessário, você pode corrigir o Master Boot Record (MBR) executando o seguinte comando no prompt de comando do Windows:

```bash
bootrec /fixmbr
```

Isso corrige o MBR para o Windows.

Após seguir essas etapas, você terá instalado com sucesso o WoeUSB para criar unidades USB de inicialização do Windows, o Grub Customizer para personalizar o menu de inicialização do Grub, o GParted para gerenciar partições de disco e corrigido o MBR em seu sistema baseado em Ubuntu.