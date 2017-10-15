#
# .zshrc is sourced in interactive shells.
# It should contain commands to set up aliases,
# functions, options, key bindings, etc.
#
bindkey -e
export LANG=ja_JP.UTF-8
export SVN_EDITOR=vim

alias ls='ls -F'
alias ll='ls -al'
alias sudo='sudo -E '
alias fix='php-cs-fixer fix --diff --level=psr2'

autoload -U compinit
compinit -u

#allow tab completion in the middle of a word
setopt COMPLETE_IN_WORD
PROMPT=$'%2F%M $ %f'
#プロンプト色を白にする
#PROMPT=$'%F{white}%M $ %f'
setopt nonomatch

## keep background processes at full speed
#setopt NOBGNICE
## restart running processes on exit
#setopt HUP

## history
#setopt APPEND_HISTORY
## for sharing history between zsh processes
#setopt INC_APPEND_HISTORY
#setopt SHARE_HISTORY

## never ever beep ever
#setopt NO_BEEP

## automatically decide when to page a list of completions
#LISTMAX=0

## disable mail checking
#MAILCHECK=0

# autoload -U colors
#colors

# right prompt
autoload -Uz add-zsh-hook
autoload -Uz vcs_info

zstyle ':vcs_info:*' enable git svn hg bzr
zstyle ':vcs_info:*' formats '[%b]'
zstyle ':vcs_info:*' actionformats '[%b|%a]'
zstyle ':vcs_info:(svn|bzr):*' branchformat '%b:r%r'
zstyle ':vcs_info:bzr:*' use-simple true

autoload -Uz is-at-least
if is-at-least 4.3.10; then
  zstyle ':vcs_info:git:*' check-for-changes true
  zstyle ':vcs_info:git:*' stagedstr "+"
  zstyle ':vcs_info:git:*' unstagedstr "-"
  zstyle ':vcs_info:git:*' formats '[%b%c%u]'
  zstyle ':vcs_info:git:*' actionformats '[%b|%a[%c%u]]'
fi

function _update_vcs_info_msg() {
    psvar=()
    LANG=en_US.UTF-8 vcs_info
    [[ -n "$vcs_info_msg_0_" ]] && psvar[1]="$vcs_info_msg_0_"
}
add-zsh-hook precmd _update_vcs_info_msg
RPROMPT="%1(v|%F{magenta}%1v%f|) [%30<..<%~]"
#RPROMPT="%1(v|%F{white}%1v%f|) [%30<..<%~]"

case "${TERM}" in
screen)
    precmd() {
        echo -ne "\ek$(hostname|awk 'BEGIN{FS="."}{print $1}')"
        psvar=()
        LANG=en_US.UTF-8 vcs_info
        [[ -n "$vcs_info_msg_0_" ]] && psvar[1]="$vcs_info_msg_0_"
    }
;;
esac

#cdしたらlsする
cd ()
{
    builtin cd "$@" && ls
}

#ssh/scpで常にysshを使用する
#if [ -x /usr/local/bin/yssh ]; then
#    alias ssh=yssh
#    alias scp=yscp
#fi

# hostname completion for yssh, yscp
_cache_hosts=(`perl -ne  'if (/^([a-zA-Z0-9.-]+)/) { print "$1\n";}' ~/.ssh/known_hosts`)
compctl -k _cache_hosts -f yssh yscp

# yroot completion
if [ -x /home/y/bin/yroot ]; then
    _yroot_name=(`yroot -l | awk '{print $1}'`)
    compctl -k _yroot_name yroot
fi

# tmuxでForwardAgentを効かせるため
agent="$HOME/.ssh/ssh-agent-$USER"
if [ -z "$YROOT_NAME" ]; then
    if [ -S "$SSH_AUTH_SOCK" ]; then
        case $SSH_AUTH_SOCK in
        /tmp/*/agent.[0-9]*)
            ln -snf "$SSH_AUTH_SOCK" $agent && export SSH_AUTH_SOCK=$agent
        esac
    elif [ -S $agent ]; then
        export SSH_AUTH_SOCK=$agent
    else
        echo "no ssh-agent"
    fi
fi

# コマンド履歴を残す
HISTSIZE=100
HISTFILE=~/.zsh_history
SAVEHIST=100

export PATH=$PATH:~/composer/vendor/bin
export PATH=$HOME/.nodebrew/current/bin:$PATH
