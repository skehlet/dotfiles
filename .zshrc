# .zshrc is for interactive shell configuration. You set options for the interactive shell there with the setopt and unsetopt commands. You can also load shell modules, set your history options, change your prompt, set up zle and completion, et cetera. You also set any variables that are only used in the interactive shell (e.g. $LS_COLORS).

autoload -U select-word-style
select-word-style bash
# behave similarly to bash's revert-line
bindkey "^[r" undo

PROMPT='[%@] %m:%~ %# '

alias l='ls -la'
alias rm='rm -i'
alias cp='cp -i'
alias mv='mv -i'

hdiff() {
    colordiff -u --strip-trailing-cr "$@" | /opt/homebrew/share/git-core/contrib/diff-highlight/diff-highlight
}

pip-install-save() { 
    pip install "$1" && pip freeze | grep "$1" >> requirements.txt
}

pip-update-all() {
    pip --disable-pip-version-check list --outdated --format=json \
        | python -c "import json, sys; print('\n'.join([x['name'] for x in json.load(sys.stdin)]))" \
        | xargs -n1 pip install -U
}

showcert() {
    openssl s_client -connect "$1" <<<'QUIT' | openssl x509 -noout -text -certopt no_pubkey -certopt no_sigdump
}

# do something with this at some point
# for f in *; do [[ -f "$f" ]] && { echo $f; git diff 'HEAD@{1 day ago}' HEAD -- "$f" }; done

# mac os x ls color
export LSCOLORS=DxGxcxdxCxegedabagacad
alias ls="ls -GF"

export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"  # This loads nvm
[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"  # This loads nvm bash_completion
