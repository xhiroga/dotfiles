# dotfiles

[hiroga](https://github.com/xhiroga)'s development environment.

## setup

```shell script
# (only macOS) install CLT and homebrew
sudo xcode-select --install
/usr/bin/ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"

brew install gh

gh auth login

gh repo clone https://github.com/xhiroga/dotfiles
cd dotfiles
mv sample.env .env

# create or import ~/.ssh

# create and add ssh key
./add-ssh-key

make update
make install
```

## Debug

```shell
chezmoi apply
```

## Architecture

### zsh

- The folder structure is based on prezto[^sorin-ionescu/prezto].

## References and Inspiration

- [dotfiles/\.osx at main · mathiasbynens/dotfiles](https://github.com/mathiasbynens/dotfiles) - (27.2k⭐️) bash. The most starred. Uses `defaults`.
- [thoughtbot/dotfiles: A set of vim, zsh, git, and tmux configuration files\.](https://github.com/thoughtbot/dotfiles) - (6.9k⭐️) zsh. Set-up scripts are well separated.
- [skwp/dotfiles: YADR \- The best vim,git,zsh plugins and the cleanest vimrc you've ever seen](https://github.com/skwp/dotfiles) - (6.8k⭐️) zsh. Set-up scripts are very separated. Enough documentation.
- [holman/dotfiles: @holman does dotfiles](https://github.com/holman/dotfiles) - (6.4k⭐️) zsh. Aliases are categorized by applications. Set-up scripts are well separated. Uses `defaults`.
- [paulirish/dotfiles: paul's shell, git, etc config files\. also homebrew, migration setup\. good stuff\.](https://github.com/paulirish/dotfiles) - (3.9⭐️) bash, fish and zsh. Uses `defaults`. 
- [^sorin-ionescu/prezto]: [sorin\-ionescu/prezto: The configuration framework for Zsh](https://github.com/sorin-ionescu/prezto)
- [実践 Vim 　思考のスピードで編集しよう！](https://amzn.to/2RO11fr)
