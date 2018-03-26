


data diets; input diet$	weightloss;
cards;
1 8
1 16
1 9
2 9
2 16
2 21
2 11
2 18
3 15
3 10
3 17
3 6
;
run;


/* To run an ANOVA, we will use proc glm.  It is very similiar to proc reg and can
be used to run regression, ANOVA, or ANCOVA.  ANOVA has categorical predictors.  Regression has
continuos predictors.  ANCOVA has both. 

The code is the same as for proc reg, but now we use a class command and list any categorical predictor
variables after it.  Here, we have three types of diets, which are categories. Thus diet is a categorical variable.



*/

proc glm data=diets;
 class diet;
 model weightloss=diet;
 run;

 /*
The between sums of sqaures is the diet sums of squares.

The model sums of squares tests the global null hypothesis that none of the predictor vaiables 
have an effect on the response.


Note here, the model sum of squares and the diet sum of sqaures are the same.  This is because diet is
the only variable in the model.

The within sums of squares is the error sums of squares. 
*/

