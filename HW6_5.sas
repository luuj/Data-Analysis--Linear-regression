data HW6;
	infile "\\tsclient\F\School\PM511\student318\ex1807_318.dat" delimiter='09'x;
	input gene $ site length;
	proc print;
run;

proc gplot data=HW6;
	plot length*site;
run;

proc gplot data=HW6;
	plot length*gene;
run;

proc ANOVA data=HW6;
	class site gene;
	model length = site gene;
	means gene / tukey alpha=0.05;
run;

