# Enable Powerlevel10k instant prompt. Should stay close to the top of ~/.zshrc.
# Initialization code that may require console input (password prompts, [y/n]
# confirmations, etc.) must go above this block; everything else may go below.
if [[ -r "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh" ]]; then
  source "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh"
fi

# Created by newuser for 5.9
source /home/macen/antigen.zsh
antigen init ~/.antigenrc

# To customize prompt, run `p10k configure` or edit ~/.p10k.zsh.
[[ ! -f ~/.p10k.zsh ]] || source ~/.p10k.zsh

# make sure we don't do weird stuff in distrobox
. /etc/os-release
if [ "$ID" = "fedora" ]; then
    # custom PATH additions
    # Install Ruby Gems to ~/gems
    export GEM_HOME="$HOME/gems"
    export PATH="$HOME/gems/bin:$PATH"

    # cuda drivers
    export PATH=$PATH:/usr/local/cuda/bin/

    # android studio
    export ANDROID_HOME=$HOME/Android/Sdk
    export PATH=$PATH:$ANDROID_HOME/emulator
    export PATH=$PATH:$ANDROID_HOME/platform-tools
    export PATH=$PATH:/home/macen/tools/codeql/codeql

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

    # Aliases
    alias pwninit='pwninit --template-path ~/ctf/pwntools_default.py'

    # >>> conda initialize >>>
    # !! Contents within this block are managed by 'conda init' !!
    __conda_setup="$('/home/macen/miniconda3/bin/conda' 'shell.zsh' 'hook' 2> /dev/null)"
    if [ $? -eq 0 ]; then
        eval "$__conda_setup"
    else
        if [ -f "/home/macen/miniconda3/etc/profile.d/conda.sh" ]; then
            . "/home/macen/miniconda3/etc/profile.d/conda.sh"
        else
            export PATH="/home/macen/miniconda3/bin:$PATH"
        fi
    fi
    unset __conda_setup
    # <<< conda initialize <<<
    conda activate ctf
    alias cat='bat'

    # make sure cargo is included
    . "$HOME/.cargo/env"
fi