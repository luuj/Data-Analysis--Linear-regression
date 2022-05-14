libname lib "\\tsclient\F\School\PM511\student318";
options nofmterr;

data HW5;
	/*Obtain data set from folder*/
	set lib.ICVmodelvalidate;
	/*Merge method-1 predicted values with the dataset*/
	merge rscorep (keep=MODEL1);

	/*Method 2 of prediction*/
	predicted_val = 19.85667 + 3.59571*(logtrafficvol) - 0.01168*(elevationmean) + 0.00115*(popdensity);
run;

/*Calculate R2 of predicted=observed*/
proc reg data=HW5;
	model predicted_val = no2;
	model MODEL1 = no2;
run;


/*Use 5a model and save output for score test*/
proc reg data=HW5 outest=regout;
	model no2 = logtrafficvol elevationmean popdensity;
run;

/*Method 1 of prediction*/
proc score data=HW5 score=regout out=rscorep type=parms;
	var logtrafficvol elevationmean popdensity;
run;

/*Print out method 1*/
proc print data=rscorep;
	var MODEL1;
run;

/*Print out method 2*/
proc print data=hw5;
	var predicted_val;
run;

