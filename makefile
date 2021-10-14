ifeq ($(OS),Windows_NT)
    CCFLAGS += -D WIN32
    ifeq ($(PROCESSOR_ARCHITEW6432),AMD64)
        CCFLAGS += -D AMD64
    else
        ifeq ($(PROCESSOR_ARCHITECTURE),AMD64)
            CCFLAGS += -D AMD64
        endif
        ifeq ($(PROCESSOR_ARCHITECTURE),x86)
            CCFLAGS += -D IA32
        endif
    endif
else
    UNAME_S := $(shell uname -s)
    ifeq ($(UNAME_S),Linux)
        CCFLAGS += -D LINUX
    endif
    ifeq ($(UNAME_S),Darwin)
        CCFLAGS += -D OSX
    endif
    UNAME_P := $(shell uname -p)
    ifeq ($(UNAME_P),x86_64)
        CCFLAGS += -D AMD64
    endif
    ifneq ($(filter %86,$(UNAME_P)),)
        CCFLAGS += -D IA32
    endif
    ifneq ($(filter arm%,$(UNAME_P)),)
        CCFLAGS += -D ARM
    endif
endif
# https://stackoverflow.com/questions/714100/os-detecting-makefile

JAVA_HOME = ~/.sdkman/candidates/java/8.0.272.j9-adpt
ANYENV = ~/.anyenv
AWS_DIR = ~/.aws
ELIXIR = /usr/local/bin/elixir
GRAALVM_CE_JAVA8_LATEST_DIR = /Library/Java/JavaVirtualMachines/graalvm-ce-java8-latest
GHCUP_DIR = ~/.ghcup
GOPATH = ~/.ghq
KARABINER_JSON = ~/.config/karabiner/karabiner.json
LITTLE_SNITCH = /Applications/Little\ Snitch.app
LUA = /usr/local/bin/lua
MICRO_SNITCH = /Applications/Micro\ Snitch.app
NVM_DIR = ~/.nvm
PYTHON = ~/.anyenv/envs/pyenv
PYTHON3_6 = 3.6.12    # https://www.python.org/dev/peps/pep-0494/
PYTHON3_7 = 3.7.9     # https://www.python.org/dev/peps/pep-0537/
PYTHON3_8 = 3.8.6     # https://www.python.org/dev/peps/pep-0569/
PYTHON3_9 = 3.9.0     # https://www.python.org/dev/peps/pep-0596/
RUBY = ~/.anyenv/envs/rbenv
RUBY2_6 = 2.6.4
RUSTUP = ~/.cargo/bin/rustup
SCALA_VERSION = 2.13.3
SDKMAN_DIR = ~/.sdkman
SHELLS = /etc/shells
VSCODE = /Applications/Visual\ Studio\ Code.app
ZSH_COMPLETIONS="/usr/local/share/zsh-completions"

.PHONY: update install ex;

update:
	./bin/update

install: os bash zsh git tmux vim vscode java node python ruby;

ex: coq elixir go graalvm haskell lua ocaml rust scala;

anyenv: $(ANYENV);
$(ANYENV):
	./bin/anyenv-install-update

aws: $(AWS_DIR)
	mkdir -p $(AWS_DIR)/cli
	cp -f ./applications/aws/awscli-aliases/alias $(AWS_DIR)/cli/alias

coq:
	brew install coq

bash: shell
	ln -fn .bash_profile ~/.bash_profile
	ln -fn .bashrc ~/.bashrc

docker:
	ln -fns /Applications/Docker.app/Contents/Resources/etc/docker.bash-completion /usr/local/etc/bash_completion.d/docker
	ln -fns /Applications/Docker.app/Contents/Resources/etc/docker-compose.bash-completion /usr/local/etc/bash_completion.d/docker-compose
	ln -fns /Applications/Docker.app/Contents/Resources/etc/docker-machine.bash-completion /usr/local/etc/bash_completion.d/docker-machine
	ln -fns /Applications/Docker.app/Contents/Resources/etc/docker.zsh-completion "${ZSH_COMPLETIONS}/_docker"
	ln -fns /Applications/Docker.app/Contents/Resources/etc/docker-compose.zsh-completion "${ZSH_COMPLETIONS}/_docker-compose"
	ln -fns /Applications/Docker.app/Contents/Resources/etc/docker-machine.zsh-completion "${ZSH_COMPLETIONS}/_docker-machine"

gcloud:
	gcloud components update --quiet
	gcloud components install beta --quiet

git:
	ln -fn .git-completion.bash ~/.git-completion.bash
	ln -fn .git-prompt.sh ~/.git-prompt.sh
	cp -f .gitconfig ~/.gitconfig
	# git config --global *** を実行する予定があるが、実行するとハードリンク先のファイルのみ上書きされる。なので、あらかじめコピーにしてしまう。
	ln -fn .gitignore_global ~/.gitignore_global
	./bin/git-config-user

git-secrets:
	git secrets --register-aws --global
	git secrets --install ~/.git-templates/git-secrets
	git config --global init.templateDir ~/.git-templates/git-secrets

elixir: $(ELIXIR);
$(ELIXIR):
	brew install elixir

clean-elixir:
	brew uninstall elixir

