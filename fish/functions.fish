function fish_prompt --description 'define the appearance of the command line prompt by @hiroga_cc'
    printf '%s%s%s' (set_color white -b 666666)" "(date '+%Y-%m-%d %H:%M:%S')" " (set_color black -b E5E5E5)" "(prompt_pwd)" " (set_color black -b 8CF77C)" "(__fish_git_prompt | sed -e 's/ (//' -e 's/)$//')" " (set_color normal)(echo " \$ ")
end
funcsave fish_prompt
