{
  pkgs,
  ...
}:
{
  home.packages = with pkgs; [
    duf
    curl
    wget
    wl-clipboard

    glow
    httpie
    just
    jq
    libqalculate
  ];

  programs.bat.enable = true;
  programs.btop.enable = true;
  programs.fuzzel = {
    enable = true;
    settings = {
      key-bindings = {
        cancel = "Control+c Escape";
        delete-prev-word = "Control+w";
      };
    };
  };
  programs.eza = {
    enable = true;
    icons = "auto";
    git = true;
    enableFishIntegration = true;
  };
  programs.zoxide = {
    enable = true;
    enableFishIntegration = true;
  };
  programs.git = {
    enable = true;
    delta = {
      enable = true;
      options = {
        side-by-side = true;
      };
    };
  };
  programs.gh.enable = true;
}
