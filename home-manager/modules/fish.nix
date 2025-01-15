{
  pkgs,
  ...
}:

{
  config = {
    programs.fish = {
      functions = {
        fish_greeting = {
          body = "";
        };
      };
      interactiveShellInit = ''
        set -x hydro_color_pwd "$fish_color_cwd";
        set -x hydro_color_git "$fish_color_comment";
        set -x hydro_color_prompt "$fish_color_comment";
        set -x hydro_color_duration "$fish_color_user";
      '';
      plugins = [
        {
          name = "hydro";
          src = pkgs.fishPlugins.hydro.src;
        }
      ];
    };

    programs.bash = {
      enable = true;
      bashrcExtra = ''
        if [[ $(${pkgs.procps}/bin/ps --no-header --pid=$PPID --format=comm) != "fish" && -z ''${BASH_EXECUTION_STRING} ]]
        then
          shopt -q login_shell && LOGIN_OPTION='--login' || LOGIN_OPTION=""
          exec ${pkgs.fish}/bin/fish $LOGIN_OPTION
        fi
      '';
    };

  };
}
