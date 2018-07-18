alias e="vim"
alias l="ls"

function edit_fish_conf
  e $HOME/config/fish/config.fish
end

function fish_prompt
  printf "%s%s|%s%s \$ " (set_color GREEN) (whoami) (set_color BLUE) (prompt_pwd)
end
