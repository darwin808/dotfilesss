# ========================================
# Profiling (uncomment to measure startup time)
# ========================================
zmodload zsh/zprof

# ========================================
# ZSH Options
# ========================================
DISABLE_AUTO_UPDATE="true"
DISABLE_MAGIC_FUNCTIONS="true"

# ========================================
# History Configuration
# ========================================
HISTFILE=~/.zsh_history
HISTSIZE=10000
SAVEHIST=10000
setopt SHARE_HISTORY          # Share history between sessions
setopt HIST_IGNORE_DUPS       # Don't save duplicates
setopt HIST_IGNORE_SPACE      # Ignore commands starting with space
setopt HIST_VERIFY            # Show command before executing from history

# ========================================
# PATH Configuration
# ========================================
export PATH="$PATH:/usr/local/share/npm/bin"
export PATH="$PATH:/Applications/Visual Studio Code.app/Contents/Resources/app/bin"
export PATH="$PATH:/Applications/Docker.app/Contents/Resources/bin/"
export PATH="$PATH:$HOME/.yarn/bin"
export PATH="/usr/local/opt/openjdk@17/bin:$PATH"

# ========================================
# Android & Java
# ========================================
export ANDROID_HOME=$HOME/Library/Android/sdk
export PATH=$PATH:$ANDROID_HOME/emulator
export PATH=$PATH:$ANDROID_HOME/platform-tools
export JAVA_HOME=/Library/Java/JavaVirtualMachines/zulu-17.jdk/Contents/Home

# ========================================
# Go Configuration
# ========================================
export GOPRIVATE="github.com/zesty-io"
export GOPATH=$HOME/go
export PATH=$PATH:/usr/local/go/bin:$GOPATH/bin

# ========================================
# Maven
# ========================================
export M2_HOME="/Users/darwin/Documents/apache-maven-3.9.8"
export PATH="${M2_HOME}/bin:${PATH}"

# ========================================
# Deno
# ========================================
export DENO_INSTALL="/Users/darwin/.deno"
export PATH="$DENO_INSTALL/bin:$PATH"

# ========================================
# Bun
# ========================================
export BUN_INSTALL="$HOME/.bun"
export PATH="$BUN_INSTALL/bin:$PATH"

# ========================================
# pnpm
# ========================================
export PNPM_HOME="/Users/darwin/Library/pnpm"
case ":$PATH:" in
  *":$PNPM_HOME:"*) ;;
  *) export PATH="$PNPM_HOME:$PATH" ;;
esac

# ========================================
# Aliases
# ========================================
alias vim="nvim"
alias t="tmux"
alias c="clear"
alias e="exit"
alias em="emacs -nw"
alias python="python3"
alias gp="git pull origin"
alias gs="git status"
alias nt="npm test"
alias nc="npm run test:unit:coverage"
alias zzz="zellij"

# ========================================
# FNM (Fast Node Manager) - Optimized
# ========================================
# Only load fnm env once, without auto-cd hook (lazy-load it instead)
eval "$(fnm env --shell zsh)"

# ========================================
# Lazy-load Pyenv (loads only when 'python' or 'pyenv' is called)
# ========================================
if command -v pyenv 1>/dev/null 2>&1; then
  export PYENV_ROOT="$HOME/.pyenv"
  export PATH="$PYENV_ROOT/bin:$PATH"

  # Lazy-load pyenv
  pyenv() {
    unfunction pyenv
    eval "$(command pyenv init -)"
    eval "$(command pyenv virtualenv-init -)"
    pyenv "$@"
  }
fi

# ========================================
# Lazy-load Conda (loads only when 'conda' is called)
# ========================================
export PATH="/opt/anaconda3/bin:$PATH"
alias pip=/opt/anaconda3/bin/pip3

conda() {
  unfunction conda
  __conda_setup="$('/opt/anaconda3/bin/conda' 'shell.zsh' 'hook' 2> /dev/null)"
  if [ $? -eq 0 ]; then
      eval "$__conda_setup"
  else
      if [ -f "/opt/anaconda3/etc/profile.d/conda.sh" ]; then
          . "/opt/anaconda3/etc/profile.d/conda.sh"
      fi
  fi
  unset __conda_setup
  conda "$@"
}

# ========================================
# Starship Prompt
# ========================================
eval "$(starship init zsh)"

# ========================================
# Completions System (LOAD ONCE ONLY)
# ========================================
autoload -Uz compinit
# Only regenerate compdump once per day
if [[ -n ${HOME}/.zcompdump(#qN.mh+24) ]]; then
  compinit
else
  compinit -C -d "${HOME}/.zcompdump"
fi

# Load bashcompinit for bash-style completions
autoload -U +X bashcompinit && bashcompinit

# ========================================
# Bun completions
# ========================================
[ -s "/Users/darwin/.bun/_bun" ] && source "/Users/darwin/.bun/_bun"

# ========================================
# Terraform & Terragrunt Completions (deferred)
# ========================================
if command -v terraform &> /dev/null; then
  complete -o nospace -C /usr/local/bin/terraform terraform 2>/dev/null
fi
if [ -f /usr/local/Cellar/tfenv/3.0.0/versions/1.7.1/terraform ]; then
  complete -o nospace -C /usr/local/Cellar/tfenv/3.0.0/versions/1.7.1/terraform terraform 2>/dev/null
fi
if command -v terragrunt &> /dev/null; then
  complete -o nospace -C /usr/local/bin/terragrunt terragrunt 2>/dev/null
fi

# ========================================
# Lazy-load Google Cloud SDK (only load when 'gcloud' is called)
# ========================================
if [ -f '/Users/darwin/Downloads/google-cloud-sdk/path.zsh.inc' ]; then
  source '/Users/darwin/Downloads/google-cloud-sdk/path.zsh.inc'
fi

# Lazy-load gcloud completions
gcloud() {
  if [ -f '/Users/darwin/Downloads/google-cloud-sdk/completion.zsh.inc' ]; then
    source '/Users/darwin/Downloads/google-cloud-sdk/completion.zsh.inc'
  fi
  unfunction gcloud
  gcloud "$@"
}

# ========================================
# Plugins (fast loading)
# ========================================
# zsh-autosuggestions
ZSH_AUTOSUGGEST_BUFFER_MAX_SIZE="20"
ZSH_AUTOSUGGEST_USE_ASYNC=1
[[ -f ~/.oh-my-zsh/custom/plugins/zsh-autosuggestions/zsh-autosuggestions.zsh ]] && \
  source ~/.oh-my-zsh/custom/plugins/zsh-autosuggestions/zsh-autosuggestions.zsh

# ========================================
# Syntax Highlighting (MUST BE LAST)
# ========================================
# Using fast-syntax-highlighting (2-3x faster than zsh-syntax-highlighting)
[[ -f ~/fast-syntax-highlighting/fast-syntax-highlighting.plugin.zsh ]] && \
  source ~/fast-syntax-highlighting/fast-syntax-highlighting.plugin.zsh

# ========================================
# Profiling (uncomment to see results)
# ========================================
# zprof
