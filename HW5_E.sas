libname lib "\\tsclient\F\School\PM511\student318";
options nofmterr;

data HW5;
	/*Obtain data set from folder*/
	set lib.ICVmodeltrain_318;
run;

proc corr data=HW5;
	var distfwy distfwy2 distmajorroad logtrafficvol logtrafficvol2 elevationmean elevationsd popdensity;
run;

/*Stepwise approach*/
proc glmselect data=HW5;
	model no2 = distfwy distfwy2 distmajorroad logtrafficvol logtrafficvol2 elevationmean elevationsd popdensity 
		/ selection=stepwise sls=0.1 sle=0.1 details=all hierarchy=single showpvalues select=sl stop=sl;
run;

proc reg data=HW5;
	model no2 = distfwy distfwy2 distmajorroad logtrafficvol logtrafficvol2 elevationmean elevationsd popdensity;
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

proc reg data=HW5;
	model no2 = logtrafficvol elevationmean popdensity / r influence;
	output out=modeltst r=resid p=pred rstudent=jackknife;
run;

proc gplot data=modeltst;
	symbol1 v=star;
	plot jackknife*pred; 
run;
