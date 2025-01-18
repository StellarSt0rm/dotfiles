# Overrides
#function fish_command_not_found
#	# Capture command-not-found output, and clean it.
#	set -l temp_file (mktemp)
#	script -qc "/run/current-system/sw/bin/command-not-found $argv" > $temp_file
#	
#	set -l output (cat $temp_file)
#	
#	# Recreate output
#	set -l i "1"
#	
#	for text in $output
#		if string match -qe -- "ephemeral shell" $text; continue; end
#		
#		if string match -qe -- "nix-shell -p" $text
#			echo -n "	($i) "
#			set i (math $i + 1)
#		end
#		
#		echo $text | string trim -l
#	end
#	
#	echo
#	read -P "Chose a package (?):" $selection
#	
#	echo $selection
#end

#Functions
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

function unalias -d "Unalias fish aliases"
	set aliasList (alias)
	set protAlias "clr config py clean-sys pbpaste pbcopy"
	
	for line in $aliasList
		set alias (string split " " $line)[2]
		if ! string match -q "$alias" (string split " " $protAlias)
			set -a aliasList2 $alias
		end
	end
	set aliasList $aliasList2
	set -e aliasList2
	
	if string match -qe -- "-" "$argv[1]"
		if begin; test "$argv[1]" = "--help"; or test "$argv[1]" = "-h"; end
				echo "unalias							 - To Print Set Aliases"
			echo "unalias <alias>			 - To Delete The Alias"
			echo "unalias -a						- To Delete All Set Aliases"
			echo "unalias --help / -h	 - To Dislay This"
			return
		else if test "$argv[1]" = "-a"
			if test -z $aliasList
				echo "Info: No Aliases Set"
				return
			end
			for alias in $aliasList
				functions -e "$alias"
				echo "Deleted Alias '$alias'"
			end
			return
		else 
			echo "Error: Argument Unknown!"
			return
		end
	else if test -z "$argv[1]"
		if test -n "$aliasList"
			echo "Set Aliases:"
			echo -e -- (string join "\n" $aliasList)
		else
			echo "Info: No Aliases Set"
		end
		return
	else
		for alias in $argv
			set found (echo "$aliasList" | string split " " | grep "$alias")
			if test -n "$found"
				functions -e "$alias"
				echo "Deleted Alias '$alias'"
			else
				echo "Error: Could Not Delete Alias '$alias'"
			end
		end
	end
end

function config -d "Access Fish Configs"
	set configPath "$HOME/.config/fish"
	if string match -qe -- "-" "$argv[1]"
		if begin; test "$argv[1]" = "--help"; or test "$argv[1]" = "-h"; end
			echo "config							 - To Open Default Config File"
			echo "config <file>				- To Open Specific Config File"
			echo "config -a						- To Open All Config Files"
			echo "config -l						- To List All Config Files"
			echo "config --help / -h	 - To Dislay This"
		else if test "$argv[1]" = "-a"
			gnome-text-editor "$configPath/config.fish" (find -L "$configPath" -maxdepth 1 -name "config_*.fish")
		else if test "$argv[1]" = "-l"
			echo "config"
			string replace -r ".fish" "" (string replace -r "$configPath/" "" (find -L "$configPath" -maxdepth 1 -name "config_*.fish"))
		else
			echo "Error: Unknown Argument!"
		end
	else if test -n "$argv[1]"
		if test "$argv[1]" = "config"
			gnome-text-editor "$configPath/config.fish"
		else if test -f "$configPath/config_$argv[1].fish"
			gnome-text-editor "$configPath/config_$argv[1].fish"
		else
			echo "Error: Config File Not Found!"
		end
	else
		gnome-text-editor "$configPath/config.fish"
	end
end


#VENV Functions
#function venv-create -d "Attempt To Create A VENV"
#	set lang $argv[1]
#	set path $argv[2]
#	
#	if test -n "$lang" -o -n "$path"
#		if string match -qie -- "py" "$lang"
#			echo -n "Creating PY VENV, This Might Take A Minute..."
#			python -m venv $path
#			echo -e " \033[1m\033[32m[DONE]\033[0m"
#			
#			read -P "Run VENV Now? [y/N]: " answer
#				
#			if string match -qie "y" "$answer"
#				cd $path
#				venv-activate
#			end
#		else
#			echo "Error: Language Not Known Or Supported!"
#		end
#	else
#		echo "Error: Not Enough Arguments!"
#	end
#end
#
#function venv-activate -d "Attempt To Activate A VENV"
#	if test -n "$VIRTUAL_ENV"
#		echo "Error: You're Already In A VENV!"
#		return
#	end
#	
#	if test -n "$argv[1]"
#		set location (string replace -r "/\/+" "" "$argv[1]")
#	else
#		set location "."
#	end
#		if test -f "$location/bin/activate.fish"
#		source "$location/bin/activate.fish"
#		functions -e __fish_fnc_venv_deactivate
#		functions -c deactivate __fish_fnc_venv_deactivate
#		functions -e deactivate
#		
#		__fish_fnc_venv_declare
#		cd $VIRTUAL_ENV
#		
#		function cd
#			if begin; test -z "$argv[1]"; or string match -q -- "--" "$argv"; end
#				builtin cd "$VIRTUAL_ENV"
#			else
#				builtin cd $argv
#			end
#		end
#	else
#		echo "Error: VENV Activation Script Not Found!"
#	end
#end
#
#function __fish_fnc_venv_declare
#	function venv-deactivate -d "Attempt To Deactivate The Current VENV"
#		if test -z "$VIRTUAL_ENV"
#			echo "Error: You're Not In A VENV!"
#		end
#		if test "$VIRTUAL_ENV"
#			cd $VIRTUAL_ENV
#			
#			__fish_fnc_venv_deactivate
#			functions -e venv-deactivate venv-info cd
#			cd ..
#		end
#	end
#	function venv-info -d "Display Info Of The Current VENV"
#		if test "$VIRTUAL_ENV"
#			echo "Name:" (basename "$VIRTUAL_ENV")
#			echo "Path:" (string replace -r "$HOME" "~" "$VIRTUAL_ENV")
#			echo "Packages:" (pip freeze | wc -l)
#			echo -e "Size:" (string match -gr "^([0-9]+)([A-Z]+)" -i (du -sh $VIRTUAL_ENV | cut -f1)) "\033[1DB"
#		else
#			echo "Error: You're Not In A VENV!"
#		end
#	end
#end
