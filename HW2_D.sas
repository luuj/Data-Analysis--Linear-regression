libname lib "\\tsclient\F\School\PM511\student318";

data question_d;
	set lib.chol_318;

	label chol = 'Cholesterol'
		  age = 'Age';
run;

proc sort data=question_d;
	by sex;
run;

proc sgplot data=question_d;
	by sex;
	scatter x=chol y=age;
run;

/*Calculate sample correlation coefficient R*/
proc corr data=question_d;
	by sex;
	var chol age;
run;

data r_values;
	r1 = 0.18710;
	r2 = 0.24524;

	z1 = (1/2)*log((1+r1)/(1-r1));
	z2 = (1/2)*log((1+r2)/(1-r2));

	n1 = 95;
	n2 = 95;
	se = sqrt(1/(n1-3) + 1/(n2-3));
	z = (z1-z2)/se;
	p = 2*(1-probnorm(abs(z))); 
run;

proc print data=r_values;
run;

