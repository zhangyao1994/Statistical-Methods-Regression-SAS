
data diets2;
input diet$ gender$ weightloss;
cards;
Atkins female 10
Atkins female  11
Atkins female  9
Atkins female  11
Atkins female  10
Atkins male 10
Atkins male 12
Atkins male 8
Atkins male 11
Atkins male 9
Bob's female  20
Bob's female  21
Bob's female  19
Bob's female  22
Bob's female  20
Bob's male 11
Bob's male 9
Bob's male 8
Bob's male 13
Bob's male 11
;
run;


/* To do 2-way or higher ANOVAs, the code is the same but we list all factors in the class and model statement. 
To include interaction between two factors, we list the crossproduct of both factors in the model statement.

To run a model with two factors and their interaction, it follows the form:
model y = factor1 factor2 factor1*factor2. 

Below, the interaction between diet and gender is included in the model by including
the diet*gender term in the model statement.  
*/
proc glm data=diets2;
 class diet gender;
 model weightloss=diet gender diet*gender;
 run;


/* 
Note here, we only use the Type III SS.  In this example they are the same as the Type I SS	but
they will not always be.

The within sums of sqaures is the error sums of squares. 

The between sums of sqaures are the sums of squares for each source: diet, gender, and their interaction.

The model sums of squares is used for the global F test.  This tests the null that none
of the predictors (here that is diet, age, and the diet*age interaction) have an effect on the
response.


Since the interaction is significant, we will look at the pairwise comparisons
for the interaction only. If the interaction were not significant, and the effects of either
gender, diet, or both, were significant, then we would look at their corresponding pairwise comparisons.

*/


proc glm data=diets2;
 class diet gender;
 model weightloss=diet gender diet*gender; 
 lsmeans  diet*gender/ pdiff;
 run;


 proc mixed data=diets2;
 class diet gender;
 model weightloss=diet gender diet*gender; 
 lsmeans  diet*gender/ pdiff;
 run;




 /*

The last table are the pairwise comparisons for the interaction terms.  You can think of it
as if we have 4 groups:
females on Atkins diet, males on Atkins diet, females on Bob's diet, males on Bob's diet.

The table gives us the tests between these 4 groups.  For example, the test between  
Ho: the mean of females on the Atkins diet is the same as the mean of males on the Atkins diet
has a p-value of .8290.

*/

/* Now suppose there are 3 different diet types: Atkins, Bob's, and Sally's. */

data diets3;
input diet$ gender$ weightloss;
cards;
Atkins female 12
Atkins female  14
Atkins female  8
Atkins male 8
Atkins male 11
Atkins male 9
Sally's female  11
Sally's  female  10
 Sally's female  20
Sally's male 10
Sally's male 12
Sally's male 10
Bob's female  21
Bob's female  19
Bob's female  22
Bob's male 8
Bob's male 12
Bob's male 11
;



 proc mixed data=diets3;
 class diet gender;
 model weightloss=diet gender diet*gender; 
 lsmeans  diet*gender/ pdiff;
 run;

 /* In a situation like this, when the interaction is significant, 
you want to look at the pairwise comparisons that make sense.  For instance,
comparing the mean of males on Bob's diet to the mean of females on Atkins probably is not of interest.

You would want to test the levels of one factor at a level of another factor.  That is, you
would test gender at each level of diet 

male Atkins vs female Atkins
male Sally's vs female Sally's
male Bob's vs female Bob's


and test the diets at each level of gender.

male Atkins vs male Bob's
male Atkins vs male Sally's
male Bob's vs male Sally's

female Atkins vs  female Bob's
female Atkins vs female Sally's
female Bob's vs female Sally's

And note, these are testing if the means are equal.  

For  male Atkins vs female Atkins, the p-value is .4128 and we conclude there is no significant
difference between the mean weightloss of males on Atkins and the mean weightloss of females on Atkins.

For testing female Atkins vs female Bob's, the p-value is .0019 so we reject the mean weightloss for 
females on Atkins is the same as the mean weightloss for females on Bob's diet. 

The estimate for the comparisons are giving the estimated difference between the groups that
are being compared.  This is the estimated mean of the first group listed minus the
estimated mean of the second group listed.  That is when looking at female Atkins vs female Bob's 
the estimate -9.333 is giving us that: 

the estimated mean weightloss for females on Atkins minus the estimated mean weightloss for females on Bob’s
is -9.333.


Since the results were significant, we can write this as:

The mean weightloss for females on Atkins is significantly less than the mean weightloss for female's on Bob's.

