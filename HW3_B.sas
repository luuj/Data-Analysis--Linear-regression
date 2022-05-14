libname lib "\\tsclient\F\School\PM511\student318";
OPTIONS nofmterr;

data question_b;
	set lib.subjdata_318;
	
	/*Split weight up into categories based on quartiles*/
	if (weight > 88) then cat_weight = 3; /*Weight >Q3*/
	else if (weight > 76) then cat_weight = 2; /*Q2 < Weight <=Q3*/
	else if (weight > 67) then cat_weight = 1; /*Q1 < Weight <=Q2*/
	else cat_weight = 0; /*Weight <= Q1*/

	null=0;
run;

/*Find Q1, Q2, and Q3*/
proc univariate data=question_b;
	var weight;
run;

/*Summary statistics for each variable*/
proc means data=question_b;
	var fev height;
run;

proc freq data=question_b;
	tables cat_weight race sex;
run;

/*Find association with FEV for each variable*/
proc reg data=question_b;
	model FEV = height;
	model FEV = cat_weight;
	model FEV = race;
	model FEV = sex;
run;

/*Fit model with all X variables*/
proc reg data=question_b;
	model fev = cat_weight height sex race / clb;
	output out=modeltst r=resid p=pred;
run;

/*Testing linearity*/
proc gplot data=modeltst;
	symbol1 v=star;
	plot resid*pred; * -- plot residuals against pred (or X);
run;

/*Testing for normality*/
proc univariate plot normal data=modeltst;
	var resid;
run;

/*Removing extreme outlier*/
data question_b;
	set question_b;
	if obs=343 then delete;
run; 
