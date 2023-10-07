.PHONY: deply
deploy:
	nixos-rebuild switch --flake .

.PHONY: debug
debug:
	nixos-rebuild switch --flake . --show-trace --verbose

.PHONY: init
init:
	nix --experimental-features 'nix-command flakes' flake update
	bin/build

.PHONY: trace
trace:
	nix --experimental-features 'nix-command flakes' flake update
	bin/build --show-trace

.PHONY: show
show:
	nix --experimental-features 'nix-command flakes' flake show

.PHONY: gc
gc:
	# garbage collect all unused nix store entries
	nix store gc --debug
