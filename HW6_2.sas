libname lib "\\tsclient\F\School\PM511\student318";
options nofmterr;

data HW6;
	set lib.chol_318;

	if (age < 0) then delete;
	
	/*Split age up into categories; Q1=11, Q2=19.5, Q3=41*/
	if (age >= 41) then
		agecat = 4;
	else if (age >= 19.5) then
		agecat = 3;
	else if (age >= 11) then
		agecat = 2;
	else
		agecat = 1;
run;

proc means data=HW6 q1 median q3; 
	var age;
run;

proc print data=HW6;
	var age agecat;
run;

proc freq data=HW6;
	tables agecat;
run;

/*Scatterplot + boxplot of logtg vs. age per agecat category*/
proc reg data=HW6;
	model logtg = age;
run;

proc sgplot data=HW6;
	vbox logtg/category=agecat;
run;

/*One-way ANOVA*/
proc glm data=HW6;
	class agecat;
	model logtg = agecat / solution;
	means agecat / tukey alpha=0.05;
	contrast 'group 1 and 2 vs. 3 and 4' agecat 1 1 -1 -1;
run;

/*Testing for trend*/
proc glm data=HW6;
	class agecat;
	model logtg = agecat / solution;
	contrast 'linear' agecat -3 -1 1 3;
	contrast 'quadratic' agecat 1 -1 -1 1;
	contrast 'cubic' agecat -1 3 -3 1;
run;
