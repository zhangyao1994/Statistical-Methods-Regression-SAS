/* For question 1*/

data hw6_independent_samples; 
input subject$ diet$ weight;
cards;
1 meat 181.7430   
2 meat 177.4771   
3 meat 191.2686   
4 meat 165.0295   
5 meat 180.2135   
6 meat 170.0580   
7 meat 196.7114   
8 meat 180.6256   
9 meat 178.3083   
10 meat 212.3657 

11 spam 178.0479
12 spam 176.0893
13 spam 174.0887
14 spam 170.7987
15 spam 176.2029
16 spam 174.4232
17 spam 167.7596
18 spam 174.6495
19 spam 165.7547
20 spam 188.5495
;
run;

/* First, we treat them as independent samples*/
proc ttest data=hw6_independent_samples;
class diet;
var weight;
 run;


/* For question 4*/
data hw6_dependent_samples; 
input subject$ meat_weight spam_weight;
cards;
1 181.7430   178.0479
2 177.4771   176.0893
3 191.2686   174.0887
4 165.0295   170.7987
5 180.2135   176.2029
6 170.0580   174.4232
7 196.7114   167.7596
8 180.6256   174.6495
9 178.3083   165.7547
10 212.3657   188.5495
;
run;

 proc ttest data=hw6_dependent_samples;
 paired meat_weight*spam_weight;
 run;
