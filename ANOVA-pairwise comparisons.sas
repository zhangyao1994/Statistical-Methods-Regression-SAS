

/* We will now look at the weightloss for subjects on three diet types - Atkins diet, Bob's diet, and 
the KrispyKreme diet (An all donut diet). 

We randomly assign 8 subjects to each of the three diet groups and record how much weight
they lost after 3 months.*/

data diet_example; input diet_type$	weightloss;
cards;
Atkins 8
Atkins 6
Atkins 4
Atkins 9
Atkins 6
Atkins 11
Atkins 5
Atkins 4
Bob's 25
Bob's 2
Bob's  7
Bob's 6
Bob's 9
Bob's  1
Bob's 6
Bob's 5
KrispyKreme -4
KrispyKreme -11
KrispyKreme -2
KrispyKreme -3
KrispyKreme -3.1
KrispyKreme -1.9
KrispyKreme -2.7
KrispyKreme -10
;
run;






proc glm data=diet_example;
 class diet_type;
 model weightloss=diet_type;
 run;


/*  Since diet_type is significant, we will look at the pairwise comparisons. 
Ho: the mean weightloss of Atkins = the mean weightloss of Bob's
Ho: the mean weightloss of Atkins = the mean weightloss of KrispyKreme
Ho: the mean weightloss of bob's = the mean weightloss of KrispyKreme


To do this we use the lsmeans diet_type/pdiff command.  This will give all the pairwise comparisons
 for the levels of the variable listed after lsmeans (here diet_type)*/


 proc glm data=diet_example;
 class diet_type;
 model weightloss=diet_type;
 lsmeans diet_type/ pdiff;
 run;

 /* We can also use proc mixed and the results are a little more clearer*/

 proc mixed data=diet_example;
 class diet_type;
 model weightloss=diet_type;
 lsmeans diet_type/ pdiff;
 run;

 /* We can see that both the Atkins diet and Bob's diet are significantly different
 than the KrispyKreme diet but that the Atkins diet and Bob's diet are not significantly different
 from each other.
