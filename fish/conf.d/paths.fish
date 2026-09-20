# PATH entries that installers only wrote into zsh/bash startup files
# (~/.zshenv, ~/.profile). Fish doesn't read those, so mirror them here.

# rustup / cargo  (~/.zshenv sources ~/.cargo/env)
test -f ~/.cargo/env.fish && source ~/.cargo/env.fish

# Docker Desktop  (~/.profile)
test -d ~/.docker/bin && not contains ~/.docker/bin $PATH && set -gx PATH $PATH ~/.docker/bin
