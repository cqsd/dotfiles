alias e="vim"
alias l="ls"

function edit_fish_conf
  e $HOME/.config/fish/config.fish
end

function venv-start
  . ~/.venvs/$1/bin/activate.fish
end

function __git_branch
  if set branch_name (git symbolic-ref --short head 2>/dev/null)
    echo -n " ^$branch_name"
  end
end

function fish_prompt
  if [ -z $SSH_CLIENT ]
    set name_color (set_color GREEN)
  else
    set name_color (set_color RED)
  end
  printf "uid=%s%s|%s%s%s%s%s \$ " \
    $name_color \
    (id -u) \
    (set_color BLUE) \
    (prompt_pwd) \
    (set_color RED) \
    (__git_branch) \
    (set_color BLUE)
end
