# This file describes your repository contents.
# It should return a set of nix derivations
# and optionally the special attributes `lib`, `modules` and `overlays`.
# It should NOT import <nixpkgs>. Instead, you should take pkgs as an argument.
# Having pkgs default to <nixpkgs> is fine though, and it lets you use short
# commands such as:
#     nix-build -A mypackage

{ pkgs ? import <nixpkgs> { } }:

{
  # The `lib`, `modules`, and `overlay` names are special
  lib = import ./lib { inherit pkgs; }; # functions
  modules = import ./modules; # NixOS modules
  overlays = import ./overlays; # nixpkgs overlays

  binance = pkgs.callPackage ./pkgs/binance { };
  freezer = pkgs.callPackage ./pkgs/freezer { };
  signumone-ks = pkgs.callPackage ./pkgs/signumone-ks { };
  ssm-session-manager-plugin = pkgs.callPackage ./pkgs/ssm-session-manager-plugin { };
  stremio = pkgs.callPackage ./pkgs/stremio { };
  tutanota-desktop = pkgs.callPackage ./pkgs/tutanota-desktop { };
  upwork = pkgs.callPackage ./pkgs/upwork { };
  vdhcoapp = pkgs.callPackage ./pkgs/vdhcoapp { };

}
