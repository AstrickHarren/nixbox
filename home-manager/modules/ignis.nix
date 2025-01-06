{ inputs, ... }:
{
  xdg.configFile."ignis".source = "${inputs.ignis-config}";
}
