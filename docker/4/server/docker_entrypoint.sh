#!/bin/sh
host=$(hostname)
force=true
backup_server=false
verbose=false
rerun=false
check=false

#==========================================================================
# Syntax
# docker_entrypoint.sh [-b] [-d ecf_home_directory] [-f] [-h] [-p port_number ]
#==========================================================================
# get command line options if any.
while getopts chfbd:r option
do
case ${option} in
c)
check=true
;;
f)
force=true
;;
b)
backup_server=true
;;
d)
ecf_home_directory=$OPTARG
;;
r)
rerun=true
;;
h)
echo "Usage: $0 [-b] [-d ecf_home directory] [-f] [-h]"
echo "       -b        start ECF for backup server or e-suite"
echo "       -d <dir>  specify the ECF_HOME directory - default $HOME/ecflow_server"
echo "       -f        forces the ECF to be restarted"
echo "       -h        print this help page"
exit 0
;;
*)
echo "Usage: $0 [-b] [-d ecf_home directory] [-f] [-h]"
echo "       -b        start ECF for backup server or e-suite"
echo "       -d <dir>  specify the ECF_HOME directory - default $HOME/ecflow_server"
echo "       -f        forces the ECF to be restarted"
echo "       -h        print this help page"
exit 1
;;
esac
done

#---------------------
# ECF_PORT
export ECF_PORT=3141

#===============================================================================
# Setup ECF_HOME

export ECF_HOME=/srv/ecflow_server
export ECF_LISTS=${ECF_LISTS:-${ECF_HOME}/ecf.lists}

date -u

# ======================================================================================
# set up default environment variables
#
export ECF_HOST=${host}
export ECF_LOG=${ECF_HOST}.${ECF_PORT}.ecf.log
export ECF_CHECK=${ECF_HOST}.${ECF_PORT}.check
export ECF_CHECKOLD=${ECF_HOST}.${ECF_PORT}.check.b

echo
echo User \"${username}\" attempting to start ecf server on \"$ECF_HOST\" using ECF_PORT \"$ECF_PORT\" and with:
echo "ECF_HOME     : \"$ECF_HOME\""
echo "ECF_LOG      : \"$ECF_LOG\""
echo "ECF_CHECK    : \"$ECF_CHECK\""
echo "ECF_CHECKOLD : \"$ECF_CHECKOLD\""
echo

#==========================================================================

echo "client version is $(ecflow_client --version)"
echo "Checking if the server is already running on $ECF_HOST and port $ECF_PORT"
ecflow_client --ping
if [ $? -eq 0 ]; then
  echo "... The server on $ECF_HOST:$ECF_PORT is already running. Use 'netstat -lnptu' for listing active port"
  exit 1
fi

#==========================================================================
#
echo "";
echo Backing up check point and log files

if [ ! -d $ECF_HOME ] ;then
  mkdir $ECF_HOME
fi
cd $ECF_HOME

if [ ! -d log ] ;then
  mkdir log
fi

set +e

cp $ECF_CHECK    log/ 2>/dev/null
cp $ECF_CHECKOLD log/ 2>/dev/null
if [ -f $ECF_LOG ]; then
    STAMP=$(date +%Y%m%d.%H%M)
    SIZE=$(du -Hm $ECF_LOG | awk '{print $1}') || SIZE=0
    if [ $SIZE -gt 100 ]; then
	     echo "Moving, compressing logfile ${SIZE}mb ${ECF_LOG}.${STAMP}.log"
	     mv $ECF_LOG log/${ECF_LOG}.${STAMP}.log 2>/dev/null
	     # gzip -f log/${ECF_LOG}.${STAMP}.log 2>/dev/null
    fi
fi
cp $ECF_LOG log/ 2>/dev/null  # allow logfile append in case of multiple restart

if [ -f $ECF_HOST.$ECF_PORT.ecf.out ]; then
   cp $ECF_HOST.$ECF_PORT.ecf.out log/ 2>/dev/null
fi

set -e

echo "";
echo "OK starting ecFlow server..."
echo "";

if [ "x${check}" = "xtrue" ]; then
  ecflow_client --load ${ECF_CHECK} check_only
fi

ecflow_server < /dev/null
