#!/bin/bash

clear

read -p "What Minecraft Server Version You want to create? " mcver

if [[ "$mcver" == "1.7.2" || "$mcver" == "1.7.4" || "$mcver" == "1.7.5" || "$mcver" == "1.7.6" || "$mcver" == "1.7.7" || "$mcver" == "1.7.8" || "$mcver" == "1.7.9" || "$mcver" == "1.7.10" || "$mcver" == "1.8" || "$mcver" == "1.8.1" || "$mcver" == "1.8.2" || "$mcver" == "1.8.3" || "$mcver" == "1.8.4" || "$mcver" == "1.8.5" || "$mcver" == "1.8.6" || "$mcver" == "1.8.7" || "$mcver" == "1.8.8" || "$mcver" == "1.8.9" || "$mcver" == "1.9" || "$mcver" == "1.9.1" || "$mcver" == "1.9.2" || "$mcver" == "1.9.3" || "$mcver" == "1.9.4" || "$mcver" == "1.10" || "$mcver" == "1.10.1" || "$mcver" == "1.10.2" || "$mcver" == "1.11" || "$mcver" == "1.11.1" || "$mcver" == "1.11.2" || "$mcver" == "1.12" || "$mcver" == "1.12.1" || "$mcver" == "1.12.2" ]]; then
  replit_nix_content="{ pkgs }: {\n  deps = [\n    pkgs.wget\n    pkgs.jq.bin\n    pkgs.zulu8\n    pkgs.bind.dnsutils\n    pkgs.taskwarrior\n    pkgs.python310Full\n    pkgs.replitPackages.prybar-python310\n    pkgs.replitPackages.stderred\n  ];\n  env = {\n    PYTHON_LD_LIBRARY_PATH = pkgs.lib.makeLibraryPath [\n      # Needed for pandas / numpy\n      pkgs.stdenv.cc.cc.lib\n      pkgs.zlib\n      # Needed for pygame\n      pkgs.glib\n      # Needed for matplotlib\n      pkgs.xorg.libX11\n    ];\n    PYTHONHOME = \"\${pkgs.python310Full}\";\n    PYTHONBIN = \"\${pkgs.python310Full}/bin/python3.10\";\n    LANG = \"en_US.UTF-8\";\n    STDERREDBIN = \"\${pkgs.replitPackages.stderred}/bin/stderred\";\n    PRYBAR_PYTHON_BIN = \"\${pkgs.replitPackages.prybar-python310}/bin/prybar-python310\";\n  };\n}"
elif [[ "$mcver" == "1.13" || "$mcver" == "1.13.1" || "$mcver" == "1.13.2" || "$mcver" == "1.14" || "$mcver" == "1.14.1" || "$mcver" == "1.14.2" || "$mcver" == "1.14.3" || "$mcver" == "1.14.4" || "$mcver" == "1.15" || "$mcver" == "1.15.1" || "$mcver" == "1.15.2" ]]; then
  replit_nix_content="{ pkgs }: {\n  deps = [\n    pkgs.wget\n    pkgs.jq.bin\n    pkgs.zulu8\n    pkgs.bind.dnsutils\n    pkgs.taskwarrior\n    pkgs.python310Full\n    pkgs.replitPackages.prybar-python310\n    pkgs.replitPackages.stderred\n  ];\n  env = {\n    PYTHON_LD_LIBRARY_PATH = pkgs.lib.makeLibraryPath [\n      # Needed for pandas / numpy\n      pkgs.stdenv.cc.cc.lib\n      pkgs.zlib\n      # Needed for pygame\n      pkgs.glib\n      # Needed for matplotlib\n      pkgs.xorg.libX11\n    ];\n    PYTHONHOME = \"\${pkgs.python310Full}\";\n    PYTHONBIN = \"\${pkgs.python310Full}/bin/python3.10\";\n    LANG = \"en_US.UTF-8\";\n    STDERREDBIN = \"\${pkgs.replitPackages.stderred}/bin/stderred\";\n    PRYBAR_PYTHON_BIN = \"\${pkgs.replitPackages.prybar-python310}/bin/prybar-python310\";\n  };\n}"
elif [[ "$mcver" == "1.16" || "$mcver" == "1.16.1" || "$mcver" == "1.16.2" || "$mcver" == "1.16.3" || "$mcver" == "1.16.4" || "$mcver" == "1.16.5" ]]; then
  replit_nix_content="{ pkgs }: {\n  deps = [\n    pkgs.wget\n    pkgs.jq.bin\n    pkgs.adoptopenjdk-openj9-bin-16\n    pkgs.bind.dnsutils\n    pkgs.taskwarrior\n    pkgs.python310Full\n    pkgs.replitPackages.prybar-python310\n    pkgs.replitPackages.stderred\n  ];\n  env = {\n    PYTHON_LD_LIBRARY_PATH = pkgs.lib.makeLibraryPath [\n      # Needed for pandas / numpy\n      pkgs.stdenv.cc.cc.lib\n      pkgs.zlib\n      # Needed for pygame\n      pkgs.glib\n      # Needed for matplotlib\n      pkgs.xorg.libX11\n    ];\n    PYTHONHOME = \"\${pkgs.python310Full}\";\n    PYTHONBIN = \"\${pkgs.python310Full}/bin/python3.10\";\n    LANG = \"en_US.UTF-8\";\n    STDERREDBIN = \"\${pkgs.replitPackages.stderred}/bin/stderred\";\n    PRYBAR_PYTHON_BIN = \"\${pkgs.replitPackages.prybar-python310}/bin/prybar-python310\";\n  };\n}"
elif [[ "$mcver" == "1.17" || "$mcver" == "1.17.1" || "$mcver" == "1.18" || "$mcver" == "1.18.1" || "$mcver" == "1.18.2" || "$mcver" == "1.19" || "$mcver" == "1.19.1" || "$mcver" == "1.19.2" || "$mcver" == "1.19.3" || "$mcver" == "1.19.4" || "$mcver" == "1.20" || "$mcver" == "1.20.1" ]]; then
  replit_nix_content="{ pkgs }: {\n  deps = [\n    pkgs.wget\n    pkgs.jq.bin\n    pkgs.graalvm17-ce\n    pkgs.bind.dnsutils\n    pkgs.taskwarrior\n    pkgs.python310Full\n    pkgs.replitPackages.prybar-python310\n    pkgs.replitPackages.stderred\n  ];\n  env = {\n    PYTHON_LD_LIBRARY_PATH = pkgs.lib.makeLibraryPath [\n      # Needed for pandas / numpy\n      pkgs.stdenv.cc.cc.lib\n      pkgs.zlib\n      # Needed for pygame\n      pkgs.glib\n      # Needed for matplotlib\n      pkgs.xorg.libX11\n    ];\n    PYTHONHOME = \"\${pkgs.python310Full}\";\n    PYTHONBIN = \"\${pkgs.python310Full}/bin/python3.10\";\n    LANG = \"en_US.UTF-8\";\n    STDERREDBIN = \"\${pkgs.replitPackages.stderred}/bin/stderred\";\n    PRYBAR_PYTHON_BIN = \"\${pkgs.replitPackages.prybar-python310}/bin/prybar-python310\";\n  };\n}"
else
  echo "Invalid Minecraft version input. Please enter a valid version."
  exit 1
fi

wget "https://raw.githubusercontent.com/SyzuTopia54y/mcserverfile/main/setup.sh" -O setup.sh

rm replit.nix

echo -e "$replit_nix_content" > replit.nix

clear

echo "Changing Replit.nix and Downloading setup.sh is done."
echo "To begin the installation do: bash setup.sh !!!!!"
