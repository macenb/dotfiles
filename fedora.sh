
sudo dnf update -y

sudo dnf group install development-tools -y
sudo dnf install -y git code akmod-nvidia \
    xorg-x11-drv-nvidia-cuda vim gdb gdb-gdbserver \
    python-devel python3-devel make binutils-devel \
    java-21-openjdk java-21-openjdk-devel gcc-c++ \
    strongswan libusb1 libusb1-devel binwalk \
    dnf-plugins-core golang sshpass gimp
sudo dnf install -y brave-browser
sudo dnf install -y upx radare2 wireshark nmap \
    strace ltrace hashcat yara
sudo dnf remove -y @kde-pim
sudo dnf-3 config-manager --add-repo https://download.docker.com/linux/fedora/docker-ce.repo
sudo dnf install -y docker-ce docker-ce-cli containerd.io docker-buildx-plugin docker-compose-plugin

# group adds and whatnot
sudo systemctl enable --now docker
sudo usermod -aG dialout macen
sudo usermod -aG wireshark macen
sudo usermod -aG docker macen

# rust
curl --proto '=https' --tlsv1.2 https://sh.rustup.rs -sSf | sh

# pip packages
python3 -m pip install pycryptodome pwntools tqdm z3-solver \
    pyelftools capstone angr ROPgadget ropper PyJWT Flask \
    requests frida hermes-dec numpy PyAutoGUI pyghidra

# flatpak
flatpak install -y com.discordapp.Discord com.spotify.Client md.obsidian.Obsidian \
    io.github.dvlv.boxbuddyrs com.github.skylot.jadx

# SUBLIME
sudo rpm -v --import https://download.sublimetext.com/sublimehq-rpm-pub.gpg
sudo dnf config-manager addrepo --from-repofile=https://download.sublimetext.com/rpm/stable/x86_64/sublime-text.repo
sudo dnf install -y sublime-text

# copy the bashrc over
cp $HOME/Downloads/dotfiles/.bashrc $HOME/.bashrc
source $HOME/.bashrc

# generate an SSH key
ssh-keygen -q -f "$HOME/.ssh/id_ed25519" -N ""
mkdir -p "$HOME/.ssh"
echo "Host github.com
  HostName github.com
  User git
  IdentityFile ~/.ssh/id_ed25519
  IdentitiesOnly yes" >> "$HOME/.ssh/config"
# don't forget to add that on github

# do some cloning
git clone https://github.com/danielmiessler/SecLists.git "$HOME/tools/SecLists"
git clone https://github.com/volatilityfoundation/volatility3.git "$HOME/tools/volatility3"
git clone https://github.com/extremecoders-re/pyinstxtractor.git "$HOME/tools/pyinstxtractor"

cd ~/Downloads
wget https://redirector.gvt1.com/edgedl/android/studio/ide-zips/2025.2.1.7/android-studio-2025.2.1.7-linux.tar.gz
tar -xvf android-studio-2025.2.1.7-linux.tar.gz
cd android-studio/bin
./studio.sh

# pwndbg
cd ~/tools
git clone https://github.com/pwndbg/pwndbg
cd pwndbg
./setup.sh

# gef
bash -c "$(curl -fsSL https://gef.blah.cat/sh)"

# then copy the gdbinit
cp $HOME/Downloads/dotfiles/.gdbinit $HOME/.gdbinit
cp $HOME/Downloads/dotfiles/pwntemplate.py $HOME/tools/pwntemplate.py

mkdir -p ~/tools/my_sage/
echo "FROM sagemath/sagemath:latest

RUN sage -python -m pip install pycryptodome numpy gmpy2" > ~/tools/my_sage/Dockerfile
cd ~/tools/my_sage/
docker build -t my-sagemath .

cargo install pwninit
