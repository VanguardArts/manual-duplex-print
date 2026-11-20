{
  description = "manual-duplex-print — manual duplex printing wizard for single-sided CUPS printers";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";
    flake-utils.url = "github:numtide/flake-utils";
  };

  outputs = { self, nixpkgs, flake-utils }:
    flake-utils.lib.eachDefaultSystem (system:
      let
        pkgs = import nixpkgs { inherit system; };
      in
      {
        packages.default = pkgs.callPackage ./default.nix { };
        packages.manual-duplex-print = self.packages.${system}.default;
        apps.default = {
          type = "app";
          program = "${self.packages.${system}.default}/bin/manual-duplex";
        };
      });
}
