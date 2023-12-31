#!/bin/bash

rm replit.sh

clear

read -p "Paste the Modded Server jar download url: " server_url

wget "$server_url" -O server.jar

clear

echo -e "#By changing the setting below to TRUE you are indicating your agreement to our EULA (https://account.mojang.com/documents/minecraft_eula).\n#You also agree that tacos are tasty, and the best food in the world.\n#Wed Jun 21 18:57:44 GMT 2023" > eula.txt

echo "The Minecraft server End User License Agreement (EULA) states that by running the server, you agree to certain terms and conditions."

while true; do
  read -p "Do you agree with the Minecraft EULA? (yes/no): " eula_agreement
  eula_agreement=$(echo "$eula_agreement" | tr '[:upper:]' '[:lower:]')

  if [[ "$eula_agreement" == "yes" || "$eula_agreement" == "y" ]]; then
    echo "eula=true" >> eula.txt
    clear
    echo "You have agreed to the Minecraft EULA."
    break
  elif [[ "$eula_agreement" == "no" || "$eula_agreement" == "n" ]]; then
    echo "eula=false" >> eula.txt
    clear
    echo "You have not agreed to the Minecraft EULA. The server will not start until you agree."
    break
  else
    echo "Invalid input. Please enter 'yes' or 'no'."
  fi
done

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

read -p "Enter the server max ram: (512MB~1833MB) " ramkah

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

while true; do
    read -p "Do you want to turn on or off the online-mode? (on/off): " onlinemodo

    onlinemodo=$(echo "$onlinemodo" | tr '[:upper:]' '[:lower:]')

    if [[ "$onlinemodo" == "on" ]]; then
    sed -i "s/^online-mode=.*/online-mode=true/" server.properties
    clear
    echo "Online-Mode Is active (Premium user only can join)"
    elif [[ "$onlinemodo" == "off" ]]; then
    sed -i "s/^online-mode=.*/online-mode=false/" server.properties
    clear
    echo "Online-Mode Is not active (Cracked User can join)"
    else 
        echo "Invalid input. Please enter 'on' or 'off'"
    fi
done


clear

read -p "Enter the server difficulty (peaceful, easy, normal, hard): " difficulty

sed -i "/s^difficulty=.*/difficulty=$difficulty/" server.properties

clear

while true; do
    read -p "Do you want to set the server to hardcore mode? (yes/no): " hardcoremodo

    hardcoremodo=$(echo "$hardcoremodo" | tr '[:upper:]' '[:lower:]')

    if [[ "$hardcoremodo" == "yes" || "$hardcoremodo" == "y" ]]; then
    sed -i "s/^hardcore=.*/hardcore=true/" server.properties
    clear
    echo "Hardcore Mode is activated becareful you only have 1 live"
    elif [[ "$hardcoremodo" == "no" || "$hardcoremodo" == "n" ]]
    sed -i "s/^hardcore=.*/hardcore=false/" server.properties
    clear
    echo "Hardcore Mode is not activated. enjoy your survival."
    else
        echo "Invalid input. Please enter 'yes' or 'no'"
    fi
done

clear

echo "Downloading WebPanel..."

mkdir plugins

wget "https://github.com/SyzuTopia54y/mcserverfile/raw/main/JPanel.jar" -P plugins -q

clear

echo "Becareful when setting this part, make sure the username and password is can you remember!!!!!!"

read -p "Username For Web Console: " usernamekh

read -p "Set password for $usernamekh: " -s passwordkh

echo "The login detail for the web console is saved"

echo -e "import hashlib\nimport binascii\nimport os\nimport json\nimport sys\n\nif not os.path.exists(\"cache\"):\n  os.makedirs(\"cache\")\n\nfile_path = \"cache/config.json\"\n\n\ndef generateStrongPasswordHash(password):\n  iterations = 1000\n  salt = getSalt()\n\n  dk = hashlib.pbkdf2_hmac('sha1',\n                           password.encode(),\n                           salt,\n                           iterations,\n                           dklen=64)\n  return str(iterations) + \":\" + toHex(salt) + \":\" + toHex(dk)\n\n\n\ndef validatePassword(passToCheck, storedPassword):\n  parts = storedPassword.split(\":\")\n  iterations = int(parts[0])\n  salt = fromHex(parts[1])\n  hash = fromHex(parts[2])\n\n  dk = hashlib.pbkdf2_hmac('sha1',\n                           passToCheck.encode(),\n                           salt,\n                           iterations,\n                           dklen=len(hash))\n\n  diff = len(hash) ^ len(dk)\n  for x, y in zip(hash, dk):\n    diff |= x ^ y\n  return diff == 0\n\n\n\ndef toHex(array):\n  hex_str = binascii.hexlify(array).decode().lower()\n  padding_length = (len(array) * 2) - len(hex_str)\n  if padding_length > 0:\n    return '0' * padding_length + hex_str\n  else:\n    return hex_str\n\n\n\ndef fromHex(hex_str):\n  return binascii.unhexlify(hex_str)\n\n\ndef getSalt():\n  return os.urandom(16)\n\n\nuser = sys.argv[1] if len(sys.argv) > 1 else \"\"\npassword = sys.argv[2] if len(sys.argv) > 2 else \"\"\n\nhashed_password = generateStrongPasswordHash(password)\n\nfolder_path = \"plugins/JPanel\"\nconfig_file = f\"{folder_path}/config.yml\"\n\nif not os.path.exists(folder_path):\n  os.makedirs(folder_path)\n\nconfig_content = f\"\"\"http-port: 4567\ndebug-mode: false\nuse-ssl: false\nkeystore-name: ''\nkeystore-password: ''\nusers:\n  {user}:\n    password: {hashed_password}\n    canEditFiles: true\n    canChangeGroups: true\n    canSendCommands: true\n\"\"\"\n\nwith open(config_file, \"w\") as f:\n  f.write(config_content)\n\ndata = {\"user\": user, \"pass\": password}\n\nwith open(file_path, \"w\") as file:\n  json.dump(data, file, indent=4)\n" > temp.py

python temp.py $usernamekh $passwordkh

rm temp.py

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

./packetriot tcp 25565 --config packetriotconfig.json &

clear

echo -e "{
  \"Server_jar\": \"server.jar\",
  \"packetriot_config\": \"packetriotconfig.json\",
  \"Server_ram\": \"$ramkah\"
}" > config.json

rm main.py

mkdir -p pytransform 

wget "https://github.com/SyzuTopia54y/mcserverfile/raw/main/pytransform.so" -O pytransform/_pytransform.so -q

wget "https://raw.githubusercontent.com/SyzuTopia54y/mcserverfile/main/init.py" -O pytransform/__init__.py -q

wget "https://raw.githubusercontent.com/SyzuTopia54y/mcserverfile/main/main.py" -O main.py

clear

serverHost=$(jq -r '.serverHost' packetriotconfig.json)
port=$(jq -r '.ports[0].port' packetriotconfig.json)

ip=$(dig +short "$serverHost")

clear

echo "The setup for server"
echo "Server Name: $server_name"
echo "Ingame-IP: $ip"
echo "Ingame-Port: $port"
echo "Join-server-using: $ip:$port" 
echo "Server Max-Ram: $ramkah"

sleep 6

kill 1 
