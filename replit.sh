#!bin/bash

clear

wget "https://raw.githubusercontent.com/SyzuTopia54y/mcserverfile/main/setup.sh" -O setup.sh

rm replit.nix

echo -e "{ pkgs }: {\n  deps = [\n    pkgs.wget\n    pkgs.jq.bin\n    pkgs.graalvm17-ce\n    pkgs.bind.dnsutils\n    pkgs.taskwarrior\n    pkgs.python310Full\n    pkgs.replitPackages.prybar-python310\n    pkgs.replitPackages.stderred\n  ];\n  env = {\n    PYTHON_LD_LIBRARY_PATH = pkgs.lib.makeLibraryPath [\n      # Needed for pandas / numpy\n      pkgs.stdenv.cc.cc.lib\n      pkgs.zlib\n      # Needed for pygame\n      pkgs.glib\n      # Needed for matplotlib\n      pkgs.xorg.libX11\n    ];\n    PYTHONHOME = \"\${pkgs.python310Full}\";\n    PYTHONBIN = \"\${pkgs.python310Full}/bin/python3.10\";\n    LANG = \"en_US.UTF-8\";\n    STDERREDBIN = \"\${pkgs.replitPackages.stderred}/bin/stderred\";\n    PRYBAR_PYTHON_BIN = \"\${pkgs.replitPackages.prybar-python310}/bin/prybar-python310\";\n  };\n}" > replit.nix

clear

echo "Changing Replit.nix and Downloading setup.sh is done."
echo "To begin the instalation do : bash setup.sh !!!!!"
