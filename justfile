ghms:
  git cadn && git psfl && sudo nix flake update --flake $FLAKE && home-manager switch --flake $FLAKE

hms:
  sudo nix flake update --flake $FLAKE && home-manager switch --flake $FLAKE
