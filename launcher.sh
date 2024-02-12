#!/bin/bash

#NOTES
#  Really need to switch to a different scripting language or rewrite in switch-case.
#  Only using Bash because it's understood by everything able to run this Docker image.
#  Bash script is just really, really bad and really, really hard to understand from a glance.

#  Just need to check if any of the variables I set are changed by user and avoid changing what they set.

#Grab the 100% neccessary variables.
gamevar=$(printenv GAME)
listenip=$(printenv LISTENINGIP)
address=$(printenv ADDRESS)

envs=$(printenv)
echo "$envs"

#Resort to duplication in case of missing variable.
#Wrote this all out, didn't realize the Dockerfile already sets these.. Oops? I'll figure which I'm gonna remove.
if [[ $address == "" && $listenip != "" ]]; then
  echo "Address wasn't found. Defaulting to LISTENINGIP."
  export ADDRESS=$listenip
elif [[ $listenip == "" && $address != "" ]]; then
  echo "Listening IP wasn't found. Defaulting to ADDRESS"
  export LISTENINGIP=$address
#How do you manage to forget to set both IPs?
elif [[ $listenip == "" && $address == "" ]]; then
  echo "No IP variables set. Defaulting to localhost."
  export LISTENINGIP="localhost"
  export ADDRESS="localhost"
fi

#Figure out which console the server will be for.
if [[ $gamevar == *"PS3"* ]]; then
  echo "Using PS3 server defaults."
  export USERPASSWORD="PS3NPDummyPwd"
elif [[ $gamevar == *"WII"* ]]; then
  echo "Using Wii server defaults."
  export USERPASSWORD="1234567890123456"
elif [[ $gamevar == *"X360"* ]]; then
  echo "Using Xbox 360 server defaults"
  export USERPASSWORD="LSP PASSWORD"
fi

#Xbox 360 Servers.
if [[ $gamevar == "RB3:X360" ]]; then
  echo "Launching as Rock Band 3 Xbox 360 server."
  export ACCESSKEY="d52d1e000328fbc724fde65006b88b56" export SECUREPORT="7021" export AUTHPORT="7020" 
fi

#Wii Servers.
if [[ $gamevar == "RB3:WII" ]]; then
  echo "Launching as Rock Band 3 Wii server."
  export ACCESSKEY="e97dc2ce9904698f84cae429a41b328a" export SECUREPORT="18011" export AUTHPORT="18010" 
elif [[ $gamevar == "RB2:WII" ]]; then 
  echo "Launching as Rock Band 2 Wii server."
  export ACCESSKEY="Hc5sWq8x" export SECUREPORT="30846" export AUTHPORT="30845" 
fi

#PS3 Servers.
if [[ $gamevar == "RB3:PS3" ]]; then
  echo "Launching as Rock Band 3 PS3 server."
  export ACCESSKEY="bfa620c57c2d3bcdf4362a6fa6418e58" export SECUREPORT="16016" export AUTHPORT="16015" 
elif [[ $gamevar == "RB2:PS3" ]]; then 
  echo "Launching as Rock Band 2 PS3 server.\nWarning: Attempts to launch GoCentral as a Rock Band 2 PS3 server have failed in testing. This may not work for you!"
  export ACCESSKEY="Ey6Ma18" export SECUREPORT="30826" export AUTHPORT="30825" 
elif [[ $gamevar == "BRB:PS3" ]]; then 
  echo "Launching as The Beatles: Rock Band PS3 server."
  export ACCESSKEY="88808fd91016c8f2ce3670ca1216a113" export SECUREPORT="16006" export AUTHPORT="16005" 
elif [[ $gamevar == "GDRB:PS3" ]]; then 
  echo "Launching as Green Day Rock Band PS3 server."
  export ACCESSKEY="bf99796d6674ef63697f453296d7934c" export SECUREPORT="16011" export AUTHPORT="16010" 
fi

#Guess if I'm checking for ADDRESS and LISTENINGIP being blank, I'll check the GAME variable?
#GoCentral already has checks for these variables not being found, but I can "crash" based upon them to make sure container is properly configured.
if [[ $gamevar == "" ]]; then
  echo "No game provided. Refusing to start server."
  exit 0
else
  go run .
fi
