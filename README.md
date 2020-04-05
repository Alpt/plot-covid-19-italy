Plot covid 19 data with gnuplot per province, using Protezione Civile data


Usage
-----

./plot.sh [-growth-rate|-vel|-log] province-name province-name ...

Example: ./plot.sh catania roma "Pesaro e Urbino"  
Example: ./plot.sh -growth-rate catania roma  
Example: ./plot.sh -vel catania roma  
Example: ./plot.sh -log catania roma  

 -growth-rate grafica il growth rate, vedi http://katolaz.net/covid-2019/growth.html E' una misura statistica importante  
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
http://katolaz.net/covid-2019/growth.html
