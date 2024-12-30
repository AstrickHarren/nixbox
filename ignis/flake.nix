{
  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";
    utils.url = "github:numtide/flake-utils";
  };

  outputs =
    {
      self,
      nixpkgs,
      utils,
    }:
    utils.lib.eachDefaultSystem (
      system:
      let
        pkgs = import nixpkgs { inherit system; };
        ignis = pkgs.stdenv.mkDerivation rec {
          name = "igins";
          pname = "Ignis";
          src = pkgs.fetchFromGitHub {
            owner = "linkfrg";
            repo = "ignis";
            rev = "main";
            sha256 = "zSWkckB2XDJuVbXrvyj/FGbI6AQwnbKRs6RV7y56jH0=";
          };

          installPhase = ''
            mkdir -p $out/lib/python3.12/site-packages
            cp -r $src/ignis $out/lib/python3.12/site-packages
          '';
        };
      in
      {
        devShell =
          with pkgs;
          mkShell {
            buildInputs = [
              ignis
              pkgs.glib
              pkgs.gtk4
              pkgs.gtk4-layer-shell
              pkgs.libpulseaudio
              pkgs.python312Packages.pygobject3
              pkgs.python312Packages.pycairo
              pkgs.python312Packages.click
              pkgs.python312Packages.charset-normalizer
              pkgs.python312Packages.requests
              pkgs.python312Packages.setuptools
              pkgs.python312Packages.loguru
              pkgs.gst_all_1.gstreamer
              pkgs.gst_all_1.gst-plugins-base
              pkgs.gst_all_1.gst-plugins-good
              pkgs.gst_all_1.gst-plugins-bad
              pkgs.gst_all_1.gst-plugins-ugly
              pkgs.pipewire
              pkgs.dart-sass
            ];
            PYTHONPATH = "${ignis}/lib/python3.12/site-packages";
            LD_LIBRARY_PATH = "${pkgs.gtk4-layer-shell}/lib";
            shellHook = ''
              exec fish
            '';
          };
      }
    );
}
