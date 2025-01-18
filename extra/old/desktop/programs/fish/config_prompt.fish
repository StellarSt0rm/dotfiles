#Prepare
history -r "$HOME/.local/share/fish/fish_history" &> /dev/null
set latest_command ( eval history | head -n 1 )
set has_clean false
set was_clr false
if test "$latest_command" = clr -o "$latest_command" = clear
	set N2 "\n"
else
	set N2 ""
end

#Prompt
function fish_prompt
	#Checks
	if test "$TERM" = "linux" -o "$TERM_PROGRAM" = "vscode"
		set MIN_PROMPT true
		set VENV_ICON "📦"
		
		if test "$TERM_PROGRAM" = "vscode"
			#set STARTEDVS true
		end
	else
		set MIN_PROMPT false
		set VENV_ICON " "
	end
	
	set last_command ( eval history | head -n 1 )
	if test "$last_command" = "clr" -o "$last_command" = "clear" -o "$has_clean" = true -o "$STARTEDVS" = "true"
		if test "$was_clr" = false
			set N ""
			set has_clean false
			set was_clr true
			set STARTEDVS false
		else
			set N "\n"
		end
	else
		set N "\n"
		set was_clr false
	end
	
	#Prompt Dynamics
	if test "$VIRTUAL_ENV" 
		set DIR (string replace -r "$VIRTUAL_ENV" (basename "$VIRTUAL_ENV") "$PWD")
		
		if begin string match -q "$VIRTUAL_ENV/*" "$PWD"; or string match -q "$VIRTUAL_ENV" "$PWD"; end
			set DIR (echo "$VENV_ICON/$DIR")				
		else
			set DIR (string replace -r "$HOME" "~" "$PWD")
			set DIR (echo "($VENV_ICON)$DIR")
		end
	else
		set DIR (string replace -r "$HOME" "~" "$PWD")
	end


	set prompt_length (string length "╭──($USER@$hostname)-[]")
	set term_length (tput cols)
	set basename_length (string length (basename $DIR))
	set max_length (math "($term_length - $prompt_length) - $basename_length + 5")
	
	if test (string length $DIR) -gt $max_length
		set shortened (echo (echo "$DIR" | cut -c1-$max_length) | grep -oP '.*[^/]*/' | sed 's/.$//')
		set DIR "$shortened/…/$(basename "$PWD")"
	end
	
	#Print Prompt
	if test "$MIN_PROMPT" = "true"
		echo -ne "\r$N\033[0;2m(\033[0;94m$USER\033[0;94m@\033[0;94m$hostname\033[0;2m)-[\033[0;1m$DIR\033[0;2m]\033[0;2m - \033[0;1;94m\$ \033[0m"
	else
		echo -ne "\r$N\033[0;2m╭──(\033[0;94m$USER\033[0;94m@\033[0;94m$hostname\033[0;2m)-[\033[0;1m$DIR\033[0;2m]\n\033[0;2m╰─\033[0;1;94m\$ \033[0m"
	end
end
