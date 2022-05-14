libname lib '\\tsclient\F\School\student318';

data question_C;
	/*Import data from previously created permanent dataset*/
	set lib.hw1_b;
run;

proc ttest h0=115 data=question_C;
	var sbp;
run;

/*Determine the mean of overall SBP*/
proc means data=question_C alpha=0.05 mean clm std;
	var sbp;
run;

/*Print data set*/
proc print data=question_C;
run;

/*Boxplots of SBP by smoking status*/
proc sort data=question_C;
	by smk;
run;

proc boxplot data=question_C;
	plot sbp*smk;
run;

/*Independent T test comparing mean SBP between smokers and nonsmokers*/
proc ttest data=question_C;
	class smk;
	var sbp;
run;

/*Wilcoxon rank-sum test comparing mean SBP between smokers and nonsmokers*/
proc npar1way wilcoxon data=question_C;
	class smk;
	var sbp;
run;

