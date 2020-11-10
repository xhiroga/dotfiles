ELIXIR = /usr/local/bin/elixir
GRAALVM_CE_JAVA8_LATEST_DIR = /Library/Java/JavaVirtualMachines/graalvm-ce-java8-latest
GHCUP_DIR = ~/.ghcup
RUSTUP = ~/.cargo/bin/rustup

.PHONY: update install ex clean-elixir clean-haskell clean-rust;

install: core;

ex: elixir haskell rust;

core:
	./install

elixir: $(ELIXIR);
$(ELIXIR):
	brew install elixir

clean-elixir:
	brew uninstall elixir

graalvm-ce-java8-up: $(GRAALVM_CE_JAVA8_LATEST_DIR);
$(GRAALVM_CE_JAVA8_LATEST_DIR):
	./bin/graalvm-ce-java8-up

clean-graalvm8:
	brew uninstall graalvm-ce-java8

haskell: $(GHCUP_DIR);
$(GHCUP_DIR):
	curl --proto '=https' --tlsv1.2 -sSf https://get-ghcup.haskell.org | sh

clean-haskell:
	rm -rf $(GHCUP_DIR)

rust: $(RUSTUP);
$(RUSTUP):
	rustup=$(curl --proto '=https' --tlsv1.2 -sSf https://sh.rustup.rs)
	sh -c "${rustup}" -- "-y"
	# https://www.rust-lang.org/tools/install

clean-rust:
	rustup self uninstall
	# https://www.rust-lang.org/tools/install
