{
  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";
    devenv.url = "github:cachix/devenv";
    fenix = {
      url = "github:nix-community/fenix";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs =
    inputs@{ flake-parts, nixpkgs, ... }:
    flake-parts.lib.mkFlake { inherit inputs; } {
      imports = [ inputs.devenv.flakeModule ];
      systems = nixpkgs.lib.systems.flakeExposed;
      perSystem =
        {
          config,
          self',
          inputs',
          lib,
          pkgs,
          system,
          ...
        }:
        {
          packages = rec {
            BuildZigBin = pkgs.callPackage ./nix/zigBinBuilder.nix {};
            nh = BuildZigBin {
              name = "nh";
              version = "0.0.1";
              src = ./.;
              meta = with lib; {
                description = "A nh clone made in zig";
                homepage = "https://github.com/eveeifyeve/nh-zig";
                maintainers = [];
                license = licenses.bsd3;
              };
            };
          };
          devenv.shells.default = {
            dotenv.enable = false;
            languages.zig = {
              enable = true;
            };
            languages.javascript = {
              enable = true;
              package = pkgs.nodejs-18_x;
            };
          };
        };
    };
}
