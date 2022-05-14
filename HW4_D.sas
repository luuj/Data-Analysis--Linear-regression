libname lib "\\tsclient\F\School\PM511\student318";
options nofmterr;

data question_4;
	set lib.avplotdat_318;
run;

proc reg data=question_4;
	model y=x2;
	output out=model1 r=resid_1;
run;

proc reg data=question_4;
	model x1=x2;
	output out=model2 r=resid_2;
run;

data compute;
	merge model1 model2; 
	by id; 
run;

proc reg data=compute;
	model resid_1 = resid_2 / clb;
run;

proc reg data=question_4;
	model y=x1 x2 / clb;
run;
