function fish_user_key_bindings
  # fzf
  bind \cf fzf_change_directory

  # vim-like
  bind \cl forward-char

  # prevent the terminal from closing when typing Ctrl-D (EOF)
  bind \cd delete-char
end

# fzf.fish plugin (fisher install PatrickF1/fzf.fish), if present
if functions -q fzf_configure_bindings
    fzf_configure_bindings --directory=\co
end
