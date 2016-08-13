# CGE_2016
All works on CGE in 2016

August 13.  We add recursive dynamic Hybrid Agriculture model

	2. Recursive dynamics (year by year convergence) (8/1-8/14)
		a. Converge at time t => update state variable at time t+1 => converge at time t+1 반복
		b. Distribution: Agri_Link_dyn1_2016.zip
			i. CGE/Agri_Link/Agri_Link_dyn1_20016 zipped 
			ii. Agri_Link.gpr:  project file
			iii. Agri_2016_link_recursive.gms: cge model
			iv. .\ data: contain all input files 
		c. Two problems
			i. Time consuming : It takes around 1050 iterations to converge all 25 time period. Convergence criterion is max(abs(dev_xcrep))<1/100, max(abs(dev_parep))<1/100;
			ii. Too rapid growth in early years
				1) Since interest rate is normalized to one. Initial year capital =sum(Capital payment IO)/interest rate becomes relatively small 
				2) Then the initial year investment becomes large compared to initial year capital stock
				3) Then the capital increase fast in early years.
				4) Early year growth rate exceeds 10%
				5) To modify that. Capital Accumulation formula becomes
				Ks.Fx('Capital')=Ks.L('Capital')(1-delta)+(0.88)sum(C,XAF.L('S-I',C)); (line 3206)
		d. Other characteristics
			i. Need 2 iterations in unlinked model. . BU module needs two iterations to check convergence
			ii.  t is time (year) and iter is within t iteration indicator
			iii. .. Res (..,t) parameter is now used to store solutions of each iteration. The domain is changed to (..,iter)
			iv. Converged solution for each t is saved in .. Con(.., t) parameter.
			

