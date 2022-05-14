libname lib "\\tsclient\F\School\PM511\student318";

data question_a;
	/*Obtain data set from folder*/
	set lib.ex0502_318;

	/*Create modern BMI variable*/
	bmi=quet/100*703.1;

	/*Label appropriate variables*/
	label sbp = 'Systolic Blood Pressure'
		  bmi = 'Body Mass Index';
run;

/*Scatter plot for SBP vs BMI with regression line*/
proc reg data=question_a;
	model sbp=bmi;
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

proc print data=question_a;
run;

/*Get BMI for person 15*/
proc print data=question_a (firstobs=15 obs=15);
run;

/*Calculate 95% prediction interval*/
proc reg data=question_a;
	model sbp=bmi / cli;
	output out=est p=pred ucl=upper lci=lower;
run;

proc print data=est;
run;

/*Calculate sample correlation coefficient R*/
proc corr data=question_a;
	var sbp bmi;
run;

/*Calculate coefficient of determination, R^2*/
proc reg data=question_a;
	model sbp=bmi / p;
run;

/*Find mean of BMI*/
proc means data=question_a;
	var bmi;
run;

/*Method 2 question B3*/
data question_b;
	set question_a;

	bmi_24=bmi-24.0;
	bmi_mean=bmi-26.4301882;
	bmi_person10=bmi-34.8386;
run;

proc reg data=question_b;
	model sbp=bmi_person10 / clb;
run;

/*Estimated intercepts of BMI, BMI-24.0, and BMI-BMI_mean*/
proc reg data=question_b;
	model sbp=bmi / clb;
run;

proc reg data=question_b;
	model sbp=bmi_24 / clb;
run;

proc reg data=question_b;
	model sbp=bmi_mean / clb;
run;

/*Get BMI for person 10*/
proc print data=question_a (firstobs=10 obs=10);
run;

proc reg data=question_a;
	model sbp=bmi / cli;
run;

/*Add label for smoking*/
data question_c;
	set question_a;

	label smk = 'Smoking Status';
run;

/*Sort data to do boxsort of sbp vs smk*/
proc sort data=question_c;
	by smk;
run;

proc boxplot data=question_c;
	plot sbp*smk;
run;

/*Scatter plot of sbp vs smk with regression line*/
proc reg data=question_c;
	model sbp=smk;
	output out=model2 r=r2 p=p2;
run;

/*Testing linearity*/
proc gplot data=model2;
	symbol1 v=star;
	plot r2*p2; * -- plot residuals against pred (or X);
run;

/*Testing for normality*/
proc univariate plot normal data=model2;
	var r2;
run;

/*Calculate mean SBP for nonsmokers and smokers*/
proc means data=question_c;
	by smk;
	var sbp;
run;

/*Get estimated intercept and slope values*/
proc reg data=question_c;
	model sbp=smk;
run;

/*Independent T test comparing mean SBP between smokers and nonsmokers*/
proc ttest data=question_c;
	class smk;
	var sbp;
run;
