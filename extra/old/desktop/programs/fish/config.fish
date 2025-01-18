set fish_greeting ""

if status is-interactive
	# Override Terminal Title When Running Commands
	function fish_title
 		set -l command (status current-command) # Add "line" to include arguments
		echo "$(string sub -l 20 -- $command) - Terminal (fish)"
	end
	
	#Imports	
	source "$HOME/.config/fish/config_functions.fish"
	#source "$HOME/.config/fish/config_prompt.fish" # Disabled To Not Conflict With oh-my-posh
	
	#Alias/Overrides -Start
	oh-my-posh init fish -c "/etc/nixos/desktop/programs/oh-my-posh.toml" | source
	
	alias clr 'clear'
	abbr --add "gedit" --position anywhere "gnome-text-editor"
	
	alias cb-copy fish_clipboard_copy
	alias cb-paste fish_clipboard_paste
	
	alias clean-sys 'nix-collect-garbage --delete-old && sudo nix-collect-garbage -d && sudo /run/current-system/bin/switch-to-configuration boot'
	#alias update-sys ''
	
	alias py 'python'
	set EDITOR gnome-text-editor
	#-End
	
	#Startup Of Shell
	printf '\033[5 q'
	bind \cq '__fish_fnc_sudo_ctrl_q'

	stty -echo
	if test "$TERM_PROGRAM" != "vscode" -a "$IN_NIX_SHELL" = ""
		clear
		fastfetch
		echo -n -e $N2
	end
	stty echo
end
