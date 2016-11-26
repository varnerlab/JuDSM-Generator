function convex_flux_array = estimate_convex_fluxes(t,x,kinetic_flux_array,data_dictionary)

	% Get some stuff from the data_dictionary -
	STM = data_dictionary.stoichiometric_matrix;
	[NM,NRATES] = size(STM);

	% Formulate objective vector (default is to minimize fluxes)
	objective_vector = data_dictionary.objective_coefficient_array;

	% Get bounds from the data_dictionary -
	vb = data_dictionary.default_flux_bounds;
	LB = vb(:,1);
	UB = vb(:,2);

	% --------------------- Equality constraints ---------------------- %
	% Setup the bV and the constraint types required by the solver -
	STM_BALANCED_BLOCK = data_dictionary.BALANCED_MATRIX;
	AEq = STM_BALANCED_BLOCK;

	% Get the dimension of the balanced block -
	[NUM_BALANCED,NUM_RATES] = size(STM_BALANCED_BLOCK);

	% Formulate the bV -
	bVEq = zeros(NUM_BALANCED,1);
	% --------------------- Equality constraints ---------------------- %

	% --------------------- Inequality constraints -------------------- %
	UNBALANCED_STM = data_dictionary.SPECIES_CONSTRAINTS;
	SBA = data_dictionary.SPECIES_BOUND_ARRAY;
	SBA_LOWER = SBA(:,2);
	SBA_UPPER = SBA(:,3);
	A = [UNBALANCED_STM ; -1*UNBALANCED_STM];
	bV = [SBA_UPPER ; -1*SBA_LOWER];
	% --------------------- Inequality constraints -------------------- %

	% Set some values for the options parameter of LINPROG
  options=optimset('TolFun',1e-6);

  % Call the LP solver -
  [convex_flux_array,fVal,status,OUT,LAM] = linprog(objective_vector,A,bV,AEq,bVEq,LB,UB,[],options);

return;
