# .zshenv is sourced for every shell (interactive, non-interactive, login, scripts).
# Put environment variables here, not aliases or interactive config.

eval "$(/opt/homebrew/bin/brew shellenv)"

# Add .NET Core SDK tools
case ":$PATH:" in
  *":$HOME/.dotnet/tools:"*) ;;
  *) export PATH="$PATH:$HOME/.dotnet/tools" ;;
esac

# AI Agent settings
# AI_AGENT is set by VS Code Copilot agent terminals (e.g. AI_AGENT=github_copilot_vscode_agent)
if [[ -n "$AI_AGENT" ]]; then
    # Prevent pager from blocking agent output
    export LESS="-FRX"
    export AWS_PAGER=""
fi

# mac os x ls color
export LSCOLORS=DxGxcxdxCxegedabagacad

export NVM_DIR="$HOME/.nvm"

# stop pulumi asking for password for S3 backend state
export PULUMI_CONFIG_PASSPHRASE=

# pnpm
export PNPM_HOME="/Users/stevekehlet/Library/pnpm"
case ":$PATH:" in
  *":$PNPM_HOME:"*) ;;
  *) export PATH="$PNPM_HOME:$PATH" ;;
esac
# pnpm end
