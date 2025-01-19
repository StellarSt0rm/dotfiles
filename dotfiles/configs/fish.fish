set fish_greeting ""

if status is-interactive
  function __fish_fnc_sudo_ctrl_q
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
    
  # Change title style
  function fish_title
    set -l command (status current-command) # Add "line" to include arguments
    echo "$(string sub -l 20 -- $command) - Terminal (fish)"
  end
  
  # Init oh-my-posh - oh-my-posh is broken in Zed at the moment
  if test "$TERM_PROGRAM" != "zed"
    oh-my-posh init fish -c "$HOME/.config/fish/oh-my-posh.toml" | source
  end
  
  # Aliases
  alias clr 'clear'
  abbr --add "gedit" "gnome-text-editor" --position anywhere
  
  alias cb-copy fish_clipboard_copy
  alias cb-paste fish_clipboard_paste
  
  alias clean-sys 'nix-collect-garbage --delete-old && sudo nix-collect-garbage -d && sudo /run/current-system/bin/switch-to-configuration boot'
  
  set EDITOR gnome-text-editor
  
  # Shell startup
  printf '\033[5 q'
  
  stty -echo
  if test "$TERM_PROGRAM" != "zed" -a "$IN_NIX_SHELL" = ""
    clear
    fastfetch
    echo -n -e $N2
  end
  stty echo
end
