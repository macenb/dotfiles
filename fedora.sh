#!/bin/bash

INSTALL_DIR=$(pwd)

sudo dnf update -y

sudo dnf group install development-tools -y
sudo dnf install -y git akmod-nvidia \
    xorg-x11-drv-nvidia-cuda vim gdb gdb-gdbserver \
    python-devel python3-devel make binutils-devel \
    java-21-openjdk java-21-openjdk-devel gcc-c++ \
    strongswan libusb1 libusb1-devel binwalk \
    dnf-plugins-core golang sshpass gimp zsh \
    bat 
# sudo dnf install -y brave-browser
sudo dnf install -y upx radare2 wireshark nmap \
    strace ltrace hashcat yara
sudo dnf remove -y @kde-pim
sudo dnf-3 config-manager --add-repo https://download.docker.com/linux/fedora/docker-ce.repo
sudo dnf install -y docker-ce docker-ce-cli containerd.io docker-buildx-plugin docker-compose-plugin

# install vscode : https://code.visualstudio.com/docs/setup/linux#_install-vs-code-on-linux
sudo rpm --import https://packages.microsoft.com/keys/microsoft.asc &&
echo -e "[code]\nname=Visual Studio Code\nbaseurl=https://packages.microsoft.com/yumrepos/vscode\nenabled=1\nautorefresh=1\ntype=rpm-md\ngpgcheck=1\ngpgkey=https://packages.microsoft.com/keys/microsoft.asc" | sudo tee /etc/yum.repos.d/vscode.repo > /dev/null
dnf check-update && sudo dnf install -y code

# group adds and whatnot
echo "Adding user to groups and enabling services..."
sudo systemctl enable --now docker
sudo usermod -aG dialout macen
sudo usermod -aG wireshark macen
sudo usermod -aG docker macen

# rust
echo "Installing rust..."
curl --proto '=https' --tlsv1.2 https://sh.rustup.rs -sSf | sh

# conda
echo "Installing conda..."
wget https://repo.anaconda.com/miniconda/Miniconda3-latest-Linux-x86_64.sh
bash Miniconda3-latest-Linux-x86_64.sh

# make sure you install it to ~/miniconda3
echo "Setting up the conda environment..."
$HOME/miniconda3/bin/conda create --name ctf < linux-ctf.yml

# flatpak
echo "Installing flatpak apps..."
flatpak install -y com.discordapp.Discord com.spotify.Client md.obsidian.Obsidian \
    io.github.dvlv.boxbuddyrs com.github.skylot.jadx

# SUBLIME
echo "Installing Sublime Text..."
sudo rpm -v --import https://download.sublimetext.com/sublimehq-rpm-pub.gpg
sudo dnf config-manager addrepo --from-repofile=https://download.sublimetext.com/rpm/stable/x86_64/sublime-text.repo
sudo dnf install -y sublime-text

# copy the bashrc over
# cp $INSTALL_DIR/.bashrc $HOME/.bashrc
# source $HOME/.bashrc

# copy the zshrc over
echo "Initializing zsh..."
cp $INSTALL_DIR/.zshrc $HOME/.zshrc
cp $INSTALL_DIR/.p10k.zsh $HOME/.p10k.zsh
cp $INSTALL_DIR/.antigenrc $HOME/.antigenrc
curl -L git.io/antigen > antigen.zsh
mv antigen.zsh $HOME/antigen.zsh
chsh -s $(which zsh)

# generate an SSH key
echo "Generating SSH key..."
ssh-keygen -q -f "$HOME/.ssh/id_ed25519" -N ""
mkdir -p "$HOME/.ssh"
echo "Host github.com
  HostName github.com
  User git
  IdentityFile ~/.ssh/id_ed25519
  IdentitiesOnly yes" >> "$HOME/.ssh/config"
# don't forget to add that on github

# do some cloning
echo "Setting up basic tools..."
mkdir -p "$HOME/tools"
git clone https://github.com/danielmiessler/SecLists.git "$HOME/tools/SecLists"
git clone https://github.com/volatilityfoundation/volatility3.git "$HOME/tools/volatility3"
git clone https://github.com/extremecoders-re/pyinstxtractor.git "$HOME/tools/pyinstxtractor"

echo "Installing Android Studio..."
cd ~/Downloads
wget https://redirector.gvt1.com/edgedl/android/studio/ide-zips/2025.2.1.7/android-studio-2025.2.1.7-linux.tar.gz
tar -xvf android-studio-2025.2.1.7-linux.tar.gz
cd android-studio/bin
./studio.sh

# pwndbg
echo "Setting up GDB plugins..."
cd ~/tools
git clone https://github.com/pwndbg/pwndbg
cd pwndbg
./setup.sh

# gef
bash -c "$(curl -fsSL https://gef.blah.cat/sh)"

# then copy the gdbinit
cp $INSTALL_DIR/.gdbinit $HOME/.gdbinit
cp $INSTALL_DIR/pwntemplate.py $HOME/tools/pwntemplate.py

cargo install pwninit

# now do the pretties
cd ~/Downloads
wget https://github.com/romkatv/dotfiles-public/raw/master/.local/share/fonts/NerdFonts/MesloLGS%20NF%20Regular.ttf
wget https://github.com/romkatv/dotfiles-public/raw/master/.local/share/fonts/NerdFonts/MesloLGS%20NF%20Bold.ttf
wget https://github.com/romkatv/dotfiles-public/raw/master/.local/share/fonts/NerdFonts/MesloLGS%20NF%20Italic.ttf
wget https://github.com/romkatv/dotfiles-public/raw/master/.local/share/fonts/NerdFonts/MesloLGS%20NF%20Bold%20Italic.ttf
mkdir -p ~/.local/share/fonts/
cp *.ttf ~/.local/share/fonts/
fc-cache -fv

# set up konsole for it, too
cp $INSTALL_DIR/zsh.profile ~/.local/share/konsole/zsh.profile
sed -i 's/^DefaultProfile=.*$/DefaultProfile=zsh.profile/' ~/.config/konsolerc
