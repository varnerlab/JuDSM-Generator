# ----------------------------------------------------------------------------------- #
# Copyright (c) 2017 Varnerlab
# Robert Frederick Smith School of Chemical and Biomolecular Engineering
# Cornell University, Ithaca NY 14850
#
# Permission is hereby granted, free of charge, to any person obtaining a copy
# of this software and associated documentation files (the "Software"), to deal
# in the Software without restriction, including without limitation the rights
# to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
# copies of the Software, and to permit persons to whom the Software is
# furnished to do so, subject to the following conditions:
#
# The above copyright notice and this permission notice shall be included in
# all copies or substantial portions of the Software.
#
# THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
# IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
# FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
# AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
# LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
# OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
# THE SOFTWARE.
# ----------------------------------------------------------------------------------- #
#
# ----------------------------------------------------------------------------------- #
# Function: Kinetics
# Description: Calculate the flux array at time t
# Generated on: 2017-07-24T07:32:57.347
#
# Input arguments:
# t::Float64 => Current time value (scalar) 
# x::Array{Float64,1} => State array (number_of_species x 1) 
# data_dictionary::Dict{AbstractString,Any} => Dictionary holding model parameters 
#
# Output arguments:
# flux_array::Array{Float64,1} => Flux array (number_of_rates x 1) at time t 
# ----------------------------------------------------------------------------------- #
function Kinetics(t,x,enzyme_array,volume,data_dictionary)

	# Get data from the data_dictionary - 
	rate_constant_array = data_dictionary["rate_constant_array"];
	saturation_constant_array = data_dictionary["saturation_constant_array"];

	# Alias the species array (helps with debuging) - 
	M_glc_D_e = x[1];
	PROTEIN_CAT_e = x[2];
	M_ac_e = x[3];
	M_co2_e = x[4];
	M_for_e = x[5];
	M_lac_D_e = x[6];
	M_pyr_e = x[7];
	M_succ_e = x[8];

	# Convex species alias - 
	convex_initial_condition_array = data_dictionary["convex_species_initial_condition_array"];
	GENE_CAT = convex_initial_condition_array[1];
	M_10fthf_c = convex_initial_condition_array[2];
	M_13dpg_c = convex_initial_condition_array[3];
	M_2ddg6p_c = convex_initial_condition_array[4];
	M_2pg_c = convex_initial_condition_array[5];
	M_3pg_c = convex_initial_condition_array[6];
	M_4abz_c = convex_initial_condition_array[7];
	M_4adochor_c = convex_initial_condition_array[8];
	M_5mthf_c = convex_initial_condition_array[9];
	M_5pbdra = convex_initial_condition_array[10];
	M_6pgc_c = convex_initial_condition_array[11];
	M_6pgl_c = convex_initial_condition_array[12];
	M_78dhf_c = convex_initial_condition_array[13];
	M_78mdp_c = convex_initial_condition_array[14];
	M_ac_c = convex_initial_condition_array[15];
	M_accoa_c = convex_initial_condition_array[16];
	M_actp_c = convex_initial_condition_array[17];
	M_adp_c = convex_initial_condition_array[18];
	M_aicar_c = convex_initial_condition_array[19];
	M_air_c = convex_initial_condition_array[20];
	M_akg_c = convex_initial_condition_array[21];
	M_ala_L_c = convex_initial_condition_array[22];
	M_ala_L_c_tRNA_c = convex_initial_condition_array[23];
	M_amp_c = convex_initial_condition_array[24];
	M_arg_L_c = convex_initial_condition_array[25];
	M_arg_L_c_tRNA_c = convex_initial_condition_array[26];
	M_asn_L_c = convex_initial_condition_array[27];
	M_asn_L_c_tRNA_c = convex_initial_condition_array[28];
	M_asp_L_c = convex_initial_condition_array[29];
	M_asp_L_c_tRNA_c = convex_initial_condition_array[30];
	M_atp_c = convex_initial_condition_array[31];
	M_cadav_c = convex_initial_condition_array[32];
	M_cair_c = convex_initial_condition_array[33];
	M_cdp_c = convex_initial_condition_array[34];
	M_chor_c = convex_initial_condition_array[35];
	M_cit_c = convex_initial_condition_array[36];
	M_clasp_c = convex_initial_condition_array[37];
	M_cmp_c = convex_initial_condition_array[38];
	M_co2_c = convex_initial_condition_array[39];
	M_coa_c = convex_initial_condition_array[40];
	M_ctp_c = convex_initial_condition_array[41];
	M_cys_L_c = convex_initial_condition_array[42];
	M_cys_L_c_tRNA_c = convex_initial_condition_array[43];
	M_dhap_c = convex_initial_condition_array[44];
	M_dhf_c = convex_initial_condition_array[45];
	M_e4p_c = convex_initial_condition_array[46];
	M_etoh_c = convex_initial_condition_array[47];
	M_f6p_c = convex_initial_condition_array[48];
	M_faicar_c = convex_initial_condition_array[49];
	M_fdp_c = convex_initial_condition_array[50];
	M_fgam_c = convex_initial_condition_array[51];
	M_fgar_c = convex_initial_condition_array[52];
	M_for_c = convex_initial_condition_array[53];
	M_fum_c = convex_initial_condition_array[54];
	M_g3p_c = convex_initial_condition_array[55];
	M_g6p_c = convex_initial_condition_array[56];
	M_gaba_c = convex_initial_condition_array[57];
	M_gar_c = convex_initial_condition_array[58];
	M_gdp_c = convex_initial_condition_array[59];
	M_glc_D_c = convex_initial_condition_array[60];
	M_gln_L_c = convex_initial_condition_array[61];
	M_gln_L_c_tRNA_c = convex_initial_condition_array[62];
	M_glu_L_c = convex_initial_condition_array[63];
	M_glu_L_c_tRNA_c = convex_initial_condition_array[64];
	M_glx_c = convex_initial_condition_array[65];
	M_gly_L_c = convex_initial_condition_array[66];
	M_gly_L_c_tRNA_c = convex_initial_condition_array[67];
	M_glycoA_c = convex_initial_condition_array[68];
	M_gmp_c = convex_initial_condition_array[69];
	M_gtp_c = convex_initial_condition_array[70];
	M_h2o2_c = convex_initial_condition_array[71];
	M_h2o_c = convex_initial_condition_array[72];
	M_h2s_c = convex_initial_condition_array[73];
	M_h_c = convex_initial_condition_array[74];
	M_hco3_c = convex_initial_condition_array[75];
	M_he_c = convex_initial_condition_array[76];
	M_his_L_c = convex_initial_condition_array[77];
	M_his_L_c_tRNA_c = convex_initial_condition_array[78];
	M_icit_c = convex_initial_condition_array[79];
	M_ile_L_c = convex_initial_condition_array[80];
	M_ile_L_c_tRNA_c = convex_initial_condition_array[81];
	M_imp_c = convex_initial_condition_array[82];
	M_indole_c = convex_initial_condition_array[83];
	M_lac_D_c = convex_initial_condition_array[84];
	M_leu_L_c = convex_initial_condition_array[85];
	M_leu_L_c_tRNA_c = convex_initial_condition_array[86];
	M_lys_L_c = convex_initial_condition_array[87];
	M_lys_L_c_tRNA_c = convex_initial_condition_array[88];
	M_mal_L_c = convex_initial_condition_array[89];
	M_met_L_c = convex_initial_condition_array[90];
	M_met_L_c_tRNA_c = convex_initial_condition_array[91];
	M_methf_c = convex_initial_condition_array[92];
	M_mglx_c = convex_initial_condition_array[93];
	M_mlthf_c = convex_initial_condition_array[94];
	M_mql8_c = convex_initial_condition_array[95];
	M_mqn8_c = convex_initial_condition_array[96];
	M_nad_c = convex_initial_condition_array[97];
	M_nadh_c = convex_initial_condition_array[98];
	M_nadp_c = convex_initial_condition_array[99];
	M_nadph_c = convex_initial_condition_array[100];
	M_nh3_c = convex_initial_condition_array[101];
	M_o2_c = convex_initial_condition_array[102];
	M_oaa_c = convex_initial_condition_array[103];
	M_omp_c = convex_initial_condition_array[104];
	M_or_c = convex_initial_condition_array[105];
	M_pep_c = convex_initial_condition_array[106];
	M_phe_L_c = convex_initial_condition_array[107];
	M_phe_L_c_tRNA_c = convex_initial_condition_array[108];
	M_pi_c = convex_initial_condition_array[109];
	M_ppi_c = convex_initial_condition_array[110];
	M_pro_L_c = convex_initial_condition_array[111];
	M_pro_L_c_tRNA_c = convex_initial_condition_array[112];
	M_prop_c = convex_initial_condition_array[113];
	M_prpp_c = convex_initial_condition_array[114];
	M_pyr_c = convex_initial_condition_array[115];
	M_q8_c = convex_initial_condition_array[116];
	M_q8h2_c = convex_initial_condition_array[117];
	M_r5p_c = convex_initial_condition_array[118];
	M_ru5p_D_c = convex_initial_condition_array[119];
	M_s7p_c = convex_initial_condition_array[120];
	M_saicar_c = convex_initial_condition_array[121];
	M_ser_L_c = convex_initial_condition_array[122];
	M_ser_L_c_tRNA_c = convex_initial_condition_array[123];
	M_succ_c = convex_initial_condition_array[124];
	M_succoa_c = convex_initial_condition_array[125];
	M_thf_c = convex_initial_condition_array[126];
	M_thr_L_c = convex_initial_condition_array[127];
	M_thr_L_c_tRNA_c = convex_initial_condition_array[128];
	M_trp_L_c = convex_initial_condition_array[129];
	M_trp_L_c_tRNA_c = convex_initial_condition_array[130];
	M_tyr_L_c = convex_initial_condition_array[131];
	M_tyr_L_c_tRNA_c = convex_initial_condition_array[132];
	M_udp_c = convex_initial_condition_array[133];
	M_ump_c = convex_initial_condition_array[134];
	M_utp_c = convex_initial_condition_array[135];
	M_val_L_c = convex_initial_condition_array[136];
	M_val_L_c_tRNA_c = convex_initial_condition_array[137];
	M_xmp_c = convex_initial_condition_array[138];
	M_xu5p_D_c = convex_initial_condition_array[139];
	OPEN_GENE_CAT = convex_initial_condition_array[140];
	PROTEIN_CAT = convex_initial_condition_array[141];
	RIBOSOME_START_CAT = convex_initial_condition_array[142];
	RIBOSOME_c = convex_initial_condition_array[143];
	RNAP_c = convex_initial_condition_array[144];
	mRNA_CAT_c = convex_initial_condition_array[145];
	tRNA_c = convex_initial_condition_array[146];
	M_ala_L_e = convex_initial_condition_array[147];
	M_arg_L_e = convex_initial_condition_array[148];
	M_asn_L_e = convex_initial_condition_array[149];
	M_asp_L_e = convex_initial_condition_array[150];
	M_cys_L_e = convex_initial_condition_array[151];
	M_etoh_e = convex_initial_condition_array[152];
	M_gln_L_e = convex_initial_condition_array[153];
	M_glu_L_e = convex_initial_condition_array[154];
	M_gly_L_e = convex_initial_condition_array[155];
	M_h2o_e = convex_initial_condition_array[156];
	M_h2s_e = convex_initial_condition_array[157];
	M_h_e = convex_initial_condition_array[158];
	M_hco3_e = convex_initial_condition_array[159];
	M_his_L_e = convex_initial_condition_array[160];
	M_ile_L_e = convex_initial_condition_array[161];
	M_leu_L_e = convex_initial_condition_array[162];
	M_lys_L_e = convex_initial_condition_array[163];
	M_met_L_e = convex_initial_condition_array[164];
	M_nh3_e = convex_initial_condition_array[165];
	M_o2_e = convex_initial_condition_array[166];
	M_phe_L_e = convex_initial_condition_array[167];
	M_pi_e = convex_initial_condition_array[168];
	M_pro_L_e = convex_initial_condition_array[169];
	M_prop_e = convex_initial_condition_array[170];
	M_ser_L_e = convex_initial_condition_array[171];
	M_thr_L_e = convex_initial_condition_array[172];
	M_trp_L_e = convex_initial_condition_array[173];
	M_tyr_L_e = convex_initial_condition_array[174];
	M_val_L_e = convex_initial_condition_array[175];

	# Write the kinetics functions - 
	kinetic_flux_array = Array{Float64}[];

	# 1 M_glc_D_e --> M_glc_D_c
	flux = rate_constant_array[1]*(E_M_glc_D_c_exchange)*((M_glc_D_e)/(saturation_constant_array[1]+M_glc_D_e));
	push!(kinetic_flux_array,flux);

return kinetic_flux_array

