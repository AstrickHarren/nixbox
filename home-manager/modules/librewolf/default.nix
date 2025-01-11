{
  config,
  lib,
  pkgs,
  ...
}:
{
  options = {
    programs.librewolf.homepage = lib.mkOption { default = "https://duckduckgo.com"; };
  };

  config = {
    programs.librewolf = {
      profiles.default = {
        extensions = with pkgs.nur.repos.rycee.firefox-addons; [
          sidebery
          clearurls
        ];
        settings = {
          "browser.startup.homepage" = config.programs.librewolf.homepage;
          "extensions.autoDisableScopes" = 0;

          # customize style sheet
          "toolkit.legacyUserProfileCustomizations.stylesheets" = true;
          "layers.acceleration.force-enabled" = true;
          "gfx.webrender.all" = true;
          "svg.context-properties.content.enabled" = true;
        };
      };
    };
  };
}
