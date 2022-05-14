/*Format for fund category variable*/
proc format;
	value catfmt
		1='Aggressive growth'
		2='Long-term growth'
		3='Growth and income'
		4='Income';
run;

data HW6;
	infile "\\tsclient\F\School\PM511\student318\ex1719_318.dat" delimiter='09'x;
	input fund $ cat load $ vol $ opi;

	format cat catfmt.;
	label opi='Overall Performance Index'
	 	  cat='Fund Category';
run;

proc print data=HW6 label;
run;

/*Box plot of OPI by fund category*/
ods graphics on;
proc sgpanel data=HW6;
	panelby cat/rows=4 columns=1;
	hbox opi;
run;

/*Descriptive statistics of opi by category*/
proc means data=HW6 n mean std min max;
	var opi;
	by cat;
run;

/*One-way ANOVA*/
proc glm data=HW6;
	class cat;
	model opi = cat / solution;
	means cat / tukey scheffe alpha=0.05;
run;

