if status is-interactive
    # Commands to run in interactive sessions can go here
end
set fish_greeting ""
zoxide init fish | source
neofetch --disable GPU
direnv hook fish | source
