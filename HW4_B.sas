libname lib "\\tsclient\F\School\PM511\student318";
options nofmterr;

data question_2;
	set lib.subjdata_318;
run;

proc sort data=question_2;
	by asthma;
run;

/*Association between MMEF and BMI for children without asthma*/
proc reg data=question_2;
	where asthma=0;
	model mmef = bmi / clb;
	output out=modeltst r=resid p=pred;
run;

/*Association between MMEF and BMI for children with asthma*/
proc reg data=question_2;
	where asthma=1;
	model mmef = bmi /clb;
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

proc glm data=question_2;
	model mmef=bmi asthma bmi*asthma / solution clparm;
run;

