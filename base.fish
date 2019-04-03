alias e="vim"
alias l="ls"

function edit_fish_conf
  e $HOME/config/fish/config.fish
end

function __git_branch
  if set branch_name (git symbolic-ref --short head 2>/dev/null)
    echo -n " ^$branch_name"
  end
end

function fish_prompt
  printf "uid=%s%s|%s%s%s%s%s \$ " \
    (set_color GREEN) \
    (id -u) \
    (set_color BLUE) \
    (prompt_pwd) \
    (set_color RED) \
    (__git_branch) \
    (set_color BLUE)
end
