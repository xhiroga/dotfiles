JAVA_HOME = ~/.sdkman/candidates/java/8.0.272.j9-adpt
ELIXIR = /usr/local/bin/elixir
GRAALVM_CE_JAVA8_LATEST_DIR = /Library/Java/JavaVirtualMachines/graalvm-ce-java8-latest
GHCUP_DIR = ~/.ghcup
RUSTUP = ~/.cargo/bin/rustup
SCALA_VERSION = 2.13.3
SDKMAN_DIR = ~/.sdkman

.PHONY: update install ex;

install: core java;

ex: elixir graalvm haskell rust scala;

core:
	./install

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

octave:
	brew tap octave-app/octave-app
	brew install octave
	brew cask install octave-app

clean-octave:
	brew uninstall octave
	brew cask uninstall octave-app

rust: $(RUSTUP);
$(RUSTUP):
	rustup=$(curl --proto '=https' --tlsv1.2 -sSf https://sh.rustup.rs)
	sh -c "${rustup}" -- "-y"
	# https://www.rust-lang.org/tools/install

clean-rust:
	rustup self uninstall
	# https://www.rust-lang.org/tools/install

scala:
	export SDKMAN_DIR=~/.sdkman && source ~/.sdkman/bin/sdkman-init.sh && sdk install scala $(SCALA_VERSION)

clean-scala:
	sdk uninstall scala $(SCALA_VERSION)

sdkman: $(SDKMAN_DIR);
$(SDKMAN_DIR):
	curl -s "https://get.sdkman.io" | bash
	export SDKMAN_DIR=~/.sdkman
	source ~/.sdkman/bin/sdkman-init.sh
