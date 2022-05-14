libname lib "\\tsclient\F\School\PM511\student318";

data question_1;
	set lib.chol_318;

	/*Remove invalid age entry*/
	if (age<0) then age=".";

	/*Create age10 variable*/
	age10 = age/10;
run;

/*Check sample size and range of logchol and age*/
proc univariate data=question_1;
	var logchol age;
run;

proc reg data=question_1;
	model logchol = age10 wt;
run;

proc reg data=question_1;
	model logchol = age10 wt ht;
run;

