# Override default less on nearly every command...
export LESS="-FRX"

# Set various 'version' shims for *env
which pyenv > /dev/null && eval "$(pyenv init -)"
which pyenv-virtualenv > /dev/null && eval "$(pyenv virtualenv-init -)"
export VIRTUAL_ENV_DISABLE_PROMPT=1

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

export SSH_AUTH_SOCK="${HOME}/.gnupg/S.gpg-agent.ssh"
alias yubikey-rescan="gpg-connect-agent \"scd serialno\" \"learn --force\" /bye"

# If there is an env var secrets file, and we have read access, source it
if [[ -r "${HOME}/.env_secrets" ]]; then
  # Don't use [[ -r "file" ]] && cmd, because it'll return nonzero if file doesn't exist
  source "${HOME}/.env_secrets"
fi
