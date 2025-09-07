PROC IML;
START main;
	CALL streaminit(12345); /* Set seed */
	lambda = 14.39; /* Arrival rate */
	mu1 = 7.5; /* Service Rate */
	T = 60; /* No. of minutes in an hour */

/* Solution 1: Improving Public Transport */

	lanes = 2; 
	ramp = j(T+1,4,0); /* Matrix to store time, arrivals, departures, queue size */
	
	DO i = 1 TO T+1;		
		arrivals = rand("Poisson",lambda);
		departures = rand("Poisson",(mu1*lanes));

		ramp[i,1]=i-1; /* Time */
		ramp[i,2]=arrivals; /* Arrivals */
		ramp[i,3]=departures; /* Departures */
		* Queue Size;
		if i = 1 then   	ramp[1,4]=max(ramp[i,2]-ramp[i,3],0);
		else			ramp[i,4]=max((ramp[i-1,4]+(ramp[i,2]-ramp[i,3])),0);

		if ramp[i,4]=0 then 	ramp[i,3]=0;		
	end;

/* Solution 2: 3 Lanes instead of 2 */

mu2 = 6.67; /* Service rate */
lanes = 3;

	ramp1 = j(T+1,4,0); /* Matrix to store time, arrivals, departures, queue size */
	
	do i = 1 to T+1;		
		arrivals = rand("Poisson",lambda);
		departures = rand("Poisson",(mu2*lanes));
		ramp1[i,1]=i-1; /* Time */
		ramp1[i,2]=arrivals; /* Arrivals */
		ramp1[i,3]=departures; /* Departures */
		* Queue Size;
		if i = 1 then		ramp1[1,4]=max(ramp1[i,2]-ramp1[i,3],0);
		else			ramp1[i,4]=max((ramp1[i-1,4]+(ramp1[i,2]-ramp1[i,3])),0);

		if ramp1[i,4]=0 then 	ramp1[i,3]=0;		
	end;
	
	/* Save results */
	vars  = {"Time","Arrivals","Departures","Queue_Size"};
	vars1 = {"Time","Arrivals1","Departures1","Queue_Size1"};

	/* Service lane solution */
	create work.ramp from ramp[colname=vars];
		append from ramp;
	close work.ramp;

	/* 3 Lane Ramp solution */
	create work.ramp1 from ramp1[colname=vars1];
		append from ramp1;
	close work.ramp1;

finish main;
RUN;

	
/* Merge Datasets */
DATA work.compare; merge work.ramp work.ramp1; RUN;

/* Visualise */
title1 "Comparison of the Two Solutions";
title2 "Service lane solution vs 3 Lanes solution";
PROC SGPLOT data=work.compare;
	series x=Time y=Queue_Size  / name="ramp"  
				      legendlabel="Service Lane Solution";
	series x=Time y=Queue_Size1 / name="ramp1" 
				      legendlabel="3 Lane Ramp Solution";
	
	xaxis 	label="Time (Minutes)" 
		grid;
	yaxis 	label="Number of Vehicles"grid;
	
	keylegend "ramp" "ramp1" / location=inside 
				   position=top;
RUN;




PROC IML;
START main;
CALL streaminit(12345); /* Set seed */
lambda = 14.39; /* Arrival rate */
mu1 = 7.5; /* Service Rate */
T = 3*60; /* No. of minutes in 3 hours */

/* Solution 1: Improving Public Transport */

lanes = 2; 
ramp1 = j(T+1,4,0); /* Matrix to store time, arrivals, departures, queue size */
	
DO i = 1 TO T+1;		
arrivals = rand("Poisson",lambda);
departures = rand("Poisson",(mu1*lanes));

ramp1[i,1]=i-1; /* Time */
ramp1[i,2]=arrivals; /* Arrivals */
ramp1[i,3]=departures; /* Departures */

* Queue Size;
IF i = 1 THEN   	
ramp1[1,4]=MAX(ramp1[i,2]-ramp1[i,3],0);
ELSE			
ramp1[i,4]=MAX((ramp1[i-1,4]+(ramp1[i,2]-ramp1[i,3])),0);

IF ramp1[i,4]=0 THEN	ramp1[i,3]=0;		
END;

/* Solution 2: 3 Lanes instead of 2 */

mu2 = 6.67; /* Service rate */
lanes = 3;

ramp2 = j(T+1,4,0); /* Matrix to store time, arrivals, departures, queue size */
	
DO i = 1 TO T+1;		
arrivals = RAND("Poisson",lambda);
departures = RAND("Poisson",(mu2*lanes));
ramp2[i,1]=i-1; /* Time */
ramp2[i,2]=arrivals; /* Arrivals */
ramp2[i,3]=departures; /* Departures */
		
* Queue Size;
IF i = 1 THEN		
ramp2[1,4]=MAX(ramp2[i,2]-ramp2[i,3],0);
ELSE			
ramp2[i,4]=MAX((ramp2[i-1,4]+(ramp2[i,2]-ramp2[i,3])),0);

IF ramp2[i,4]=0 THEN	
ramp2[i,3]=0;		
END;
	
/* Save results */
parameters1  = {"Time","Arrivals","Departures","Queue_Size"};
parameters2 = {"Time","Arrivals1","Departures1","Queue_Size1"};

/* Service lane solution */
CREATE work.ramp1 FROM ramp1[COLNAME=parameters1];
APPEND FROM ramp1;
CLOSE work.ramp1;

/* 3 Lane Ramp solution */
CREATE work.ramp2 FROM ramp2[COLNAME=parameters2];
APPEND FROM ramp2;
CLOSE work.ramp2;

FINISH main;
RUN;

	
/* Merge Datasets */
DATA work.compare; 
MERGE work.ramp1 work.ramp2; 
RUN;

/* Plotting the simulationn */
TITLE1 "Comparison of the Two Solutions";
TITLE2 "Public Transport solution vs 3 Lanes solution";
PROC SGPLOT DATA=work.compare;
SERIES X=Time Y=Queue_Size  / NAME="ramp1"  
LEGENDLABEL="Public Transport Solution";
SERIES X=Time Y=Queue_Size1 / NAME="ramp2" 
LEGENDLABEL="3 Lane Ramp Solution";
XAXIS LABEL="Time (Minutes)";
YAXIS LABEL="Number of Vehicles";
KEYLEGEND "ramp1" "ramp2" / LOCATION=outside POSITION=top;
RUN;

