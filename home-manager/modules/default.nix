{ pkgs, lib, ... }@input:
let
  mkDefaultModule =
    mod:
    let
      module =
        let
          module = import mod;
        in
        if lib.isFunction module then module input else module;
      config = module.config or module;
      isNotMergable = value: (lib.isBool value || lib.isInt value || lib.isFloat value);
    in
    {
      imports = lib.map mkDefaultModule (module.imports or [ ]);
      options = module.options or { };
      config = lib.mapAttrsRecursive (
        _: value: if isNotMergable value then lib.mkDefault value else value
      ) config;
    };
in
{
  imports = lib.map mkDefaultModule [
    ./fish.nix
    ./git.nix
    ./librewolf
    ./hyprland.nix
    ./hyprlock.nix
    ./kitty.nix
    ./nixvim
    ./utils.nix
  ];
}
