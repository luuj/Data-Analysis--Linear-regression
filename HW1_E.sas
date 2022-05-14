data question_E;
	input group $ _STAT_ $ val;

	datalines;
	group1 n 12
	group1 mean 4.8
	group1 std 1.4
	group2 n 12
	group2 mean 5.1
	group2 std 1.8
	;
run;

proc ttest data=question_E;
	class group;
	var val;
run;
