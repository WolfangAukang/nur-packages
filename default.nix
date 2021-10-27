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
  buttercup-desktop = pkgs.callPackage ./pkgs/buttercup-desktop { };
  freezer = pkgs.callPackage ./pkgs/freezer { };
  librewolf = pkgs.callPackage ./pkgs/librewolf { };
  markmind = pkgs.callPackage ./pkgs/markmind { };
  morgen = pkgs.callPackage ./pkgs/morgen { };
  pocket-casts = pkgs.callPackage ./pkgs/pocket-casts { };
  signumone-ks = pkgs.callPackage ./pkgs/signumone-ks { };
  ssm-session-manager-plugin = pkgs.callPackage ./pkgs/ssm-session-manager-plugin { };
  stremio = pkgs.callPackage ./pkgs/stremio { };
  thedesk = pkgs.callPackage ./pkgs/thedesk { };
  thiefmd = pkgs.callPackage ./pkgs/thiefmd { };
  threema-desktop = pkgs.callPackage ./pkgs/threema-desktop { };
  tutanota-desktop = pkgs.callPackage ./pkgs/tutanota-desktop { };
  upwork = pkgs.callPackage ./pkgs/upwork { };
  vdhcoapp = pkgs.callPackage ./pkgs/vdhcoapp { };
  whalebird = pkgs.callPackage ./pkgs/whalebird { };

}
