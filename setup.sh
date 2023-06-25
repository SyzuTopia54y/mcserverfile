#!/bin/bash

rm replit.sh

clear

read -p "Enter the server jar URL: " server_url

wget "$server_url" -O server.jar

echo -e "#By changing the setting below to TRUE you are indicating your agreement to our EULA (https://account.mojang.com/documents/minecraft_eula).\n#You also agree that tacos are tasty, and the best food in the world.\n#Wed Jun 21 18:57:44 GMT 2023" > eula.txt

echo "The Minecraft server End User License Agreement (EULA) states that by running the server, you agree to certain terms and conditions."

read -p "Do you agree with the Minecraft EULA? (yes/no): " eula_agreement

eula_agreement=$(echo "$eula_agreement" | tr '[:upper:]' '[:lower:]')

if [[ "$eula_agreement" == "yes" || "$eula_agreement" == "y" ]]; then
  echo "eula=true" >> eula.txt
  clear
  echo "You have agreed to the Minecraft EULA."
else
  echo "eula=false" >> eula.txt
  clear
  echo "You have not agreed to the Minecraft EULA. The server will not start until you agree."
fi

wait "$wget_pid"

if [[ $? -eq 0 ]]; then
  clear
  echo "Server.jar downloaded successfully."
else
  clear
  echo "Failed to download server.jar."
fi

echo -e "#Minecraft server properties\n#Sat Jun 24 15:29:12 GMT 2023\nenable-jmx-monitoring=false\nrcon.port=25575\nlevel-seed=\ngamemode=survival\nenable-command-block=\nenable-query=false\ngenerator-settings={}\nlevel-name=world\nmotd=\nquery.port=25565\npvp=true\ngenerate-structures=true\ndifficulty=\nnetwork-compression-threshold=256\nrequire-resource-pack=false\nmax-tick-time=60000\nuse-native-transport=true\nmax-players=\nonline-mode=\nenable-status=true\nallow-flight=false\nbroadcast-rcon-to-ops=true\nview-distance=10\nserver-ip=\nresource-pack-prompt=\nallow-nether=true\nserver-port=25565\nenable-rcon=false\nsync-chunk-writes=true\nserver-name=\nop-permission-level=4\nprevent-proxy-connections=false\nhide-online-players=true\nresource-pack=\nentity-broadcast-range-percentage=100\nsimulation-distance=10\nrcon.password=\nplayer-idle-timeout=0\ndebug=false\nforce-gamemode=false\nrate-limit=0\nhardcore=false\nwhite-list=false\nbroadcast-console-to-ops=true\nspawn-npcs=true\nspawn-animals=true\nfunction-permission-level=2\nlevel-type=default\ntext-filtering-config=\nspawn-monsters=true\nenforce-whitelist=false\nresource-pack-sha1=\nspawn-protection=16\nmax-world-size=29999984" > server.properties

clear

read -p "Enter the server name: " server_name

sed -i "s/^server-name=.*/server-name=$server_name/" server.properties

clear

read -p "Enter the server max ram: (512-1703) " ramkah

clear

read -p "Enter the server MOTD (default: A Minecraft Server): " server_motd
server_motd=${server_motd:-A Minecraft Server}

sed -i "s/^motd=.*/motd=$server_motd/" server.properties

clear

read -p "Enter the maximum number of players (default: 20): " max_players
max_players=${max_players:-20}

sed -i "s/^max-players=.*/max-players=$max_players/" server.properties

clear

echo "Online Mode Yes/On: Requires valid Mojang accounts to connect. Offers secure and official multiplayer experience."
echo 
echo "Online Mode No/Off: Allows players without Mojang accounts to join. Not recommended due to potential security risks and violation of Minecraft EULA."

read -p "Do you want to turn on or off the online-mode? (on/off): " onlinemodo

onlinemodo=$(echo "$onlinemodo" | tr '[:upper:]' '[:lower:]')

if [[ "$onlinemodo" == "on" ]]; then
  sed -i "s/^online-mode=.*/online-mode=true/" server.properties
  clear
  echo "Online-Mode Is active (Premium user only)"
else
  sed -i "s/^online-mode=.*/online-mode=false/" server.properties
  clear
  echo "Online-Mode Is not active (Crack User)"
fi

clear

read -p "Enter the server difficulty (peaceful, easy, normal, hard): " difficulty

sed -i "/s^difficulty=.*/difficulty=$difficulty/" server.properties

clear

read -p "Do you want to set the server to hardcore mode? (yes/no): " hardcoremodo

hardcoremodo=$(echo "$hardcoremodo" | tr '[:upper:]' '[:lower:]')

if [[ "$hardcoremodo" == "yes" || "$hardcoremodo" == "y" ]]; then
  sed -i "s/^hardcore=.*/hardcore=true/" server.properties
  clear
  echo "Hardcore Mode is activated becareful you only have 1 live"
else
  sed -i "s/^hardcore=.*/hardcore=false/" server.properties
  clear
  echo "Hardcore Mode is not activated. enjoy your survival."
fi

clear

echo "Command Block Enable: Enables the usage of command blocks in the game world. Can be used for creating custom game mechanics, structures, and more."
echo
echo "Command Block Disable: Disables the usage of command blocks in the game world. Players will not be able to interact with or activate command blocks."

read -p "Do you want to enable command-block? (yes/no): " cmbl

cmbl=$(echo "$cmbl" | tr '[:upper:]' '[:lower:]')

