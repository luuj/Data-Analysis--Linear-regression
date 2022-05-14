libname lib "\\tsclient\F\School\PM511\student318";

data HW5;
	/*Obtain data set from folder*/
	set lib.ex0502_318; 

	/*Create BMI variable*/
	bmi=quet/100*703.1;
run;

proc reg data=HW5;
	model sbp=bmi / r influence;
	output out=modeltst r=res p=pred student=student rstudent=jackknife;
run;

proc gplot data=modeltst;
	symbol1 v=star;
	plot res*pred student*pred jackknife*pred; 
run;

data residualTest;
	df = 32 - 1 - 2;
	t_val1 = 2.7701;
	t_val2 = -2.3569;

	r1 = 2*(1-probt(abs(t_val1), df));
	r2 = 2*(1-probt(abs(t_val2), df));

	new_alpha = 0.05/32;
	proc print; var r1 r2 new_alpha;
run;

