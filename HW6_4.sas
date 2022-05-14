proc format;
	value locfmt
		1='Inner suburbs'
		2='Outer suburbs'
		3='In town';
run;

data HW6;
	infile "\\tsclient\F\School\PM511\student318\ex1219_318.dat" delimiter='09'x;
	input id y x1 x2 x3 x4 z1 z2;
	
	if z1=1 then
		loc=1;
	else if z2=1 then
		loc=2;
	else
		loc=3;

	format loc locfmt.;
	label id='House ID'
	 	  y='Sales price (x1000)'
		  x1='Area (x100)'
		  x2='# of bedrooms'
		  x3='Total # of rooms'
		  x4='Age (years)'
		  loc='location';

	/*Center the area variable*/
	cent_x1 = x1-14.1;
run;

proc print data=HW6 label;
run;

proc glm data=HW6;
	class loc;
	model y = loc / solution;
run;

proc means data=HW6;
	var x1;
run;

/*Association of centered area vs price and location*/
proc corr data=HW6;
	var cent_x1 y;
run;

proc glm data=HW6;
	class loc;
	model cent_x1 = loc / solution;
run;

proc glm data=HW6;
	class loc;
	model y = loc cent_x1 / solution;
	lsmeans loc / tdiff adjust=scheffe alpha=0.05;
run;

symbol1 value=dot interpol=rl;
/*Scatterplots of seeling price vs. centered area for each location*/
proc gplot data=HW6;
	plot y*cent_x1=loc;
run;

proc glm data=HW6;
	class loc;
	model y = loc cent_x1 loc*cent_x1/ solution;
	lsmeans loc / tdiff adjust=scheffe alpha=0.05;
run;

