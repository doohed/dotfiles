# Homebrew (Apple Silicon)
if test -x /opt/homebrew/bin/brew
    /opt/homebrew/bin/brew shellenv fish | source
end

if type -q eza
  alias ll "eza -l -g --icons"
  alias lla "ll -a"
end

# Docker Desktop
set -gx PATH $HOME/.docker/bin $PATH

# Fzf
set -g FZF_PREVIEW_FILE_CMD "bat --style=numbers --color=always --line-range :500"
set -g FZF_LEGACY_KEYBINDINGS 0
set -gx FZF_DEFAULT_OPTS "--height 40% --layout=reverse --border"
