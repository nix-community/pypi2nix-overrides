{ nixpkgs ? import <nixpkgs> {} }:
let
  pythonPackages = import nix/requirements.nix { pkgs = nixpkgs; };
in

nixpkgs.mkShell {
  name = "dev-env";
  buildInputs = [ pythonPackages.interpreter nixpkgs.nixfmt];
}
