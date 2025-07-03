set fish_greeting ""
set EDITOR nano

if not status is-interactive
  return
end

function fish_title
  # Get the current command and path,
  # and strip out 'sudo' from the start of the command
  set command (status current-commandline | string replace -r "^sudo " "")
  set path (basename (pwd))

  if test -n "$command"
    # Command
    set trun (string sub -l 17 -- $command)
    if test "$trun" != "$command"; set ext "…"; end

    echo "$trun$ext - Terminal"
  else if test "$path" != (basename $HOME)
    # Path
    set trun (string sub -l 17 -- $path)
    if test "$trun" != "$path"; set ext "…"; end

    echo "$trun$ext/ - Terminal"
  else
    # None
    echo "Terminal"
  end
end

# Functions
function __fish_sudo_ctrl_q
  set -l buf (commandline -b)
  set -l pos (commandline -C)

  if echo "$buf" | grep "^sudo .*\$" 1>/dev/null 2>/dev/null
    commandline -r (string sub -s 6 -- "$buf")
    commandline -C (math $pos-5)
  else
    commandline -r "sudo $buf"
    commandline -C (math $pos+5)
  end
end

function nix-run
  # nix-run {packages} [-- {cmd}]

  set args (string split -f2 -m1 -- "nix-run" (status current-commandline))
  set args (string trim -r -- $args)

  set pkg (string split -f1 -m1 -- " --" $args | string trim | string split " ")
  set cmd (string split -f2 -m1 -- "-- " $args); or set cmd "fish" # Fallback to 'fish'

  if test -z "$pkg"
    echo "nix-run {packages} [-- {cmd}]"
    return 1
  end

  nix-shell -p $pkg --run "$cmd"
end

function rebuild-sys
  # rebuild-sys {switch | test | boot}

  set args (string split -f2 -- "rebuild-sys " (status current-commandline))
  set mode (string split -f1 -- " " $args)

  if test -z "$mode"
    echo "rebuild-sys {switch | test | boot}"
    return 1
  else if test -z $hostname
    echo "error: `hostname` environment variable is not set!"
    return 1
  end

  sudo nixos-rebuild "$mode" --flake $HOME/dotfiles/dotfiles#$hostname
end

# Init oh-my-posh
oh-my-posh init fish -c "$HOME/.config/fish/oh-my-posh.toml" | source

# Init FZF
fzf --fish | source
export FZF_CTRL_T_COMMAND="fd --type d --ignore-file ~/.gitignore"

# Aliases and abbrs
alias clr "clear"
abbr --add --position anywhere "gedit" "gnome-text-editor"

alias cb-copy fish_clipboard_copy
alias cb-paste fish_clipboard_paste

alias gst "git status"
alias gdi "git diff"
alias gco "git commit"
alias gad "git add"
alias gch "git checkout"
alias gps "git push"
alias gpl "git pull"
alias gbr "git branch"

alias clean-sys "sudo nix-collect-garbage -d && sudo /run/current-system/bin/switch-to-configuration boot"

# Shell startup
bind \cq '__fish_sudo_ctrl_q'
bind \cd 'echo -e "\033[4A"; exit' # Kinda fix the transient prompt not going away when using Ctrl + D

stty -echo
if test "$TERM_PROGRAM" != "zed" -a -z "$IN_NIX_SHELL"
  clear
  fortune -sn 90 -a riddles | sed 's/\t/ /g'
  echo
  #fastfetch
end
stty echo
