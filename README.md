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

## Architecture


### zsh

- The folder structure is based on prezto[^sorin-ionescu/prezto].

## References and Inspiration

- [実践 Vim 　思考のスピードで編集しよう！](https://amzn.to/2RO11fr)
- [^sorin-ionescu/prezto]: [sorin\-ionescu/prezto: The configuration framework for Zsh](https://github.com/sorin-ionescu/prezto)
- [holman/dotfiles: @holman does dotfiles](https://github.com/holman/dotfiles) - dotfiles. Aliases are categorized by applications. Scripts are well separated. Uses defaults.
- [dotfiles/\.osx at main · mathiasbynens/dotfiles](https://github.com/mathiasbynens/dotfiles) - dotfiles. The most starred. Uses defaults.
- [skwp/dotfiles: YADR \- The best vim,git,zsh plugins and the cleanest vimrc you've ever seen](https://github.com/skwp/dotfiles) - dotfiles. Enough documentation.
