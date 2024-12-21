{
  catppuccin.enable = true;
  catppuccin.flavor = "mocha";
  programs.nixvim = {
    colorschemes.catppuccin = {
      enable = true;
      settings.flavor = "mocha";
    };
  };
}
