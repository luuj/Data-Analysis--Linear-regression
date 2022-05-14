data question_A;
	Y1a = probnorm(-1.5);
	Y1b = probit(1-0.30);

	Y2a = cinv(0.03,7);
	Y2b = 1-probchi(10,12); 

	Y3a = abs(tinv(0.15/2,16));
	Y3b = 1-probt(2.50, 28);

	Y4a = finv(0.02, 3, 20);
	Y4b = probf(1.9, 7, 30);

	title 'HW1_A';
run;

proc print data=question_A;
run;

