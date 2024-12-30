update: 
  nix flake update --flake $FLAKE

ghms:
  git cadn && git psfl && sudo nix flake update --flake $FLAKE && home-manager switch --flake $FLAKE

hms:
  nix flake update --flake $FLAKE && home-manager switch --flake $FLAKE

gnixs:
  git cadn && git psfl && nix flake update --flake $FLAKE && sudo nixos-rebuild switch --flake $FLAKE

nixs:
  sudo nix flake update --flake $FLAKE && sudo nixos-rebuild switch --flake $FLAKE
