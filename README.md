# dotfiles

[hiroga](https://github.com/xhiroga)'s development environment.

## Run

```shell
# (only macOS) install CLT and homebrew
sudo xcode-select --install
/usr/bin/ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"

brew install gh gomplate

gh auth login
gh repo clone https://github.com/xhiroga/dotfiles
cd dotfiles

GIT_USER_NAME=$GIT_USER_NAME GIT_USER_EMAIL=$GIT_USER_EMAIL echo "{\"git_user_name\": \"$GIT_USER_NAME\", \"git_user_email\": \"$GIT_USER_EMAIL\"}" > values.json

gomplate -d values.json --input-dir . --output-dir ~
```


## Architecture

### zsh

- The folder structure is based on prezto[^sorin-ionescu/prezto].

## References and Inspiration

- [hiroga - awesome dotfiles](https://hiroga.notion.site/awesome-dotfiles-602a35a6001347f6a79f2e4ed53e0302)
- [sorin-ionescu/prezto]: [sorin\-ionescu/prezto: The configuration framework for Zsh](https://github.com/sorin-ionescu/prezto)
- [実践 Vim 　思考のスピードで編集しよう！](https://amzn.to/2RO11fr)
