# This file controls the pinned version of nixpkgs we use for our Nix environment
# as well as which versions of package we use, including their overrides.
{ config ? { } }:

let
  inherit (import <nixpkgs> { }) fetchFromGitHub;

  # For testing local version of nixpkgs
  #nixpkgsSrc = (import <nixpkgs> { }).lib.cleanSource "/home/jakubgs/work/nixpkgs";

  # We follow the master branch of official nixpkgs.
  nixpkgsSrc = fetchFromGitHub {
    name = "nixpkgs-source";
    owner = "status-im";
    repo = "nixpkgs";
    rev = "6098a069720f7e8f3913b3306b5b945b9cc08a29";
    sha256 = "sha256-xfSYnawDYwbtet0LjRj2HugsWAeuY3fZ3Q+fUCo3Otg=";
    # To get the compressed Nix sha256, use:
    # nix-prefetch-url --unpack https://github.com/${ORG}/nixpkgs/archive/${REV}.tar.gz
  };

  # Status specific configuration defaults
  defaultConfig = import ./config.nix;

  # Override some packages and utilities
  pkgsOverlay = import ./overlay.nix;
in
  # import nixpkgs with a config override
  (import nixpkgsSrc) {
    config = defaultConfig // config;
    overlays = [ pkgsOverlay ];
  }
