#!/usr/bin/env sh

set -e

isort run_tests.py
black run_tests.py
