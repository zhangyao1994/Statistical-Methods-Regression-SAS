* To write out comments, we can use;

/* Or we can use.  This way can contain semicolons.
   */

/* There are three windows in SAS: the editor window, the log window, and the output window.
The editor window has been saved as ttests-SAS1.  It is where we type our commands.  It is color
coded to let us know when a word is a command, blue, when we are entering data, yellow, etc.
This also allows us to know when we make mistakes, such as when a command is in black and not blue.

The output window displays the results and the log displays what SAS has just done.  The log is where we look
when we need to trouble shoot.  There will be red and green writing where SAS has problems.   For example, I will try
and print the data set example1.  We haven't created it yet so this will give us an error in the log.
(we will learn about creating datasets and printing them later, this is just an
example of using the log).
*/

proc print data=example1; 
run;

/*

Before we run any descriptive statistics or analysis, we need to create a data file. We will create
the same datafile we used for a two-sided t-test in R.  We have 5 subjects on a drug and 5 subjects on a control
and we recorded their weightloss.  To create the data we use: 
 	*/



data example1; input subject$ treatment$ weightloss;
cards;
1 drug 3
2 drug 1
3 drug 2
4 drug 5
5 drug 4
6 control 8
7 control 6
8 control 9
9 control 10
10 control 7
;
run;

/*


Note, it is very important to end each line of command with a ";"  
A line of command can physically be on more than one line but they must end with a ";"
 
The first line is naming our data file; "Data  filename".  Here we named it "example1".  
When we want to run an analysis, we will run it on this data file.  

The second line uses the "input" command to name our variables.  Here we have three variables:
–the subject, whether the subjects took a control or drug ,and the weight loss for that subject. We will name 
these variables:"subject", "treatment", and "weightloss".

Thus we use the command  "input  subject$ treatment$ weightloss;"  
to name our variables. The "$" after "subject" and "treatment" tells SAS these are categorical variables.  
The third line, "cards;", tells SAS we are going to enter the data.  We then enter the subject number, 
which treatment the subject took for this trial, and the weight loss for this trial.   
For example, when subject 1 took the drug, that subject lost 3 pounds.  



We don’t use a  ";" after every data line but after we enter the entire data, we end it with a ";" .  
At the end of any procedure, we end it with "run;".  Note, we still need to highlight what we want to run and hit F3 
or click the running man to get the code to run.

To run an analysis in SAS, we use proc commands.  For example to do an ANOVA, we use proc anova, 
to do a regression, we use proc regression.  

First, we will print the data set that we have created. We start by stating which proc we are using,
"proc print".  Then we state what data set we want to run the proc on, "data=example1".

Note, when we created the data set we used "data example1" with NO "=" sign.
When running a proc on this datafile, we use "data=example1" with a "=" sign.

For proc print, all we need to include after the proc command line is the run command.
Often, we will use multiple command lines.

The code looks like	*/



proc print 	data=example1;
run;
/* 
Now we are going to use proc ttest.  This is done to run a ttest. The default is a two-sided test.  So we 
start with testing: 

Ho: the true mean weightloss of drug group - the true mean weightloss of control group = 0 
Ha: the true mean weightloss of drug group - the true mean weightloss of control group DOES NOT = 0


The code looks like	*/

proc ttest data=example1;
class treatment;
var weightloss;
 run;

/*

We start by stating which proc we are using, "proc ttest" , and which data set "data=example1".  
 These both go in the first line of command and are then followed by the ";"   

 

The CLASS statement names the variable that classifies the data set into two groups.  
It is the categorical variable whose levels we are comparing.
Here we use treatment after the class command because we are comparing the two levels of treatment: drug and control.  

The VAR statement names the measurement variable to be analyzed, that is the response variable.
Here we are doing a t-test comparing the weightloss, which goes after the VAR command, 
of the two levels of treatment, which goes after the class command. 

The output gives p-values for both the pooled method and the Satterthwaite method.  The output also
includes a test for equality of variances.  For this test, the null is that the variances are equal.  Thus,
we can use the pooled method results unless this test is significant.  That is unless we reject the assumption
of equal variances, we can assume it is true and we can use the pooled method.  In this example, the p-value for 
testing the equality of variances is 1.  Thus, we do not reject the null of equal variances
and we can use either the pooled results or the Satterthwaite results.



The p-value for our t test is .0011, which matches what we got in R.  And note that the pooled and the 
Satterthwaite results are the same.  This is because we have equal exactly variances, 
in which case the Satterthwaite method reduces to the pooled method.


Below is sample data with unequal variances.  Note, now the p-value of the test of equal variances is 
.0037 and we reject that we have equal variances and thus we must use the Satterthwaite method results.*/





data example1b; input subject$ treatment$ weightloss;
cards;
1 drug 3
2 drug 1
3 drug 2
4 drug 5
5 drug 4
6 control 8
7 control 6
8 control 9
9 control 10
10 control 30
;
run;





proc ttest data=example1b;
class treatment;
var weightloss;
 run;






/*
This command also gives 95% CI's for the difference in means: (2.6940,7.3060)

If we want to change the confidence level,
we can use the alpha= "" option.  For instance to do 99* ci's, we use "alpha=.01" */
*/

proc ttest data=example1 alpha=.01;
class treatment;
var weightloss;
 run;



 /* We do not need to specify the null.  It automatically tests that the 
 means of the two groups in the class command are the same.  The default is a 
 two sided test.   

To do a one-sided test, we add the command SIDES= L or Sides = U.  
Note, when using SIDES= L, this is testing that the mean of the first group is 
less than the mean of the second.  
When using SIDES= U, this is testing that the mean of the first group is 
greater than the mean of the second.  

The order the of the variables (the groups) is done alphabetically, not how they are entered in the data.
Thus the first group is control and drug is the second since c comes before d.

So below tests if the mean of the control group is less than the mean of the drug group.*/

 

proc ttest data=example1 SIDES= L;
class treatment;
var weightloss;
 run;


 /*Below tests if the mean of the control group is greater than the mean of the drug group.*/

 

proc ttest data=example1 SIDES= U;
class treatment;
var weightloss;
 run;


/* For all three tests, the two-sided test and the 2 one-sided tests, the value of the t statistic is the
 same but the calculations of the p-values are different.*/
