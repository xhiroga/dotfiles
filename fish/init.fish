#!/bin/bash
argparse 'f/force' -- $argv

# install softwares
brew update
brew bundle --file=../Brewfile

# fish
if ! test -z $_flag_f || ! test -f ~/.config/fish/functions/fisher.fish
    curl -Lo ~/.config/fish/functions/fisher.fish --create-dirs git.io/fisher
end

# aws
## official tools
if ! test -z $_flag_f || ! test -f ~/.aws/cli/alias
    set awscli_aliases_temp_dir (mktemp -d)
    git clone https://github.com/awslabs/awscli-aliases.git $awscli_aliases_temp_dir
    mkdir -p ~/.aws/cli
    cp $awscli_aliases_temp_dir/alias ~/.aws/cli/alias
end

if ! test -z $_flag_f || ! test -f /usr/local/bin/ecs-cli
    sudo curl -o /usr/local/bin/ecs-cli https://s3.amazonaws.com/amazon-ecs-cli/ecs-cli-darwin-amd64-latest
    sudo chmod +x /usr/local/bin/ecs-cli
end

## 3rd party tools
if ! test -z $_flag_f || ! test -f /usr/local/bin/chamber
    set CHAMBER_VERSION v2.3.3
    curl -o /usr/local/bin/chamber -LOs https://github.com/segmentio/chamber/releases/download/$CHAMBER_VERSION/chamber-$CHAMBER_VERSION-darwin-amd64
    chmod +x /usr/local/bin/chamber
end

## docker
ln -Fs /Applications/Docker.app/Contents/Resources/etc/docker.bash-completion /usr/local/etc/bash_completion.d/docker
ln -Fs /Applications/Docker.app/Contents/Resources/etc/docker-machine.bash-completion /usr/local/etc/bash_completion.d/docker-machine
ln -Fs /Applications/Docker.app/Contents/Resources/etc/docker-compose.bash-completion /usr/local/etc/bash_completion.d/docker-compose

## gcloud
gcloud components update --quiet
gcloud components install beta --quiet

## git
git config --global user.name "Hiroaki Ogasawara"
git config --global user.email hiroga1030@gmail.com
git config --global push.default current

if ! test -z $_flag_f || test ! -f ~/.git-prompt.sh
    curl https://raw.githubusercontent.com/git/git/master/contrib/completion/git-prompt.sh -o ~/.git-prompt.sh
end

if ! test -z $_flag_f || ! test -f ~/.git-completion.bash
curl https://raw.githubusercontent.com/git/git/master/contrib/completion/git-completion.bash -o ~/.git-completion.bash
end

# node
npm install -g base64-url-cli

## OneDrive
set UNAME (uname -n)
mkdir -p ~/OneDrive\ -\ hiroga/Images/Screenshots/$UNAME
defaults write com.apple.screencapture location ~/OneDrive\ -\ hiroga/Images/Screenshots/$UNAME

## vim
if ! test -e ~/vimrc
    git clone https://gist.github.com/1e7ae56f94ea301e9b585663d275ccc4.git ~/vimrc
end

## VSCode
if test -e ~/Library/Application\ Support/Code/User
    set DATE (date "+%Y%m%d%H%M%S")
    mv ~/Library/Application\ Support/Code/User ~/Library/Application\ Support/Code/User_$DATE
    git clone https://github.com/hiroga-cc/code_user_settings ~/Library/Application\ Support/Code/User
end

# fish
ln -f ./config.fish ~/.config/fish/config.fish
ln -f ./fishfile ~/.config/fish/fishfile
fisher

function fish_prompt --description 'define the appearance of the command line prompt by @hiroga_cc'
    printf '%s%s%s' (set_color white -b 666666)" "(date '+%Y-%m-%d %H:%M:%S')" " (set_color black -b E5E5E5)" "(prompt_pwd)" " (set_color black -b 8CF77C)" "(__fish_git_prompt | sed -e 's/ (//' -e 's/)$//')" " (set_color normal)(echo " \$ ")
end
funcsave fish_prompt
