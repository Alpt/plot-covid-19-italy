set datafile separator ','
set xdata time # tells gnuplot the x axis is time data
set timefmt "%Y-%m-%d %H:%M:%S" 
set format x "%d" # otherwise it will show only MM:SS
d(y) = ($0 == 0) ? (y1 = y, 1/0) : (y2 = y1, y1 = y, y1-y2)
dr(y) = ($0 == 0) ? (y2 = 0, y1 = y, 1/0) : (r=y1/y2, y2 = y1, y1 = y, r)
