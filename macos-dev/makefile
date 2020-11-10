RUSTUP = ~/.cargo/bin/rustup
GHCUP = ~/.ghcup

.PHONY: update install ex clean;

install: core;

ex: haskell rust;

core:
	./install

clean: clean-rust;

haskell: $(GHCUP);
$(GHCUP):
	curl --proto '=https' --tlsv1.2 -sSf https://get-ghcup.haskell.org | sh

clean-haskell:
	rm -rf $(GHCUP)

rust: $(RUSTUP);
$(RUSTUP):
	rustup=$(curl --proto '=https' --tlsv1.2 -sSf https://sh.rustup.rs)
	sh -c "${rustup}" -- "-y"
	# https://www.rust-lang.org/tools/install

clean-rust:
	rustup self uninstall
	# https://www.rust-lang.org/tools/install
