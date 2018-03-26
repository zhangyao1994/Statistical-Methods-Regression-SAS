/*
We will use the same data as the R paired t test example.
We wish to compare weight loss on a treatment to weight loss on a control.  
We have 6 subjects.  3 subjects were randomly assigned to take the treatment for a month
and 3 were randomly assigned to take a control for a month.  At the end of the month, 
we recorded their weight loss.  Then the subjects waited a month and the three subjects 
who had taken the treatment took the control for a month and the three subjects who had 
taken the control took the treatment for a month.   At the end of the month, we recorded
their weight loss.

Thus each patient has their weight loss measured after a month of being on the treatment
and after a month of being on a control (with a month in between of no treatment).


*/




data example2; input  subj$ treatment$ weightloss;
cards;
1 drug 4.3
2 drug 4.8
3 drug 5.5
4 drug 5.8
5 drug 5.9
6 drug 5
1 control 4.1
2 control 4.4
3 control 4.8
4 control 4
5 control 5.1
6 control 4.8
;
run;

/* First, we treat them as independent samples*/
proc ttest data=example2;
class treatment;
var weightloss;
 run;



 /* Now we create a dataset with just the differences.  */


data example2b; input  subj$ diff;
cards;
 1 0.2 
2 0.4
3 0.7 
4 1.8 
5 0.8 
6 0.2
;
run;

/*

To do the paired (dependent)
 ttest, we can do a one sample test on the differences.  Here we need to specify what
 the null is.  The null is that the mean of the differences is 0.   We do this in the first line by adding
h0=0 .  Note, we do not need a class command because we are not distinguishing between
the two treatment levels.  Just testing if the mean difference is 0.*/


proc ttest data=example2b h0=0;
var diff;
 run;

/*
 To run a paired (dependent) ttest directly in SAS, we need to reformat the data. 
 We write it such that, for each subject, we list the measurement (weightloss) 
 for each treatment type.  So each row corresponds to one subject's pair of measurements, weightloss 
 on drug and weightloss on control.

*/

data example3; input subj$ drug control;
cards;
1 4.3 4.1
2 4.8 4.4
3 5.5 4.8
4 5.8 4
5 5.9  5.1
6 5 4.8
 
;
run;


/* To run the paired (dependent) ttest, we again use proc ttest.  Now we list the 
variables that are paired after the PAIRED command, putting a "*" between them.  
Here drug is paired with control. Maybe we could have, for each subject, 
a pre and post measurement.  Then the pre and post measurements would be paired and 
we would put: PAIRED pre*post.
*/
 proc ttest data=example3;
 paired drug*control;
 run;
