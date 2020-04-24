# dotfiles

[hiroga](https://github.com/hiroga-cc)'s development environment.

## setup

```shell script
export GITHUB_USER="hiroga-cc"
export GITHUB_PERSONAL_TOKEN="$GITHUB_PERSONAL_TOKEN"

# create and add ssh key
./add-ssh-key

# update dotfiles
./update

# (only macOS) install homebrew
/usr/bin/ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"

# install
sudo ./${ENVIRONMENT}/install
```

## References

- [実践 Vim 　思考のスピードで編集しよう！](https://amzn.to/2RO11fr)
