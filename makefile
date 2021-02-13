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
ELIXIR = /usr/local/bin/elixir
GRAALVM_CE_JAVA8_LATEST_DIR = /Library/Java/JavaVirtualMachines/graalvm-ce-java8-latest
GHCUP_DIR = ~/.ghcup
GOPATH = ~/.ghq
LUA = /usr/local/bin/lua
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

.PHONY: update install ex;

install: os core java node python;

ex: elixir go graalvm haskell lua rust scala;

core:
	./install

anyenv: $(ANYENV);
$(ANYENV):
	./bin/anyenv-install-update

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

os:
ifneq (,$(findstring OSX,$(CCFLAGS)))
		./bin/macos
else
		echo "TODO"
endif

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

ruby: $(RUBY);
$(RUBY): anyenv;
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
