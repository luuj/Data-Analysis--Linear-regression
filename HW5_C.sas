libname lib "\\tsclient\F\School\PM511\student318";
options nofmterr;

data HW5;
	/*Obtain data set from folder*/
	set lib.subjdata_318;

	age_sq=age*age;
	bmi_sq=bmi*bmi;

	age_bmi_interaction = age*bmi;
run;

/*All possible subsets*/
proc reg data=HW5;
	model MMEF=age bmi age_sq bmi_sq asthma / selection=rsquare cp;
run;

proc reg data=HW5;
	model MMEF = age bmi_sq asthma;
	model MMEF = age age_sq bmi_sq asthma;
run;

/*Backwards approach*/
proc glmselect data=HW5;
	model MMEF=age bmi age_sq bmi_sq asthma / selection=backward sls=0.05 details=all hierarchy=single showpvalues select=sl stop=sl;
run;

/*Forwards approach*/
proc glmselect data=HW5;
	model MMEF=age bmi age_sq bmi_sq asthma / selection=forward sle=0.05 details=all hierarchy=single showpvalues select=sl stop=sl;
run;

/*Stepwise approach*/
proc glmselect data=HW5;
	model MMEF=age bmi age_sq bmi_sq asthma / selection=stepwise sls=0.05 sle=0.05 details=all hierarchy=single showpvalues select=sl stop=sl;
run;

/*Stepwise approach*/
proc glmselect data=HW5;
	model MMEF=age bmi age_sq asthma age*bmi age*asthma bmi*asthma age*bmi*asthma / selection=stepwise sls=0.15 sle=0.15 hierarchy=single showpvalues select=sl stop=sl;
run;

/*Including interaction terms*/
proc sort data=HW5;
	by asthma;
run;

proc reg data=HW5;
	by asthma;
	model MMEF=age bmi age_sq bmi_sq age_bmi_interaction/ selection=rsquare cp;
run;

proc reg data=HW5;
	where asthma=0;
	model MMEF=age bmi_sq;
	model MMEF=age bmi age_sq;
	model MMEF=bmi age_sq bmi_sq age_bmi_interaction;
run;

proc reg data=HW5;
	where asthma=1;
	model MMEF=bmi_sq;
	model MMEF=age age_sq;
	model MMEF=bmi age_sq age_bmi_interaction;
	model MMEF=age bmi age_sq age_bmi_interaction;
	model MMEF=bmi age_sq bmi_sq age_bmi_interaction;
run;
