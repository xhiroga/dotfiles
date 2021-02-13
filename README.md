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

export GITHUB_USER="xhiroga"
export GITHUB_PERSONAL_TOKEN="$GITHUB_PERSONAL_TOKEN"

# create or import ~/.ssh

# create and add ssh key
./add-ssh-key

# update dotfiles
./update

# install
sudo ./${ENVIRONMENT}/install
```

## References

- [実践 Vim 　思考のスピードで編集しよう！](https://amzn.to/2RO11fr)
