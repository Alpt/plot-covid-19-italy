Plot covid 19 data with gnuplot per province, using Protezione Civile data


Usage
-----

./plot.sh [-vel|-log] province-name province-name ...

Example: ./plot.sh catania roma "Pesaro e Urbino"  
Example: ./plot.sh -vel catania roma  
Example: ./plot.sh -log catania roma  

 -vel grafica la velocita'  
 -log grafica in scala logaritmica

Warning
-------

From day 29, to day 31 of March the .csv format changed. It is possible that Protezione civile will do other updates in the future.
I do not guarantee that I will keep this software up-to-date!

Dependencies
------------

sudo apt-get install git gnuplot-qt

References
----------

https://github.com/pcm-dpc/COVID-19/tree/master/metadata 
