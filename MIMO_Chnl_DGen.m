function MIMO_CHNL_OUT = MIMO_Chnl_DGen(MIMO_PARAM_N_SYMB,MIMO_PARAM_M_SYMB,MIMO_PARAM_R_SYMB)


temparr = (MIMO_PARAM_R_SYMB(1):MIMO_PARAM_R_SYMB(2)).';

a=1;

b=length(temparr);

randindex = round(a + (b-a) .* rand(MIMO_PARAM_N_SYMB,MIMO_PARAM_M_SYMB));

MIMO_CHNL_OUT = temparr(randindex);