

/* There is a trick to creating a datafile directly into SAS for these types of analyses.
Consider our example were subjects took either rogaine or a placebo and we recorded if they went bald or not.
Normally, we would enter our data as 

subject    trt              bald
1          rogaine         yes
2          rogaine         yes
3          rogaine         no
..
10         placebo         no

We will instead use a variable to keep track of the counts or numbers per cell.
When we create our data, we will use a count (or whatever we choose to name it) variable.  
This variable indexes the frequency of occurrences for this cell (count).  


For every cell, such as people on placebo who went bald, we then give the counts.
For example, there were 15 subjects on placebo who went bald. 
Thus we enter 
placebo  bald  15
*/




data chi; input trt$ bald$  count;
cards;
placebo bald 15
rogaine bald 5
placebo notbald 23
rogaine notbald 17
;
run;


/* We use proc freq to get frequency counts and tables.  
The weight command tells sas which variable in our data set is the number of subjects 
per cell.  

The command �tables bald*trt� tells SAS to produce a contingency table with the trt
variable as the row variable and the bald variable as the column variable. 

*/
proc freq data=chi;
   weight count;
   tables trt*bald ;
   run;
/*
By adding 
the �/chisq�, SAS then produces a chi-squared test of independence as well as 
other tests.
 

*/

proc freq data=chi;
   weight count;
   tables trt*bald / chisq;
   run;

/* In order to run a chi-square test of independence, you must have an expected cell count of at least 5 in each cell.
We can check our assumptions. By  including the "expected" after the backslash, the expected frequencies are included.
The "nopercent", etc say to not include those values.
*/



   proc freq data=chi;
   weight count;
   tables trt*bald / expected nopercent nocol norow;
   run;
   
data good; input size$  count;
cards;
large 50
medium 110
small 40
;
run;
