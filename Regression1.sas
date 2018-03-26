
data toluca;
  input LotSize WorkHrs;
cards;
   80  399
   30  121
   50  221
   90  376
   70  361
   60  224
  120  546
   80  352
  100  353
   50  157
   40  160
   70  252
   90  389
   20  113
  110  435
  100  420
   30  212
   50  268
   90  377
  110  421
   30  273
   90  468
   40  244
   80  342
   70  323
;
run;




/*We will start by making a scatter plot to see if we have a roughly linear relationship.   

We use proc gplot to  make our plots.  The first statements are telling how we want the plot to look.
There is only 1 x*y plot, so we only have 1 symbol (the symbol1 command).  Sometimes, we will need multiple
symbols, such as if we are plotting workhours by lotsize for both women and men and have two plots on the same graph. 
The v=circle says to make the data points circles and c is color.  There are other options such
as i= join tells SAS to connect the points with a line.

Within proc gplot, we use plot Y*X.  This creates a plot of Y by X.

symbol1 v=circle   c = black;
*/

PROC SGPLOT DATA=toluca;
scatter x=LotSize y=WorkHrs;
RUN;



/* 	

To run a regression model and get least square estimates, we can use proc reg.

The model command tells SAS we are going to enter the model equation.  It follows the form
model Y = X.  

If there are more than 1 predictor variables, we use model Y = X1 X2


The output includes the least squares estimates.  Note, since X1 is named LotSize, b1 will
be the parameter estimate that corresponds with LotSize
*/

proc reg data=toluca;
 model WorkHrs = LotSize ;
 run;

/*

To plot the regression fit.

We will rerun proc reg but this time we will output a file that contains the predicted value of work hours 
(the fitted value) for each lot size.  Then we will plot them on the same picture as the scatterplot.


The output statement in the reg porcedure tells SAS to output a data set, which we name following the out command.
Here, we named the output file "results".
In general,we use 

output out="name we choose".

The p command is where we tell SAS to inluce the predicted values of work hours 
 and we named them "predicted_WorkHrs".
In general it is p = "name we choose".
*/



proc reg data=toluca;
 model WorkHrs = LotSize ;
OUTPUT 	out=results p=predicted_WorkHrs;
 run;
quit;

/* Just to see what the output file we created looks like, we will print it using proc print*/

proc print data=results; run;




/* Here we plot both the data points, workhours by Lotsize, and the predicted points, predicted_WorkHrs
by LotSize.  We connect the points for the predicted workhours to make our regression line, 
thus we use i=join after symbol2.	 The overlay command tells SAS to put both plots in the same frame.
  / OVERLAY;


symbol1 v=circle l=32  c = black;
symbol2 i = join v=star l=32  c = black;
*/
PROC SGPLOT DATA=results;
scatter x=LotSize y=WorkHrs;
series x=LotSize y=predicted_WorkHrs;
RUN;





 






