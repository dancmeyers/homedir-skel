[[ -d "${HOME}/bin" ]] && export PATH=${HOME}/bin:${PATH}

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

export SSH_AUTH_SOCK="$(gpgconf --list-dirs agent-ssh-socket)"
alias yubikey-rescan="gpg-connect-agent \"scd serialno\" \"learn --force\" /bye"
alias gpg-agent-reload="gpg-connect-agent reloadagent /bye"

# If there is an env var secrets file, and we have read access, source it
if [[ -r "${HOME}/.env_secrets" ]]; then
  # Don't use [[ -r "file" ]] && cmd, because it'll return nonzero if file doesn't exist
  source "${HOME}/.env_secrets"
fi

# Configure spaceship prompt

# See https://github.com/spaceship-prompt/spaceship-prompt#oh-my-zsh
ZSH_THEME="spaceship"

SPACESHIP_AWS_SHOW=false
SPACESHIP_DIR_COLOR=#87ffff
SPACESHIP_DIR_PREFIX=
SPACESHIP_DIR_TRUNC=0
SPACESHIP_DOCKER_SHOW=false
SPACESHIP_EXEC_TIME_ELAPSED=5
SPACESHIP_GCLOUD_SHOW=false
SPACESHIP_GIT_BRANCH_COLOR=#00d700
SPACESHIP_GIT_PREFIX=
SPACESHIP_HOST_SHOW=always
SPACESHIP_HOST_PREFIX=@
SPACESHIP_HOST_COLOR=#d0d0d0
SPACESHIP_HOST_COLOR_SSH=#d0d0d0
SPACESHIP_KUBECTL_CONTEXT_COLOR=#ffff00
SPACESHIP_KUBECTL_SHOW=true
SPACESHIP_KUBECTL_PREFIX=
SPACESHIP_KUBECTL_VERSION_SHOW=false
SPACESHIP_NODE_PREFIX=
SPACESHIP_NODE_COLOR=#d70000
SPACESHIP_PACKAGE_SHOW=false
SPACESHIP_PROMPT_ASYNC=false
SPACESHIP_PYENV_PREFIX=""
SPACESHIP_TIME_SHOW=true
SPACESHIP_TIME_PREFIX=
SPACESHIP_TIME_COLOR=#d0d0d0
SPACESHIP_USER_SHOW=always
SPACESHIP_USER_COLOR=#d0d0d0
SPACESHIP_USER_COLOR_ROOT=#d70000
SPACESHIP_USER_SUFFIX=""

#SPACESHIP_PROMPT_ORDER=(user host dir git hg gradle node ruby elm elixir xcode swift golang php rust haskell julia docker aws gcloud pyenv dotnet ember kubectl terraform exec_time line_sep battery vi_mode jobs exit_code time char)
SPACESHIP_PROMPT_ORDER=(user host dir git node xcode golang rust docker aws gcloud kubectl terraform exec_time line_sep battery jobs exit_code time char)
