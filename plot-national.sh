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
    echo "$0 [-vel|-log] province-name province-name ..."
    echo
    echo Example: $0 catania roma \"Pesaro e Urbino\"
    echo Example: $0 -vel catania roma
    echo Example: $0 -log catania roma
    echo 
    echo " -vel grafica la velocita'"
    echo " -log grafica in scala logaritmica"
    echo
    echo Available provinces: $(cat COVID-19/dati-province/dpc-covid19-ita-province.csv  | cut -d , -f 6 | sort -u)
}

cp plot.gp /tmp/plot-covid.gp

plotreplot="plot"
for p in "$@"; do

    if [ "$p" = "-vel" ]
    then
        velocity=1
        continue
    fi

    if [ "$p" = "-log" ]
    then
        echo set log y >> /tmp/plot-covid.gp
        continue
    fi
done
   
p=italia

cat COVID-19/dati-andamento-nazionale/dpc-covid19-ita-andamento-nazionale*-[0-9]*.csv | tail -n 1 # show latest record

cat COVID-19/dati-andamento-nazionale/dpc-covid19-ita-andamento-nazionale*-[0-9]*.csv | grep -v totale_casi > "/tmp/plot-covid-$p.data"

echo "$plotreplot \"/tmp/plot-covid-$p.data\" using 1:11 with lines title \"$p\"" >> /tmp/plot-covid.gp

plotreplot="replot"

if ((velocity)); then
  echo "$plotreplot \"/tmp/plot-covid-$p.data\" using 1:(d(\$11)) with lines title \"velocita' $p\"" >> /tmp/plot-covid.gp
fi
    

echo "pause -1" >> /tmp/plot-covid.gp

gnuplot /tmp/plot-covid.gp