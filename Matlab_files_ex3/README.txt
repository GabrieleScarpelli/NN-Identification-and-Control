L'ordine di esecuzione dei file è

-> init_RR.m

-> simulink_RR_adaptive.slx

-> (optional) Animation.m

-> (optional) ref_animation.m

-> (optional) basis_figure.m [questo file modifica le variabili nel workspace,
			      se lo si vuole eseguire e dopo continuare è bene
			      eseguire nuovamente init_RR.m, e di nuovo il simulink]