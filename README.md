 run with

nix run nix-darwin -- switch --flake .#earlymoon --show-trace

update
nix flake update && nix run nix-darwin -- switch --flake .#earlymoon --show-trace
