libname lib '\\tsclient\F\School\student318';

data HW1;
	/*Obtain data set from folder*/
	set lib.ex0502_318; 

	/*Create modern BMI variable*/
	bmi=quet/100*703.1;

	/*Create low BMI variable*/
	if bmi<25 then
		lowbmi=1;
	else if bmi>=25 then
		lowbmi=0;
	else
		lowbmi=.; 

	/*Create AGESQ and LNAGE variables*/
	agesq=age**2;
	lnage=log(age);

	/*Create SUMSBP variable*/
	retain sumsbp 0;
	sumsbp=sumsbp+sbp;

	/*Label variables*/
	label sbp='systolic blood pressure'
	 	  quet='quetelet index'
	 	  smk='smoking history, SMK=0 if nonsmoker & SMK=1 if smoker'
		  bmi="body mass index (kg/m^2)";
run;

/*Format for lowbmi variable*/
proc format;
	value bmifmt
		1='light'
		0='heavy';
run;

/*Scatter plot for SBP vs BMI*/
proc sgplot data=HW1;
	xaxis label='Systolic Blood Pressure';
	yaxis label='Body Mass Index';
	scatter x=sbp y=bmi;
run;

/*Frequency of smokers and crosstabulation vs. bmi*/
proc freq data=HW1;
	tables smk;
	title 'Distribution of non-smokers vs. smokers';

	tables smk*lowbmi;
	title 'Crosstabulation of smoking history and low bmi';
run;

/*Sum of SBP using proc means*/
proc means data=HW1 sum;
	var sbp;
run;

/*Print everything including labels and formats*/
proc print data=HW1 label;
format lowbmi bmifmt.;
run;

proc contents data=HW1;
run;

/*Save updated dataset*/
data lib.HW1_B; 
   set HW1;
run;
