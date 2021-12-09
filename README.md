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

## References and Inspiration

- [実践 Vim 　思考のスピードで編集しよう！](https://amzn.to/2RO11fr)
- [sorin\-ionescu/prezto: The configuration framework for Zsh](https://github.com/sorin-ionescu/prezto)
