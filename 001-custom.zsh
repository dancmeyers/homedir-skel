# Override default less on nearly every command...
export LESS="-FRX"

# Set various 'version' shims for *env
which pyenv > /dev/null && eval "$(pyenv init -)"
which rbenv > /dev/null && eval "$(rbenv init -)"

if which brew >/dev/null; then
    # See https://formulae.brew.sh/cask/google-cloud-sdk#default, adds gcloud to path and enables shell completion
    if [[ -d "$(brew --prefix)/Caskroom/google-cloud-sdk" ]]; then
	source "$(brew --prefix)/Caskroom/google-cloud-sdk/latest/google-cloud-sdk/path.zsh.inc"
	source "$(brew --prefix)/Caskroom/google-cloud-sdk/latest/google-cloud-sdk/completion.zsh.inc"
    fi
fi

# Find out what we're running on, for command/path differences
opsys=$( uname )

if [[ "${opsys}" == "Linux" ]]; then
  alias ls="ls -ap --color"
else
  # Assume BSD/Unix style
  alias ls="ls -apG"
fi

alias ll="ls -l"
alias reload="source ${HOME}/.zshrc"

# If there is an env var secrets file, and we have read access, source it
if [[ -r "${HOME}/.env_secrets" ]]; then
  # Don't use [[ -r "file" ]] && cmd, because it'll return nonzero if file doesn't exist
  source "${HOME}/.env_secrets"
fi
