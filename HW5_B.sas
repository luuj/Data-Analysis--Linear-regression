libname lib "\\tsclient\F\School\PM511\student318";

data HW5;
	/*Obtain data set from folder*/
	set lib.chol_318;
	if age < 0 then delete;

	age_sq = age*age;
	cent_age = age-28.5689655;
	cent_sq = cent_age*cent_age;
run;

proc corr data=HW5;
	var cent_age cent_sq female;
run;

proc reg data=HW5;
	model logtg = age age_sq female / vif tol;
run;

proc means data=HW5;
	var age;
run;

proc reg data=HW5;
	model logtg = cent_age cent_sq female / r influence;
	output out=modeltst rstudent=jackknife cookd=cook h=leverage dffits=dbeta;
run;

proc sort data=modeltst;
	by cook;
run;

proc print data=modeltst;
	var cook dbeta;
run;

data residualTest;
	df = 190 - 3 - 2;
	t_val1 = 3.46560;

	r1 = 2*(1-probt(abs(t_val1), df));

	new_alpha = 0.05/190;
	proc print; var r1 new_alpha;
run;

