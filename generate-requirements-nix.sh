#!/usr/bin/env sh

cd nix && pypi2nix -r ../requirements.txt -O ../overrides.nix
