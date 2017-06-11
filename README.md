# Homebrew MiKTeX

Homebrew formula for MiKTeX.

## Installation

The MiKTeX formula is not (yet) a part of the core Homebrew.  So you
have to register the MiKTeX tap first:

    brew tap miktex/miktex

To install MiKTeX, run:

    brew install miktex

This installs a bare minimum MiKTeX, i.e., only executable files and
man pages.

From time to time you should run

    brew update
    brew outdated miktex || brew upgrade miktex

This will update the MiKTeX executables, if there is a newer version
available.

## Installing packages

MiKTeX is pre-configured to install missing files on-the-fly.  If you intend to work offline, you should run

    mpm --admin --package-level=basic --upgrade
