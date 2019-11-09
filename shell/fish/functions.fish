function fish_prompt --description 'define the appearance of the command line prompt by @hiroga_cc'
    printf '\n%s%s%s%s' (set_color white -b 666666)" "(date '+%Y-%m-%d %H:%M:%S')" " (set_color black -b E5E5E5)" "(basename $PWD)" " (set_color black -b EB8431)" "(__fish_git_prompt | sed -e 's/ (//' -e 's/)$//')" " (set_color normal)\n\$" "
end
funcsave fish_prompt

# http://ka2n.hatenablog.com/entry/2017/01/09/fish_shell%E3%81%A7z%E3%81%AE%E7%B5%90%E6%9E%9C%E3%82%92peco%E3%81%A3%E3%81%A6%E7%88%86%E9%80%9F%E3%81%A7%E3%83%87%E3%82%A3%E3%83%AC%E3%82%AF%E3%83%88%E3%83%AA%E7%A7%BB%E5%8B%95%E3%81%99%E3%82%8B
function peco_z
  set -l query (commandline)

  if test -n $query
    set peco_flags --query "$query"
  end

  z -l | peco $peco_flags | awk '{ print $2 }' | read recent
  if [ $recent ]
      cd $recent
      commandline -r ''
      commandline -f repaint
  end
end
funcsave peco_z
