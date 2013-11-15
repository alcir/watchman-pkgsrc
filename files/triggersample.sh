#!/bin/bash

logfile=/tmp/triggersample.log

function log()
{
   if [ "$1" ]
   then
      data="$1"
      echo "[$(date +"%D %T")] $data">> $logfile
      if [[ $_V -eq 1 ]]; then
         #echo "[$(date +"%D %T")] $data"
         echo "$data"
      fi

   else
      while IFS='' read -r data
      do
         echo "[$(date +"%D %T")] $data" >> $logfile
         if [[ $_V -eq 1 ]]; then
            #echo "[$(date +"%D %T")] $data"
            echo "$data"
         fi
      done
   fi
}


log "`date`"
log "Amount of modified files: $#"

#rsync -avp -e "ssh -i /root/.ssh/id_rsa_rsync" /var/tmp/watchmantest/ 192.168.0.2:/var/tmp/watchmantest/ 2> >(log)
