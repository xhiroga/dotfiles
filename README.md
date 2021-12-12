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

### dotfiles

- [hiroga - awesome dotfiles](https://hiroga.notion.site/awesome-dotfiles-602a35a6001347f6a79f2e4ed53e0302)
- [^sorin-ionescu/prezto]: [sorin\-ionescu/prezto: The configuration framework for Zsh](https://github.com/sorin-ionescu/prezto)
- [実践 Vim 　思考のスピードで編集しよう！](https://amzn.to/2RO11fr)
