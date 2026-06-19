# .zshrc is for interactive shell configuration. You set options for the interactive shell there with the setopt and unsetopt commands. You can also load shell modules, set your history options, change your prompt, set up zle and completion, et cetera. You also set any variables that are only used in the interactive shell (e.g. $LS_COLORS).

autoload -U select-word-style
select-word-style bash
# behave similarly to bash's revert-line
bindkey "^[r" undo

PROMPT='[%@] %m:%~ %# '

case $- in
    *i*)
        alias ls="ls -GF"
        alias l='ls -la'
        alias rm='rm -i'
        alias cp='cp -i'
        alias mv='mv -i'
        ;;
esac

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

function git-prod-changes() {
  local latest_prod_tag=$(git tag -l "*latest-prod" --sort=-creatordate | head -n 1)
  echo "Changes since $latest_prod_tag:"
  git log $latest_prod_tag..main --oneline --first-parent
}

function git-dev-changes() {
  local latest_dev_tag=$(git tag -l "*latest-dev" --sort=-creatordate | head -n 1)
  echo "Changes since $latest_dev_tag:"
  git log $latest_dev_tag..main --oneline --first-parent
}

function git-recent-branches() {
  git for-each-ref --sort=-committerdate refs/heads/ --format='%(committerdate:short) %(refname:short)' | head
}

# AI Agent settings
# AI_AGENT is set by VS Code Copilot agent terminals (e.g. AI_AGENT=github_copilot_vscode_agent)
if [[ -n "$AI_AGENT" ]]; then
    # These aliases prompt for confirmation and block agent command execution
    unalias rm cp mv 2>/dev/null
fi

# NVM_DIR is set in .zshenv; sourcing here sets up nvm shell functions for interactive use
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"  # This loads nvm
[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"  # This loads nvm bash_completion
