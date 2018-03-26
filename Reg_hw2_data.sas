
data hw2; input tv likes_candy happiness;
cards;

  1.5  0 60.59814
 1.1 0   60.11322
 5.5 0 73.51643
 10 0 97.74437
 8 0 90.69785
5.8 0 79.23487
55   0  325.2384
28  0 194.53039
31 0 209.32143
23 0  159.63090
1.5 1 21.84698
1.8 1  27.70941
5 1 51.90911
8 1 71.78369
10.5 1 96.07011
25 1   210.79018
4  1 44.81870
45 1 373.23968
23 1 278.08280
33 1 184.12385
 ;
 run;
 
data hw2_2; set hw2; tvxlikes_candy= tv*likes_candy; run;

proc reg data=hw2_2;
 model happiness = tv likes_candy tvxlikes_candy ;
 output out=results p=predicted_happiness
 run;
quit;

Proc sgplot data=results;
series x=tv y=predicted_happiness / group=likes_candy;
RUN;

proc reg data=hw2_2;
 model happiness = tv likes_candy tvxlikes_candy/   vif ;
 run;
quit;

proc reg data=hw2_2;
model tvxlikes_candy= tv likes_candy ;
run;

data hw2_3; set hw2; tv2=tv-10; 	 tv2xlikes_candy= tv2*likes_candy; run;
proc print data=hw2_3; run;
proc reg data=hw2_3;
 model happiness = tv2 likes_candy tv2xlikes_candy ;
 output out=results2 p=predicted_happiness2
 run;
quit;


