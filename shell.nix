{ nixpkgs ? import <nixpkgs> {} }:
let
  pythonPackages = import nix/requirements.nix { pkgs = nixpkgs; };
in

nixpkgs.stdenv.mkDerivation {
  name = "dev-env";
  buildInputs = [ pythonPackages.interpreter ];
}
