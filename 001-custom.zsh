# Override default less on nearly every command...
export LESS="-FRX"

# Set various 'version' shims for *env
which pyenv > /dev/null && eval "$(pyenv init -)"
which rbenv > /dev/null && eval "$(rbenv init -)"

which limactl > /dev/null && eval "$(limactl completion zsh)"

if [[ "${OPSYS}" == "Linux" ]]; then
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
