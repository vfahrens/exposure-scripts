#!/bin/bash

while [ 1 ]; do
    d=`date +%Y%m%d`
    workdir=${HOME}/Data/foces/${d}

    if [ ! -d ${workdir} ]; then
	mkdir -p ${workdir}
	echo 1 > ${workdir}/.counter
    fi

    count=`cat ${workdir}/.counter`

    echo savefolder=${workdir} | nc 195.37.68.140 64901

    fname=`printf %s_%04d_FOC1700_FLA2.fits ${d} ${count}`

    echo `date +%Y%m%d:%H%M%S` `echo ccdtemp | nc 195.37.68.140 64901` >> ${workdir}/${d}.log
    echo `date +%Y%m%d:%H%M%S` `echo cooler | nc 195.37.68.140 64901` >> ${workdir}/${d}.log
    echo `date +%Y%m%d:%H%M%S` `echo tempstate | nc 195.37.68.140 64901` >> ${workdir}/${d}.log
    echo exptime=1.5 | nc 195.37.68.140 64901
    sleep 1
    echo expose=${fname} | nc 195.37.68.140 64901

    ((count++))
    echo $count > ${workdir}/.counter
    sleep 210
done




     
