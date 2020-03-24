#!/bin/bash

if [ ! -d COVID-19 ]; then
    echo cloning repository
    git clone https://github.com/pcm-dpc/COVID-19 > /dev/null
else
    echo updating repository
    (cd COVID-19
    git pull > /dev/null)
    echo
fi

usage() {
    echo $0 province-name province-name ...
    echo Example: $0 catania roma \"Pesaro e Urbino\"
    echo
    echo Available provinces: $(cat COVID-19/dati-province/dpc-covid19-ita-province.csv  | cut -d , -f 6 | sort -u)
}

province=$1

if [ -z $province ];then
    usage
    exit 1
fi

cp plot.gp /tmp/plot-covid.gp

first=0
for p in "$@"; do
    
    grep ",$p," -i COVID-19/dati-province/*-[0-9]*.csv | tail -n 1 # show latest record

    grep ",$p," -i COVID-19/dati-province/*-[0-9]*.csv | cut -d : -f 2-  > "/tmp/plot-covid-$p.data"
    
    plotreplot="plot"
    if ((first > 0)); then
        plotreplot="replot"
    fi
    ((first++))

    echo "$plotreplot \"/tmp/plot-covid-$p.data\" using 1:10 with lines" >> /tmp/plot-covid.gp
    
done

echo "pause -1" >> /tmp/plot-covid.gp

gnuplot /tmp/plot-covid.gp
