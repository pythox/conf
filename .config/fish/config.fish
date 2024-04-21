if status is-interactive
  # Commands to run in interactive sessions can go here
end

# Base16 Shell
if status --is-interactive
    set BASE16_SHELL "$HOME/.config/base16-shell/"
    source "$BASE16_SHELL/profile_helper.fish"
end

#   printf '\n[%s]' (prompt_pwd --full-length-dirs=2 --dir-length=2)

function fish_prompt
	set_color brblack
	echo -n "["(date "+%H:%M")"] "
	set_color blue
	echo -n (hostname)
	if [ $PWD != $HOME ]
		set_color brblack
		echo -n ':'
		set_color yellow
		echo -n (basename $PWD)
#   echo -n (prompt_pwd --full-length-dirs=2 --dir-length=2)
	end
	set_color green
	printf '%s ' (__fish_git_prompt)
	set_color red
	echo -n '| '
	set_color normal
end

base16-gruvbox-dark-hard
