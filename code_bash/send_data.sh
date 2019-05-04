#!/bin/bash
path="/home/poney/script/projet_si/code_raspberry/log_users.txt"
data=()
#on récupére le fichier
for i in $(tr -d "\0" <$path ); do
  IFS='-' read -r -a array <<< "$i"
  #on split au -
  #on vérifie que ce soit uniquement un iud
  if [[ ${array[0]}=="1" ]]; then
    $(ssh -p 2222 root@79.137.34.17 "
cd /django/site_internet/
python3 -c '
import os
import sys
from django.core.management import execute_from_command_line
os.environ.setdefault(\"DJANGO_SETTINGS_MODULE\", \"chambre_froide.settings\")
sys.path.append(\"/django/site_internet/\")
import django
django.setup()
from site_web.models import Historique_users
Historique_users(iud=\"${array[1]}\").save()
    '")
  else
    $(ssh -p 2222 root@79.137.34.17 "
cd /django/site_internet/
python3 -c '
import os
import sys
from django.core.management import execute_from_command_line
os.environ.setdefault(\"DJANGO_SETTINGS_MODULE\", \"chambre_froide.settings\")
sys.path.append(\"/django/site_internet/\")
import django
django.setup()
from site_web.models import Chambre_froide
Chambre_froide(hydrometri=\"${array[n]}\",temperature=\"${array[n]}\",last_user=\"${array[n]}\",catalogue=\"${array[n]}\").save()
    '")
  fi

done
IFS=" "
