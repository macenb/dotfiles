# .bashrc

# Source global definitions
if [ -f /etc/bashrc ]; then
    . /etc/bashrc
fi

# User specific environment
if ! [[ "$PATH" =~ "$HOME/.local/bin:$HOME/bin:" ]]; then
    PATH="$HOME/.local/bin:$HOME/bin:$PATH"
fi
export PATH

# Uncomment the following line if you don't like systemctl's auto-paging feature:
# export SYSTEMD_PAGER=

# User specific aliases and functions
if [ -d ~/.bashrc.d ]; then
    for rc in ~/.bashrc.d/*; do
        if [ -f "$rc" ]; then
            . "$rc"
        fi
    done
fi
unset rc
. "$HOME/.cargo/env"

alias python='python3'
alias gdb='gdb -q'

alias pwninit='pwninit --template-path ~/tools/pwntemplate.py'

alias please='sudo $(history -p !!)'

############## DOCKERSHELL #####################
alias dockershell="docker run --rm -i -t --entrypoint=/bin/bash"
alias dockershellsh="docker run --rm -i -t --entrypoint=/bin/sh"

function dockershellhere() {
    dirname=${PWD##_/}
    docker run --rm -it --entrypoint=/bin/sh -v `pwd`:/${dirname} -w /${dirname} "$@"
}

function dockershellshhere() {
    dirname=${PWD##_/}
    docker run --rm -it --entrypoint=/bin/sh -v `pwd`:/${dirname} -w /${dirname} "$@"
}

function sage() {
    dirname=${PWD##_/}
    docker run --rm -it --entrypoint=/usr/bin/sage -v `pwd`:/${dirname} -w /${dirname} my-sagemath
}

export PATH=$PATH:/home/macen/Android/Sdk/build-tools/36.0.0/

alias tailscale-up='tailscale up --exit-node=100.66.180.64 --accept-routes --operator=macen'

# Install Ruby Gems to ~/gems
export GEM_HOME="$HOME/gems"
export PATH="$HOME/gems/bin:$PATH"

[[ -r "${HOME}/.nrfutil/share/nrfutil-completion/scripts/bash/setup.bash" ]] && . "${HOME}/.nrfutil/share/nrfutil-completion/scripts/bash/setup.bash"

export PYENV_ROOT="$HOME/.pyenv"
[[ -d $PYENV_ROOT/bin ]] && export PATH="$PYENV_ROOT/bin:$PATH"
eval "$(pyenv init - bash)"

# cuda drivers
export PATH=$PATH:/usr/local/cuda/bin/

# android studio
export ANDROID_HOME=$HOME/Android/Sdk
export PATH=$PATH:$ANDROID_HOME/emulator
export PATH=$PATH:$ANDROID_HOME/platform-tools
