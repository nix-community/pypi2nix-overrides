What?
=====

This repository tries to collect "overrides" for the program
``pypi2nix``.

Why?
====

Unfortunately pypi2nix cannot detect all build and runtime dependency
by itself.  This means that users have to specify some dependencies by
hand, which greately reduces the user experience for alot of people.
This repository tries to remedy that by providing a single source of
tested and well known overrides.

How?
====

``pypi2nix`` will include this overrides by default.
