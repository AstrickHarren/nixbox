{
  settings,
  inputs,
  pkgs,
  lib,
  ...
}:
{
  programs = {
    git = {
      enable = true;
      userName = settings.userName;
      userEmail = "astrick.harren.at.work@gmail.com";
    };
    fish.enable = true;
    kitty.enable = true;
    nixvim.enable = true;
  };

  programs.nixvim.plugins.lsp.servers.pyright.enable = true;
  programs.nixvim.plugins.conform-nvim.settings.formatters_by_ft = {
    python = [
      "isort"
      "black"
    ];
  };

  catppuccin.flavor = "frappe";

  home.packages = [
    inputs.zen-browser.packages.${settings.system}.default
    inputs.ignis.packages.${settings.system}.ignis
    (pkgs.python3.withPackages (
      py: with py; [
        isort
        black
        jinja2
        pillow
      ]
    ))
  ];

  xdg.mimeApps =
    let
      defaultZen =
        list:
        lib.listToAttrs (
          lib.map (item: {
            name = item;
            value = "userapp-Zen Browser-0YQGZ2.desktop";
          }) list
        );
      mimes = defaultZen [
        "x-scheme-handler/http"
        "x-scheme-handler/https"
        "x-scheme-handler/chrome"
        "application/x-extension-htm"
        "application/x-extension-html"
        "application/x-extension-shtml"
        "application/xhtml+xml"
        "application/x-extension-xhtml"
        "application/x-extension-xht"
      ];
    in
    {
      enable = true;
      associations.added = mimes;
      defaultApplications = mimes;
    };

  home.sessionVariables = {
    EDITOR = "nvim";
    FLAKE = "$HOME/.config/nix";
  };

  minix.cursor.theme = "Bibata-Modern-Amber";

  wayland.windowManager.hyprland.enable = true;
  wayland.windowManager.hyprland.settings = {
    monitor = [
      "eDP-2, 2560x1440@165, 0x0, 1"
      # "HDMI-A-1, 3840x2160, 2560x0, 1"
    ];
  };
}
