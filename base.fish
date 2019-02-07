alias e="vim"
alias l="ls"

function edit_fish_conf
  e $HOME/config/fish/config.fish
end

function fish_prompt
  set name_color (test -z $SSH_CLIENT; and echo (set_color GREEN); or echo (set_color RED))
  printf "%suid=%s%s|%s \$ " $name_color (id -u) (set_color BLUE) (prompt_pwd)
end
