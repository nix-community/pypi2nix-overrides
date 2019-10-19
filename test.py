#!/usr/bin/env python3

import json
from unittest import TestCase
from hashlib import sha256
import subprocess

with open('test_data.json') as handle:
    test_data_json = json.loads(handle.read())

# class ChecksumTest(TestCase):

for test_data in test_data_json:
    opname = test_data["filename"].replace(".csd", "")
    class ChecksumTest(TestCase):
        __name__ = opname + "TestCase"
        cli_options = ["--ksmps=1", "--sample-rate=44100", "--seed=1"]
        def test_expected_checksum(self):
            filename = test_data["filename"]
            expected_hashsum = test_data["expected"]
            # expected_hashsum = "266bbc5dea876d93a1246a584c5239863aede0c6ddeab2adb3d96d665ea8e271"
            rendered_file_path = opname + ".wav"
            subprocess.run(
                ["csound", filename, "-o", rendered_file_path] + self.cli_options,
                check=True
            )
            with open(rendered_file_path, "rb") as handle:
                binary_data = handle.read()

            hasher = sha256()
            hasher.update(binary_data)
            actual_hashsum = hasher.hexdigest()
            self.assertEqual(actual_hashsum, expected)

    setattr(__package__, opname + "TestCase", ChecksumTest)
