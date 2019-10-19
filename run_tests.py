#!/usr/bin/env python

import argparse
import os.path
import subprocess


def parse_arguments():
    parser = argparse.ArgumentParser()
    parser.add_argument(
        "--build-only",
        help="Only build nix expression, don't update requirements.nix",
        action="store_true",
        default=False,
    )
    parser.add_argument(
        '--package-set',
        help='A specific package set to build, e.g. flake8',
        type=str,
        default=None
    )

    return parser.parse_args()


class Test:
    def __init__(self, directory_name):
        self._directory_name = directory_name
        self._setup_requirements = []

    def run(self):
        self._read_setup_requirements()
        self._generate_requirements()
        self.build_from_nix_expression()

    def _read_setup_requirements(self):
        self._setup_requirements = []
        setup_requirements_file = os.path.join(
            self._directory_name, "setup_requirements.txt"
        )
        if not os.path.isfile(setup_requirements_file):
            return
        with open(setup_requirements_file) as handle:
            for line in map(lambda l: l.strip(), handle.readlines()):
                if line:
                    self._setup_requirements.append("-s")
                    self._setup_requirements.append(line)

    def _generate_requirements(self):
        subprocess.run(
            ["pypi2nix", "-r", "requirements.txt", "-O", "../overrides.nix"]
            + self._setup_requirements,
            check=True,
            cwd=self._directory_name,
        )

    def build_from_nix_expression(self):
        subprocess.run(
            ["nix", "build", "-f", "requirements.nix"],
            check=True,
            cwd=self._directory_name,
        )


def main():
    args = parse_arguments()
    if args.package_set:
        tests = [args.package_set]
    else:
        tests = ["flake8", "pytest"]

    for test in tests:
        test = Test(test)
        if args.build_only:
            test.build_from_nix_expression()
        else:
            test.run()


if __name__ == "__main__":
    main()
