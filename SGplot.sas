data testdata;
  infile datalines;
  input Product Date : date. Actual Predict;
  format Date monyy5.;
return;
datalines;
AAA 01JAN17 3723 3513 
AAA 01FEB17 2317 2664 
AAA 01MAR17 2799 3098 
AAA 01APR17 2286 1087 
AAA 01MAY17 3031 2033 
AAA 01JUN17 1955 1913
;
run; 

title; footnote;

proc sgplot data=testdata;  
series x=Date y=Actual/markers lineattrs=(color=red)
                     markerattrs=(color=red symbol=StarFilled);
series x=Date y=Predict / markers lineattrs=(color=blue)
                      markerattrs=(color=blue symbol=DiamondFilled);
format Date monyy5.;
xaxis discreteorder=data values=('01jan2017'd to '01jun2017'd by month);
run;