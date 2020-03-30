Plot covid 19 data with gnuplot per province, using Protezione Civile data


Usage
-----

./plot.sh [-vel|-log] province-name province-name ...

Example: ./plot.sh catania roma "Pesaro e Urbino"
Example: ./plot.sh -vel catania roma
Example: ./plot.sh -log catania roma

 -vel grafica la velocita'
 -log grafica in scala logaritmica


Dependencies
------------

sudo apt-get install git gnuplot-qt

References
----------

https://github.com/pcm-dpc/COVID-19/tree/master/metadata 
