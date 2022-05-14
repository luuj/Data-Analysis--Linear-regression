libname lib "\\tsclient\F\School\PM511\student318";

data question_a;
	set lib.chol_318;
run;

proc reg data=question_a;
	model loghdl=wt;
run;

proc reg data=question_a;
	model loghdl=age;
run;

proc reg data=question_a;
	model loghdl=ht;
run;

/*Simple linear regression of Y on sex*/
proc reg data=question_a;
	model loghdl=female / clb;
	output out=modeltst r=resid p=pred;
run;

/*Testing linearity + homoscedasticity*/
proc gplot data=modeltst;
	symbol1 v=star;
	plot resid*pred; * -- plot residuals against pred (or X);
run;

/*Testing for normality*/
proc univariate plot normal data=modeltst;
	var resid;
run;


/*Fitting model with all four X-variables*/
proc reg data=question_a;
	model loghdl=female age wt ht / clb;
	output out=modeltst r=resid p=pred;
run;

/*Testing variance for each X*/
proc reg data=question_a NOPRINT;
	model loghdl=wt / clb;
	output out=modeltst r=resid p=pred;
run;

proc reg data=question_a NOPRINT;
	model loghdl=age / clb;
	output out=modeltst r=resid p=pred;
run;

proc reg data=question_a NOPRINT;
	model loghdl=ht / clb;
	output out=modeltst r=resid p=pred;
run;

/*Testing linearity + homoscedasticity*/
proc gplot data=modeltst;
	symbol1 v=star;
	plot resid*pred; * -- plot residuals against pred (or X);
run;

/*Testing for normality*/
proc univariate plot normal data=modeltst;
	var resid;
run;

/*Plug in values for geometric mean*/
data plug_in;
	set question_a;
	agenew=age-26;
	femalenew=female-1;
	wtnew=wt-135;
	htnew=ht-64;
run;

proc reg data=plug_in outest=estimates NOPRINT;
	model loghdl= femalenew agenew wtnew htnew;
run;

data plug_in;
	set estimates;
	g_mean = exp(Intercept);
run;

proc print data=plug_in;
	var g_mean;
run;

/*Q6 Regression models*/
proc reg data=question_a;
	model loghdl = female wt age;
	model loghdl = female wt ht;
	model loghdl = female age ht;
	model loghdl = wt age ht;
	model loghdl = female wt age ht;
run;

/*Q6 Regression against nothing*/
data null;
	set question_a;
	null_var=0;
run;

proc reg data=null;
	model loghdl=null_var;
run;
