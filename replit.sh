#!/bin/bash

clear

echo "Downloading Setup.sh"

wget "https://raw.githubusercontent.com/SyzuTopia54y/mcserverfile/main/setup.sh" -O setup.sh

echo "configuring replit.nix"

rm replit.nix

echo -e '{
  "pkgs": {
    "deps": [
      "pkgs.nano",
      "pkgs.taskwarrior",
      "pkgs.systemd",
      "pkgs.unzip",
      "pkgs.bind.dnsutils",
      "pkgs.wget",
      "pkgs.mc",
      "pkgs.jq.bin",
      "pkgs.screen",
      "pkgs.graalvm17-ce",
      "pkgs.python310Full",
      "pkgs.replitPackages.prybar-python310",
      "pkgs.replitPackages.stderred"
    ],
    "env": {
      "PYTHON_LD_LIBRARY_PATH": [
        "${pkgs.lib.makeLibraryPath}",
        "${pkgs.stdenv.cc.cc.lib}",
        "${pkgs.zlib}",
        "${pkgs.glib}",
        "${pkgs.xorg.libX11}"
      ],
      "PYTHONHOME": "${pkgs.python310Full}",
      "PYTHONBIN": "${pkgs.python310Full}/bin/python3.10",
      "LANG": "en_US.UTF-8",
      "STDERREDBIN": "${pkgs.replitPackages.stderred}/bin/stderred",
      "PRYBAR_PYTHON_BIN": "${pkgs.replitPackages.prybar-python310}/bin/prybar-python310"
    }
  }
}' > replit.nix

bash setup.sh
