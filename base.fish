alias e="vim"
alias l="ls"

function edit_fish_conf
  e $HOME/.config/fish/config.fish
end

function venv-start
  . ~/.venvs/$1/bin/activate.fish
end

function fish_prompt
  set _status $status

  # command subtitution seems to hang if the fn prints nothing.  since some
  # things like aws_session and git branch aren't always printed, we put this
  # in a variable first. empty variable subtitution is fine

  set prompt_date (set_color RED)'['(date "+%d/%m/%y %H:%M:%S")]

  if [ $_status -ne 0 ]
    set prompt_prompt ' '(set_color RED)'('$_status') '(set_color GREEN)"\$ "
  else
    set prompt_prompt ' '(set_color GREEN)"\$ "
  end

  # name overload
  set prompt_pwd_ (set_color GREEN)(prompt_pwd)

  if [ -z $AWS_SESSION_TOKEN ]
      set prompt_aws_session ""
  else
    set prompt_aws_session $AWS_VAULT
    set -q prompt_aws_session
    or set prompt_aws_session unknown
    set prompt_aws_session ' '(set_color YELLOW)aws:$prompt_aws_session
  end

  if set git_branch_name (git symbolic-ref --short head 2>/dev/null)
    set prompt_git_branch (set_color cyan)' 'git:$git_branch_name
  end

  printf "%s%s%s\n%s%s" \
    $prompt_date \
    $prompt_git_branch \
    $prompt_aws_session \
    $prompt_pwd_ \
    $prompt_prompt
end

# fix esc+. not working (grace period is too short by default)
set -g fish_escape_delay_ms 300

set supplemental ~/.config/fish/supplemental.fish
test -f $supplemental; and source $supplemental