graalvm: $(GRAALVM_CE_JAVA8_LATEST_DIR);
$(GRAALVM_CE_JAVA8_LATEST_DIR):
	./bin/graalvm-ce-java8-up

go: $(GOPATH);
$(GOPATH):
	# go itself is managed by Homebrew
	mkdir -p $(GOPATH)

clean-graalvm:
	brew uninstall graalvm-ce-java8

haskell: $(GHCUP_DIR);
$(GHCUP_DIR):
	# 親切なZennの記事に従って設定 https://zenn.dev/autotaker/articles/haskell-setup-2021
	curl --proto '=https' --tlsv1.2 -sSf https://get-ghcup.haskell.org | sh
	ghcup install ghc 8.10.4
	ghcup install cabal 3.4.0.0
	ghcup install hls 1.1.0

	# 上記のZennの記事ではcabalを推しているが、IntelliJのプラグインがStackを使っているのでそちらもインストールする。
	# https://docs.haskellstack.org/en/stable/install_and_upgrade
	curl -sSL https://get.haskellstack.org/ | sh
	stack setup


clean-haskell:
	rm -rf $(GHCUP_DIR)

java: $(JAVA_HOME);
$(JAVA_HOME): sdkman;
	export SDKMAN_DIR=~/.sdkman && source ~/.sdkman/bin/sdkman-init.sh && sdk install java 8.0.272.j9-adpt
	# I choose OpenJ9 than HotSpot based on https://www.royvanrijn.com/blog/2018/05/openj9-jvm-shootout/

karabiner: $(KARABINER_JSON);
$(KARABINER_JSON):
	mkdir -p ~/.config/karabiner
	ln -f "./applications/karabiner/karabiner.json" $(KARABINER_JSON)

little-snitch: $(LITTLE_SNITCH)
$(LITTLE_SNITCH):
	./bin/little-snitch-register-license

lua: $(LUA);
$(LUA):
	brew install lua

micro-snitch: $(MICRO_SNITCH)
$(MICRO_SNITCH):
	./bin/micro-snitch-register-license

node: $(NVM_DIR);
$(NVM_DIR):
	./bin/nvm-install

npm-install-global:
	./bin/npm-install-global # TODO 用途ごとに整理する。

octave:
	brew tap octave-app/octave-app
	brew install octave
	brew cask install octave-app

clean-octave:
	brew uninstall octave
	brew cask uninstall octave-app

onedrive:
	./bin/screencapture-location-onedrive

ocaml:
	brew install opam
	opam init

os:
ifneq (,$(findstring OSX,$(CCFLAGS)))
	./bin/macos
	brew update
	brew bundle --file=./Brewfile
else
	echo "TODO"
endif

python: $(PYTHON);
$(PYTHON): anyenv;
	anyenv install -s pyenv
	pyenv install -s $(PYTHON3_6)
	pyenv install -s $(PYTHON3_7)
	pyenv install -s $(PYTHON3_8)
	pyenv install -s $(PYTHON3_9)
	pyenv global $(PYTHON3_9)

ruby: $(RUBY);
$(RUBY): anyenv;
	anyenv install -s rbenv
	rbenv install -s $(RUBY2_6)
	rbenv global $(RUBY2_6)
	bundler -h >/dev/null 2>&1 || sudo gem install bundler
	gem specific_install -h >/dev/null 2>&1 || sudo gem install specific_install
	t -h >/dev/null 2>&1 || sudo gem specific_install http://github.com/xhiroga/t.git

rust: $(RUSTUP);
$(RUSTUP):
	rustup=$(curl --proto '=https' --tlsv1.2 -sSf https://sh.rustup.rs)
	sh -c "${rustup}" -- "-y"
	# https://www.rust-lang.org/tools/install

	cargo install cargo-generate --features vendored-openssl

rustwasm: rust;
	curl "https://rustwasm.github.io/wasm-pack/installer/init.sh" -sSf | sh

clean-rust:
	rustup self uninstall
	# https://www.rust-lang.org/tools/install

scala:
	export SDKMAN_DIR=~/.sdkman && source ~/.sdkman/bin/sdkman-init.sh && sdk install scala $(SCALA_VERSION)
	# sdkman, brewのどちらでもインストールできるが、Javaをマネージしている方に寄せたほうがよいのでは？と判断。

clean-scala:
	sdk uninstall scala $(SCALA_VERSION)

sdkman: $(SDKMAN_DIR);
$(SDKMAN_DIR):
	curl -s "https://get.sdkman.io" | bash
	export SDKMAN_DIR=~/.sdkman
	source ~/.sdkman/bin/sdkman-init.sh

shell: $(SHELLS)
	ln -fn .aliases ~/.aliases
	ln -fn .inputrc ~/.inputrc
	ln -fn .profile ~/.profile
	ln -fn prompt_hiroga_setup ~/prompt_hiroga_setup

$(SHELLS):
	sudo ln -f shells /etc/shells
	chsh -s /bin/zsh

tmux:
	ln -fn .tmux.conf ~/.tmux.conf

vim:
	ln -f .vimrc ~/.vimrc

vscode: $(VSCODE);
$(VSCODE):
	./bin/vscode-install

zsh: shell
	./bin/ln-zsh-dotfiles
