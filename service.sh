#!/system/bin/sh
[ ! "$MODDIR" ] && MODDIR=${0%/*}
while [[ "$(getprop sys.boot_completed)" -ne 1 ]] && [[ ! -d "/sdcard" ]];do sleep 1; done
while [[ `getprop sys.boot_completed` -ne 1 ]];do sleep 1; done
sdcard_rw() {
until [[ $(getprop sys.boot_completed) -eq 1 || $(getprop dev.bootcomplete) -eq 1 ]]; do sleep 1; done
}
sdcard_rw
MODPATH="/data/adb/modules/logs"
[[ ! -e ${MODDIR}/scripts/ll/log ]] && mkdir -p ${MODDIR}/scripts/ll/log
km1() {
	echo -e "$@" >>优化.log
	echo -e "$@"
}
km2() {
	echo -e "❗️ $@" >>优化.log
	echo -e "❗️ $@"
}
if [[ -d ${MODDIR}/scripts ]]; then
  for i in $(ls ${MODDIR}/scripts/*); do
    if [ -f "${i}" ]; then
    chmod 0777 "${i}"
    su -c nohup "${i}" >/dev/null 2>&1 &
	fi
  done
fi
function log() {
    logfile="1000000"
    maxsize="1000000"
    if [ "$(stat -c %s "${MODDIR}/ll/log/优化.log")" -eq "$maxsize" ] || [ "$(stat -c %s "${MODDIR}/ll/log/优化.log")" -gt "$maxsize" ]; then
        rm -f "${MODDIR}/ll/log/优化.log"
    fi
}
cd ${MODDIR}/scripts/ll/log
log
(while true;do su -c stop logd;sleep 10;done)>/dev/null 2>&1&