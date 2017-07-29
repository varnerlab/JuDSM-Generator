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
# Function: DataDictionary
# Description: Holds simulation and model parameters as key => value pairs in a Julia Dict()
# Generated on: 2017-07-28T19:04:55.443
#
# Input arguments:
# time_start::Float64 => Simulation start time value (scalar) 
# time_stop::Float64 => Simulation stop time value (scalar) 
# time_step::Float64 => Simulation time step (scalar) 
#
# Output arguments:
# data_dictionary::Dict{AbstractString,Any} => Dictionary holding model and simulation parameters as key => value pairs 
# ----------------------------------------------------------------------------------- #
function DataDictionary(time_start::Float64,time_stop::Float64,time_step::Float64)

	# Species list - 
	# GENE_CAT 1
	# M_10fthf_c 2
	# M_13dpg_c 3
	# M_2ddg6p_c 4
	# M_2pg_c 5
	# M_3pg_c 6
	# M_4abz_c 7
	# M_4adochor_c 8
	# M_5mthf_c 9
	# M_5pbdra 10
	# M_6pgc_c 11
	# M_6pgl_c 12
	# M_78dhf_c 13
	# M_78mdp_c 14
	# M_ac_c 15
	# M_accoa_c 16
	# M_actp_c 17
	# M_adp_c 18
	# M_aicar_c 19
	# M_air_c 20
	# M_akg_c 21
	# M_ala_L_c 22
	# M_ala_L_c_tRNA_c 23
	# M_amp_c 24
	# M_arg_L_c 25
	# M_arg_L_c_tRNA_c 26
	# M_asn_L_c 27
	# M_asn_L_c_tRNA_c 28
	# M_asp_L_c 29
	# M_asp_L_c_tRNA_c 30
	# M_atp_c 31
	# M_cadav_c 32
	# M_cair_c 33
	# M_cdp_c 34
	# M_chor_c 35
	# M_cit_c 36
	# M_clasp_c 37
	# M_cmp_c 38
	# M_co2_c 39
	# M_coa_c 40
	# M_ctp_c 41
	# M_cys_L_c 42
	# M_cys_L_c_tRNA_c 43
	# M_dhap_c 44
	# M_dhf_c 45
	# M_e4p_c 46
	# M_etoh_c 47
	# M_f6p_c 48
	# M_faicar_c 49
	# M_fdp_c 50
	# M_fgam_c 51
	# M_fgar_c 52
	# M_for_c 53
	# M_fum_c 54
	# M_g3p_c 55
	# M_g6p_c 56
	# M_gaba_c 57
	# M_gar_c 58
	# M_gdp_c 59
	# M_glc_D_c 60
	# M_gln_L_c 61
	# M_gln_L_c_tRNA_c 62
	# M_glu_L_c 63
	# M_glu_L_c_tRNA_c 64
	# M_glx_c 65
	# M_gly_L_c 66
	# M_gly_L_c_tRNA_c 67
	# M_glycoA_c 68
	# M_gmp_c 69
	# M_gtp_c 70
	# M_h2o2_c 71
	# M_h2o_c 72
	# M_h2s_c 73
	# M_h_c 74
	# M_hco3_c 75
	# M_he_c 76
	# M_his_L_c 77
	# M_his_L_c_tRNA_c 78
	# M_icit_c 79
	# M_ile_L_c 80
	# M_ile_L_c_tRNA_c 81
	# M_imp_c 82
	# M_indole_c 83
	# M_lac_D_c 84
	# M_leu_L_c 85
	# M_leu_L_c_tRNA_c 86
	# M_lys_L_c 87
	# M_lys_L_c_tRNA_c 88
	# M_mal_L_c 89
	# M_met_L_c 90
	# M_met_L_c_tRNA_c 91
	# M_methf_c 92
	# M_mglx_c 93
	# M_mlthf_c 94
	# M_mql8_c 95
	# M_mqn8_c 96
	# M_nad_c 97
	# M_nadh_c 98
	# M_nadp_c 99
	# M_nadph_c 100
	# M_nh3_c 101
	# M_o2_c 102
	# M_oaa_c 103
	# M_omp_c 104
	# M_or_c 105
	# M_pep_c 106
	# M_phe_L_c 107
	# M_phe_L_c_tRNA_c 108
	# M_pi_c 109
	# M_ppi_c 110
	# M_pro_L_c 111
	# M_pro_L_c_tRNA_c 112
	# M_prop_c 113
	# M_prpp_c 114
	# M_pyr_c 115
	# M_q8_c 116
	# M_q8h2_c 117
	# M_r5p_c 118
	# M_ru5p_D_c 119
	# M_s7p_c 120
	# M_saicar_c 121
	# M_ser_L_c 122
	# M_ser_L_c_tRNA_c 123
	# M_succ_c 124
	# M_succoa_c 125
	# M_thf_c 126
	# M_thr_L_c 127
	# M_thr_L_c_tRNA_c 128
	# M_trp_L_c 129
	# M_trp_L_c_tRNA_c 130
	# M_tyr_L_c 131
	# M_tyr_L_c_tRNA_c 132
	# M_udp_c 133
	# M_ump_c 134
	# M_utp_c 135
	# M_val_L_c 136
	# M_val_L_c_tRNA_c 137
	# M_xmp_c 138
	# M_xu5p_D_c 139
	# OPEN_GENE_CAT 140
	# PROTEIN_CAT 141
	# RIBOSOME_START_CAT 142
	# RIBOSOME_c 143
	# RNAP_c 144
	# mRNA_CAT_c 145
	# tRNA_c 146
	# M_ac_e 147
	# M_co2_e 148
	# M_for_e 149
	# M_lac_D_e 150
	# M_pyr_e 151
	# M_succ_e 152
	# M_ala_L_e 153
	# M_arg_L_e 154
	# M_asn_L_e 155
	# M_asp_L_e 156
	# M_cys_L_e 157
	# M_etoh_e 158
	# M_glc_D_e 159
	# M_gln_L_e 160
	# M_glu_L_e 161
	# M_gly_L_e 162
	# M_h2o_e 163
	# M_h2s_e 164
	# M_hco3_e 165
	# M_his_L_e 166
	# M_ile_L_e 167
	# M_leu_L_e 168
	# M_lys_L_e 169
	# M_met_L_e 170
	# M_nh3_e 171
	# M_o2_e 172
	# M_phe_L_e 173
	# M_pi_e 174
	# M_pro_L_e 175
	# M_prop_e 176
	# M_ser_L_e 177
	# M_thr_L_e 178
	# M_trp_L_e 179
	# M_tyr_L_e 180
	# M_val_L_e 181
	# PROTEIN_CAT_e 182

	# Is this min or max - 
	is_minimum_flag = false

	# Load the complete stoichiometric_matrix - 
	stoichiometric_matrix = readdlm("./Network.dat")

	# Dyanmic species array -
	dynamic_species_index_array = [
		159	;	# 1 M_glc_D_e
		182	;	# 2 PROTEIN_CAT_e
	];
	free_stoichiometric_array = stoichiometric_matrix[dynamic_species_index_array,:];

	# Measured species array -
	measured_species_index_array = [
		147	;	# 1 M_ac_e
		148	;	# 2 M_co2_e
		149	;	# 3 M_for_e
		150	;	# 4 M_lac_D_e
		151	;	# 5 M_pyr_e
		152	;	# 6 M_succ_e
	];
	measured_stoichiometric_array = stoichiometric_matrix[measured_species_index_array,:];

	# Convex species array -
	convex_species_index_array = [
		1	;	# 1 GENE_CAT
		2	;	# 2 M_10fthf_c
		3	;	# 3 M_13dpg_c
		4	;	# 4 M_2ddg6p_c
		5	;	# 5 M_2pg_c
		6	;	# 6 M_3pg_c
		7	;	# 7 M_4abz_c
		8	;	# 8 M_4adochor_c
		9	;	# 9 M_5mthf_c
		10	;	# 10 M_5pbdra
		11	;	# 11 M_6pgc_c
		12	;	# 12 M_6pgl_c
		13	;	# 13 M_78dhf_c
		14	;	# 14 M_78mdp_c
		15	;	# 15 M_ac_c
		16	;	# 16 M_accoa_c
		17	;	# 17 M_actp_c
		18	;	# 18 M_adp_c
		19	;	# 19 M_aicar_c
		20	;	# 20 M_air_c
		21	;	# 21 M_akg_c
		22	;	# 22 M_ala_L_c
		23	;	# 23 M_ala_L_c_tRNA_c
		24	;	# 24 M_amp_c
		25	;	# 25 M_arg_L_c
		26	;	# 26 M_arg_L_c_tRNA_c
		27	;	# 27 M_asn_L_c
		28	;	# 28 M_asn_L_c_tRNA_c
		29	;	# 29 M_asp_L_c
		30	;	# 30 M_asp_L_c_tRNA_c
		31	;	# 31 M_atp_c
		32	;	# 32 M_cadav_c
		33	;	# 33 M_cair_c
		34	;	# 34 M_cdp_c
		35	;	# 35 M_chor_c
		36	;	# 36 M_cit_c
		37	;	# 37 M_clasp_c
		38	;	# 38 M_cmp_c
		39	;	# 39 M_co2_c
		40	;	# 40 M_coa_c
		41	;	# 41 M_ctp_c
		42	;	# 42 M_cys_L_c
		43	;	# 43 M_cys_L_c_tRNA_c
		44	;	# 44 M_dhap_c
		45	;	# 45 M_dhf_c
		46	;	# 46 M_e4p_c
		47	;	# 47 M_etoh_c
		48	;	# 48 M_f6p_c
		49	;	# 49 M_faicar_c
		50	;	# 50 M_fdp_c
		51	;	# 51 M_fgam_c
		52	;	# 52 M_fgar_c
		53	;	# 53 M_for_c
		54	;	# 54 M_fum_c
		55	;	# 55 M_g3p_c
		56	;	# 56 M_g6p_c
		57	;	# 57 M_gaba_c
		58	;	# 58 M_gar_c
		59	;	# 59 M_gdp_c
		60	;	# 60 M_glc_D_c
		61	;	# 61 M_gln_L_c
		62	;	# 62 M_gln_L_c_tRNA_c
		63	;	# 63 M_glu_L_c
		64	;	# 64 M_glu_L_c_tRNA_c
		65	;	# 65 M_glx_c
		66	;	# 66 M_gly_L_c
		67	;	# 67 M_gly_L_c_tRNA_c
		68	;	# 68 M_glycoA_c
		69	;	# 69 M_gmp_c
		70	;	# 70 M_gtp_c
		71	;	# 71 M_h2o2_c
		72	;	# 72 M_h2o_c
		73	;	# 73 M_h2s_c
		74	;	# 74 M_h_c
		75	;	# 75 M_hco3_c
		76	;	# 76 M_he_c
		77	;	# 77 M_his_L_c
		78	;	# 78 M_his_L_c_tRNA_c
		79	;	# 79 M_icit_c
		80	;	# 80 M_ile_L_c
		81	;	# 81 M_ile_L_c_tRNA_c
		82	;	# 82 M_imp_c
		83	;	# 83 M_indole_c
		84	;	# 84 M_lac_D_c
		85	;	# 85 M_leu_L_c
		86	;	# 86 M_leu_L_c_tRNA_c
		87	;	# 87 M_lys_L_c
		88	;	# 88 M_lys_L_c_tRNA_c
		89	;	# 89 M_mal_L_c
		90	;	# 90 M_met_L_c
		91	;	# 91 M_met_L_c_tRNA_c
		92	;	# 92 M_methf_c
		93	;	# 93 M_mglx_c
		94	;	# 94 M_mlthf_c
		95	;	# 95 M_mql8_c
		96	;	# 96 M_mqn8_c
		97	;	# 97 M_nad_c
		98	;	# 98 M_nadh_c
		99	;	# 99 M_nadp_c
		100	;	# 100 M_nadph_c
		101	;	# 101 M_nh3_c
		102	;	# 102 M_o2_c
		103	;	# 103 M_oaa_c
		104	;	# 104 M_omp_c
		105	;	# 105 M_or_c
		106	;	# 106 M_pep_c
		107	;	# 107 M_phe_L_c
		108	;	# 108 M_phe_L_c_tRNA_c
		109	;	# 109 M_pi_c
		110	;	# 110 M_ppi_c
		111	;	# 111 M_pro_L_c
		112	;	# 112 M_pro_L_c_tRNA_c
		113	;	# 113 M_prop_c
		114	;	# 114 M_prpp_c
		115	;	# 115 M_pyr_c
		116	;	# 116 M_q8_c
		117	;	# 117 M_q8h2_c
		118	;	# 118 M_r5p_c
		119	;	# 119 M_ru5p_D_c
		120	;	# 120 M_s7p_c
		121	;	# 121 M_saicar_c
		122	;	# 122 M_ser_L_c
		123	;	# 123 M_ser_L_c_tRNA_c
		124	;	# 124 M_succ_c
		125	;	# 125 M_succoa_c
		126	;	# 126 M_thf_c
		127	;	# 127 M_thr_L_c
		128	;	# 128 M_thr_L_c_tRNA_c
		129	;	# 129 M_trp_L_c
		130	;	# 130 M_trp_L_c_tRNA_c
		131	;	# 131 M_tyr_L_c
		132	;	# 132 M_tyr_L_c_tRNA_c
		133	;	# 133 M_udp_c
		134	;	# 134 M_ump_c
		135	;	# 135 M_utp_c
		136	;	# 136 M_val_L_c
		137	;	# 137 M_val_L_c_tRNA_c
		138	;	# 138 M_xmp_c
		139	;	# 139 M_xu5p_D_c
		140	;	# 140 OPEN_GENE_CAT
		141	;	# 141 PROTEIN_CAT
		142	;	# 142 RIBOSOME_START_CAT
		143	;	# 143 RIBOSOME_c
		144	;	# 144 RNAP_c
		145	;	# 145 mRNA_CAT_c
		146	;	# 146 tRNA_c
	];
	convex_stoichiometric_array = stoichiometric_matrix[convex_species_index_array,:];

	# Convex initial condition array - 
	convex_initial_condition_array = [
		0.0	;	# 1 GENE_CAT
		0.0	;	# 2 M_10fthf_c
		0.0	;	# 3 M_13dpg_c
		0.0	;	# 4 M_2ddg6p_c
		0.0	;	# 5 M_2pg_c
		0.0	;	# 6 M_3pg_c
		0.0	;	# 7 M_4abz_c
		0.0	;	# 8 M_4adochor_c
		0.0	;	# 9 M_5mthf_c
		0.0	;	# 10 M_5pbdra
		0.0	;	# 11 M_6pgc_c
		0.0	;	# 12 M_6pgl_c
		0.0	;	# 13 M_78dhf_c
		0.0	;	# 14 M_78mdp_c
		0.0	;	# 15 M_ac_c
		0.0	;	# 16 M_accoa_c
		0.0	;	# 17 M_actp_c
		0.0	;	# 18 M_adp_c
		0.0	;	# 19 M_aicar_c
		0.0	;	# 20 M_air_c
		0.0	;	# 21 M_akg_c
		0.0	;	# 22 M_ala_L_c
		0.0	;	# 23 M_ala_L_c_tRNA_c
		0.0	;	# 24 M_amp_c
		0.0	;	# 25 M_arg_L_c
		0.0	;	# 26 M_arg_L_c_tRNA_c
		0.0	;	# 27 M_asn_L_c
		0.0	;	# 28 M_asn_L_c_tRNA_c
		0.0	;	# 29 M_asp_L_c
		0.0	;	# 30 M_asp_L_c_tRNA_c
		0.0	;	# 31 M_atp_c
		0.0	;	# 32 M_cadav_c
		0.0	;	# 33 M_cair_c
		0.0	;	# 34 M_cdp_c
		0.0	;	# 35 M_chor_c
		0.0	;	# 36 M_cit_c
		0.0	;	# 37 M_clasp_c
		0.0	;	# 38 M_cmp_c
		0.0	;	# 39 M_co2_c
		0.0	;	# 40 M_coa_c
		0.0	;	# 41 M_ctp_c
		0.0	;	# 42 M_cys_L_c
		0.0	;	# 43 M_cys_L_c_tRNA_c
		0.0	;	# 44 M_dhap_c
		0.0	;	# 45 M_dhf_c
		0.0	;	# 46 M_e4p_c
		0.0	;	# 47 M_etoh_c
		0.0	;	# 48 M_f6p_c
		0.0	;	# 49 M_faicar_c
		0.0	;	# 50 M_fdp_c
		0.0	;	# 51 M_fgam_c
		0.0	;	# 52 M_fgar_c
		0.0	;	# 53 M_for_c
		0.0	;	# 54 M_fum_c
		0.0	;	# 55 M_g3p_c
		0.0	;	# 56 M_g6p_c
		0.0	;	# 57 M_gaba_c
		0.0	;	# 58 M_gar_c
		0.0	;	# 59 M_gdp_c
		0.0	;	# 60 M_glc_D_c
		0.0	;	# 61 M_gln_L_c
		0.0	;	# 62 M_gln_L_c_tRNA_c
		0.0	;	# 63 M_glu_L_c
		0.0	;	# 64 M_glu_L_c_tRNA_c
		0.0	;	# 65 M_glx_c
		0.0	;	# 66 M_gly_L_c
		0.0	;	# 67 M_gly_L_c_tRNA_c
		0.0	;	# 68 M_glycoA_c
		0.0	;	# 69 M_gmp_c
		0.0	;	# 70 M_gtp_c
		0.0	;	# 71 M_h2o2_c
		0.0	;	# 72 M_h2o_c
		0.0	;	# 73 M_h2s_c
		0.0	;	# 74 M_h_c
		0.0	;	# 75 M_hco3_c
		0.0	;	# 76 M_he_c
		0.0	;	# 77 M_his_L_c
		0.0	;	# 78 M_his_L_c_tRNA_c
		0.0	;	# 79 M_icit_c
		0.0	;	# 80 M_ile_L_c
		0.0	;	# 81 M_ile_L_c_tRNA_c
		0.0	;	# 82 M_imp_c
		0.0	;	# 83 M_indole_c
		0.0	;	# 84 M_lac_D_c
		0.0	;	# 85 M_leu_L_c
		0.0	;	# 86 M_leu_L_c_tRNA_c
		0.0	;	# 87 M_lys_L_c
		0.0	;	# 88 M_lys_L_c_tRNA_c
		0.0	;	# 89 M_mal_L_c
		0.0	;	# 90 M_met_L_c
		0.0	;	# 91 M_met_L_c_tRNA_c
		0.0	;	# 92 M_methf_c
		0.0	;	# 93 M_mglx_c
		0.0	;	# 94 M_mlthf_c
		0.0	;	# 95 M_mql8_c
		0.0	;	# 96 M_mqn8_c
		0.0	;	# 97 M_nad_c
		0.0	;	# 98 M_nadh_c
		0.0	;	# 99 M_nadp_c
		0.0	;	# 100 M_nadph_c
		0.0	;	# 101 M_nh3_c
		0.0	;	# 102 M_o2_c
		0.0	;	# 103 M_oaa_c
		0.0	;	# 104 M_omp_c
		0.0	;	# 105 M_or_c
		0.0	;	# 106 M_pep_c
		0.0	;	# 107 M_phe_L_c
		0.0	;	# 108 M_phe_L_c_tRNA_c
		0.0	;	# 109 M_pi_c
		0.0	;	# 110 M_ppi_c
		0.0	;	# 111 M_pro_L_c
		0.0	;	# 112 M_pro_L_c_tRNA_c
		0.0	;	# 113 M_prop_c
		0.0	;	# 114 M_prpp_c
		0.0	;	# 115 M_pyr_c
		0.0	;	# 116 M_q8_c
		0.0	;	# 117 M_q8h2_c
		0.0	;	# 118 M_r5p_c
		0.0	;	# 119 M_ru5p_D_c
		0.0	;	# 120 M_s7p_c
		0.0	;	# 121 M_saicar_c
		0.0	;	# 122 M_ser_L_c
		0.0	;	# 123 M_ser_L_c_tRNA_c
		0.0	;	# 124 M_succ_c
		0.0	;	# 125 M_succoa_c
		0.0	;	# 126 M_thf_c
		0.0	;	# 127 M_thr_L_c
		0.0	;	# 128 M_thr_L_c_tRNA_c
		0.0	;	# 129 M_trp_L_c
		0.0	;	# 130 M_trp_L_c_tRNA_c
		0.0	;	# 131 M_tyr_L_c
		0.0	;	# 132 M_tyr_L_c_tRNA_c
		0.0	;	# 133 M_udp_c
		0.0	;	# 134 M_ump_c
		0.0	;	# 135 M_utp_c
		0.0	;	# 136 M_val_L_c
		0.0	;	# 137 M_val_L_c_tRNA_c
		0.0	;	# 138 M_xmp_c
		0.0	;	# 139 M_xu5p_D_c
		0.0	;	# 140 OPEN_GENE_CAT
		0.0	;	# 141 PROTEIN_CAT
		0.0	;	# 142 RIBOSOME_START_CAT
		0.0	;	# 143 RIBOSOME_c
		0.0	;	# 144 RNAP_c
		0.0	;	# 145 mRNA_CAT_c
		0.0	;	# 146 tRNA_c
	];


	# =============================== DO NOT EDIT BELOW THIS LINE ============================== #
	data_dictionary = Dict{AbstractString,Any}()
	data_dictionary["stoichiometric_matrix"] = stoichiometric_matrix
	data_dictionary["free_stoichiometric_array"] = free_stoichiometric_array
	data_dictionary["measured_stoichiometric_array"] = measured_stoichiometric_array
	data_dictionary["convex_stoichiometric_array"] = convex_stoichiometric_array
	data_dictionary["convex_initial_condition_array"] = convex_initial_condition_array

	data_dictionary["is_minimum_flag"] = is_minimum_flag
	# =============================== DO NOT EDIT ABOVE THIS LINE ============================== #
	return data_dictionary
end
