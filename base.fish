alias e="vim"
alias l="ls"
alias la="ls -a"
alias ll="ls -l"
alias topm="top -o mem"
alias tree="tree -C"
alias treel="tree -L 2"

# I'm going to kms if I have to keep typing this out in full
set FISH_HOME $HOME/.config/fish/

function edit_fish_conf
  e $FISH_HOME/config.fish
end

# hide the vi indicator...
# TODO changing modes should change the bg color of the whole prompt
function fish_mode_prompt; end

function fish_prompt
  printf "%s%s|%s%s \$ " (set_color GREEN) (whoami) (set_color BLUE) (prompt_pwd)
end
