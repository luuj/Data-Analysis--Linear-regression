libname lib "\\tsclient\F\School\PM511\student318";
options nofmterr;

data ec;
	set lib.nmes_318;
	logexp = log(exp);

	if age > 65 then agespl = age-65;
	else agespl = 0;
run;

proc reg data=ec;
	model logexp = age agespl / clb;
run;

/*Adjust for sex - Model 1*/
proc reg data=ec;
	model logexp = age agespl male / clb;
run;

/*Adjust for sex - Model 2a*/
proc reg data=ec;
	where male=0;
	model logexp = age agespl male / clb;
run;

/*Adjust for sex - Model 2b*/
proc reg data=ec;
	where male=1;
	model logexp = age agespl male / clb;
run;


