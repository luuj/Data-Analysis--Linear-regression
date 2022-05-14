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

/*Get median OPI in each fund category*/
proc means data=HW6 median;
	by cat;
	var opi;
run;

/*Kruskall Wallis test*/
proc npar1way data=HW6 wilcoxon;
	class cat;
	var opi;
run;

/*Rank by OPI*/
proc rank data=HW6 out=ranked_data;
	var opi;
	ranks rank_opi;
	proc print;
run;

/*ANOVA on the ranks of Y with Tukey's test*/
proc glm data=ranked_data;
	class cat;
	model rank_opi = cat;
	means cat / tukey alpha=0.05;
run;

