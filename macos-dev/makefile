JAVA_HOME = ~/.sdkman/candidates/java/8.0.272.j9-adpt
ANYENV = `/.anyenv
ELIXIR = /usr/local/bin/elixir
GRAALVM_CE_JAVA8_LATEST_DIR = /Library/Java/JavaVirtualMachines/graalvm-ce-java8-latest
GHCUP_DIR = ~/.ghcup
LUA = /usr/local/bin/lua
NVM_DIR = ~/.nvm
PYTHON = ~/.anyenv/envs/pyenv
PYTHON3_6 = 3.6.12    # https://www.python.org/dev/peps/pep-0494/
PYTHON3_7 = 3.7.9     # https://www.python.org/dev/peps/pep-0537/
PYTHON3_8 = 3.8.6     # https://www.python.org/dev/peps/pep-0569/
PYTHON3_9 = 3.9.0     # https://www.python.org/dev/peps/pep-0596/
RUSTUP = ~/.cargo/bin/rustup
SCALA_VERSION = 2.13.3
SDKMAN_DIR = ~/.sdkman

.PHONY: update install ex;

install: core java node python;

ex: elixir graalvm haskell lua rust scala;

core:
	./install

anyenv: $(ANYENV);
$(ANYENV):
	yes | anyenv install --init --update || :
	eval "$(anyenv init -)"
	ANYENV_PLUGINS=$(anyenv root)/plugins
	mkdir -p "$ANYENV_PLUGINS"
	git -C "$ANYENV_PLUGINS/anyenv-update" pull || git clone https://github.com/znz/anyenv-update.git "$ANYENV_PLUGINS/anyenv-update"
	anyenv update

elixir: $(ELIXIR);
$(ELIXIR):
	brew install elixir

clean-elixir:
	brew uninstall elixir

graalvm: $(GRAALVM_CE_JAVA8_LATEST_DIR);
$(GRAALVM_CE_JAVA8_LATEST_DIR):
	./bin/graalvm-ce-java8-up

clean-graalvm:
	brew uninstall graalvm-ce-java8

haskell: $(GHCUP_DIR);
$(GHCUP_DIR):
	curl --proto '=https' --tlsv1.2 -sSf https://get-ghcup.haskell.org | sh

clean-haskell:
	rm -rf $(GHCUP_DIR)

java: $(JAVA_HOME);
$(JAVA_HOME): sdkman;
	export SDKMAN_DIR=~/.sdkman && source ~/.sdkman/bin/sdkman-init.sh && sdk install java 8.0.272.j9-adpt
	# I choose OpenJ9 than HotSpot based on https://www.royvanrijn.com/blog/2018/05/openj9-jvm-shootout/

lua: $(LUA);
$(LUA):
	brew install lua

node: $(NVM_DIR);
$(NVM_DIR):
	./bin/nvm-install

octave:
	brew tap octave-app/octave-app
	brew install octave
	brew cask install octave-app

clean-octave:
	brew uninstall octave
	brew cask uninstall octave-app

python: $(PYTHON);
$(PYTHON): anyenv;
	anyenv install -s pyenv
	pyenv install -s $(PYTHON3_6)
	pyenv install -s $(PYTHON3_7)
	pyenv install -s $(PYTHON3_8)
	pyenv install -s $(PYTHON3_9)
	pyenv global $(PYTHON3_9)

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
