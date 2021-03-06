#!/bin/bash
# Generate json output for salt around a2dismod managment
echo "{"

# Load apache envvars
. /etc/apache2/envvars
# Deactivate modules
/usr/sbin/a2dismod $@ 2>&1 |grep -v "already disabled"|grep -q "apache2 re"
if [[ "$?" = "0" ]]; then
  # Changes detected
  echo '"changed":"true",'
  echo '"comment":"Apache restart seems requested when removing modules : '$@'"'
  OUT=$(/usr/sbin/apache2 -t -D DUMP_MODULES 2>&1)
  echo ',"current_list":"'${OUT}'"'
else
  echo '"changed":"false",'
  echo '"comment":"Nothing to do to remove modules : '$@'"'
fi;
echo "}"