if [[ "$cmbl" == "yes" || "$cmbl" == "y" ]]; then
  sed -i "s/^enable-command-block=.*/enable-command-block=true/" server.properties
  clear
  echo "Command Block enabled."
else
  sed -i "s/^enable-command-block=.*/enable-command-block=false/" server.properties
  clear
  echo "Command Block disabled."
fi

clear

echo "Downloading WebPanel..."

mkdir plugins

wget "https://github.com/SyzuTopia54y/mcserverfile/raw/main/JPanel.jar" -P plugins -q

clear

echo "Becareful when setting this part, make sure the username and password is can you remember!!!!!!"

read -p "Username For Web Console: " usernamekh

read -p "Set password for $usernamekh: " -s passwordkh

echo "The login detail for the web console is saved"

echo -e "import hashlib\nimport binascii\nimport os\nimport sys\n\nif not os.path.exists(cache):\n    os.makedirs(cache)\n\nfile_path = \"cache/config.json\"\n\ndef generateStrongPasswordHash(password):\n    iterations = 1000\n    salt = getSalt()\n\n    dk = hashlib.pbkdf2_hmac('sha1', password.encode(), salt, iterations, dklen=64)\n    return str(iterations) + \":\" + toHex(salt) + \":\" + toHex(dk)\n\n\ndef validatePassword(passToCheck, storedPassword):\n    parts = storedPassword.split(\":\")\n    iterations = int(parts[0])\n    salt = fromHex(parts[1])\n    hash = fromHex(parts[2])\n\n    dk = hashlib.pbkdf2_hmac('sha1', passToCheck.encode(), salt, iterations, dklen=len(hash))\n\n    diff = len(hash) ^ len(dk)\n    for x, y in zip(hash, dk):\n        diff |= x ^ y\n    return diff == 0\n\n\ndef toHex(array):\n    hex_str = binascii.hexlify(array).decode().lower()\n    padding_length = (len(array) * 2) - len(hex_str)\n    if padding_length > 0:\n        return '0' * padding_length + hex_str\n    else:\n        return hex_str\n\n\ndef fromHex(hex_str):\n    return binascii.unhexlify(hex_str)\n\n\ndef getSalt():\n    return os.urandom(16)\n\nuser = sys.argv[1] if len(sys.argv) > 1 else \"\"\npassword = sys.argv[2] if len(sys.argv) > 2 else \"\"\n\nhashed_password = generateStrongPasswordHash(password)\n\nfolder_path = \"plugins/JPanel\"\nconfig_file = f\"{folder_path}/config.yml\"\n\nif not os.path.exists(folder_path):\n    os.makedirs(folder_path)\n\nconfig_content = f\"\"\"http-port: 4567\ndebug-mode: false\nuse-ssl: false\nkeystore-name: ''\nkeystore-password: ''\nusers:\n  {user}:\n    password: {hashed_password}\n    canEditFiles: true\n    canChangeGroups: true\n    canSendCommands: true\n\"\"\"\n\nwith open(config_file, \"w\") as f:\n    f.write(config_content)\n\n\n\n\n\ndata = {\n    \"user\": user,\n    \"pass\": password\n}\n\nwith open(file_path, \"w\") as file:\n    json.dump(data, file, indent=4)" > temp.py

python temp.py $usernamekh $passwordkh

rm temp.py

clear

read -p "Do you want to install ViaVersion? (yes/no): " install_viaversion

if [[ $install_viaversion == "yes" || $install_viaversion == "y" ]]; then

  echo "Downloading ViaVersion packages..."

  wget "https://github.com/SyzuTopia54y/mcserverfile/raw/main/ViaVersion.jar" -P plugins -q
  wget "https://github.com/SyzuTopia54y/mcserverfile/raw/main/ViaRewind.jar" -P plugins -q
  wget "https://github.com/SyzuTopia54y/mcserverfile/raw/main/ViaBackwards.jar" -P plugins -q

  echo "ViaVersion packages downloaded successfully."
fi

clear

echo "Downloading Packet Riot..."

wget "https://raw.githubusercontent.com/SyzuTopia54y/mcserverfile/main/packetriot" -O packetriot


wait "$packetriot_pid"

if [[ $? -eq 0 ]]; then
  echo "Packet Riot downloaded successfully."
else
  echo "Failed to download Packet Riot."
fi

chmod +x packetriot

clear

./packetriot configure

clear


clear

config_content=$(cat /home/runner/.pktriot/config.json)

echo "$config_content" > "packetriotconfig.json"

clear

./packetriot tcp allocate >/dev/null 2>&1 &

# Store the PID of the program
program_pid=$!

# Sleep for 2 seconds
sleep 2

# Terminate the program using its PID
kill $program_pid

clear

rm main.py

wget "https://github.com/SyzuTopia54y/mcserverfile/raw/main/main.py"

clear

echo -e "{
  \"Server_jar\": \"server.jar\",
  \"packetriot_config\": \"packetriotconfig.json\",
  \"Server_ram\": \"$ramkh\"
}" > config.json

serverHost=$(jq -r '.serverHost' file.json)
port=$(jq -r '.ports[0].port' file.json)

ip=$(dig +short "$serverHost")

clear

echo "The setup for server\nName: $server_name\nIngame-IP: $ip\nIngame-Port: $port\nJoin-server-using: $ip:$port\nMax-Ram: $ramkah"

rm setup.sh
