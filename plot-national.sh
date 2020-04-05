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
    echo "$0 [-vel|-log]"
    echo
    echo Example: $0 -vel
    echo Example: $0 -log
    echo 
    echo " -vel grafica la velocita'"
    echo " -log grafica in scala logaritmica"
}

cp plot.gp /tmp/plot-covid.gp

plotreplot="plot"
for p in "$@"; do

    if [ "$p" = "-vel" ]
    then
        velocity=1
        continue
    fi

    if [ "$p" = "-growth-rate" ]
    then
        growth_rate=1
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

if ((growth_rate)); then
    echo "plot 1 title \"linea di zero crescita\"" >> /tmp/plot-covid.gp
else
    echo "$plotreplot \"/tmp/plot-covid-$p.data\" using 1:12 with lines title \"$p\"" >> /tmp/plot-covid.gp
fi

plotreplot="replot"

if ((velocity)); then
  echo "$plotreplot \"/tmp/plot-covid-$p.data\" using 1:(d(\$12)) with lines title \"velocita' $p\"" >> /tmp/plot-covid.gp
fi
    
if ((growth_rate)); then
  echo "$plotreplot \"/tmp/plot-covid-$p.data\" using 1:(dr(\$12)) with lines title \"growth rate $p\"" >> /tmp/plot-covid.gp
fi

echo "pause -1" >> /tmp/plot-covid.gp

gnuplot /tmp/plot-covid.gp
