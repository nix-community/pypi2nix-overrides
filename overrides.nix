{ pkgs, python }:

with pkgs.lib;
with builtins;

self: super:

let
  processOverrides = name: value: nameValuePair name value;
  filterValid =
    overrides:
    filterAttrs (name: value: hasAttr name super) overrides;
  makeOverrides =
    overrides:
    mapAttrs' processOverrides (filterValid overrides);
in

makeOverrides {
  "mccabe" = super."mccabe".overrideDerivation (old: {
    buildInputs = old.buildInputs ++ [ self."pytest-runner" ];
  });

  "py" = super."py".overrideDerivation (old: {
    buildInputs = old.buildInputs ++ [ self."setuptools-scm" ];
  });

  "pytest-django" = super."pytest-django".overrideDerivation (old: {
    buildInputs = old.buildInputs ++ [ self."setuptools-scm" ];
  });
}
