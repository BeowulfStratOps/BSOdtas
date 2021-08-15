#include "islandspecific.hpp"

private ["_attackerPrimary", "_attackerMagazine", "_attackerGrenade", "_attackerSmoke", "_attackerColorSmoke", "_attackerAttachments", "_attackerHelm", "_attackerUniform", "_attackerVest", "_attackerBackpack", "_attackerGlobalBackpack", "_attackerGlasses", "_defenderPrimary", "_defenderMagazine", "_defenderGrenade", "_defenderSmoke", "_defenderColorSmoke", "_defenderAttachments", "_defenderSpecOpsAttachments", "_defenderMGAttachments", "_defenderMarksmanSight","_defenderMarksmanMagazine", "_defenderMarksmanNVSight", "_defenderMarksmanAttachments", "_defenderUniform", "_defenderHelm", "_defenderHandgun", "_defenderHandgunMagazine","_attackerHandgun", "_attackerHandgunMagazine", "_attackerHandgunSuppressor", "_attackerMarksmanPrimary", "_attackerMarksmanScope", "_attackerMarksmanNVScope", "_attackerMarksmanAttachments", "_defenderBackpack", "_defenderWeakPrimary", "_defenderWeakMagazine", "_defenderGL", "_defenderGLMagazines", "_defenderMG", "_defenderMGMagazines", "_defenderVest", "_defenderSmallVest", "_attackerGL", "_attackerGLMagazines", "_attackerLMG", "_attackerLMGMagazines", "_attackerMG", "_attackerMGMagazines", "_attackerSR", "_attackerSRMagazine", "_attackerSRScope", "_attackerSRNVScope", "_attackerSniperUniform", "_attackerSniperHat", "_attackerGLVest", "_attackerMedicVest", "_attackerMGVest", "_attackerSuppressor", "_attackerHat", "_attackerHLauncher", "_attackerSMG", "_attackerSMGAttachments", "_attackerSMGMagazine", "_defenderSMG", "_defenderSMGAttachments", "_defenderSMGMagazine", "_defenderGlasses", "_attackerMGAttachments", "_attackerLMGAttachments", "_attackerLauncher", "_attackerAPRocket", "_attackerHATRocket", "_defenderLauncher", "_defenderATRocket", "_defenderAPRocket", "_defenderATRocket", "_defenderAPRocket", "_attackerLauncherAttachments", "_defenderLauncherAttachments","_defenderMarksmanPrimary","_defenderSpecOpsMagazines"];

// Default equipment, overridden below by mods where needed.

defenderNVG = "NVGoggles_OPFOR";
attackerNVG = "NVGoggles_OPFOR";

_ACEMedicalSet = [["ACE_fieldDressing",6],["ACE_morphine",2],["ACE_personalAidKit",1]];

_attackerPrimary = "arifle_MX_F";
_attackerMagazine = "30Rnd_65x39_caseless_mag";
_attackerGrenade = "HandGrenade";
_attackerSmoke = "SmokeShell";
_attackerColorSmoke = "SmokeShellGreen";

_attackerHandgun = "hgun_P07_F";
_attackerHandgunMagazine = "16Rnd_9x21_Mag";
_attackerHandgunSuppressor = "muzzle_snds_L";

_attackerMarksmanPrimary = _attackerPrimary;
_attackerMarksmanScope = "optic_Hamr";
_attackerMarksmanNVScope = "optic_NVS";
_attackerMarksmanAttachments = [if (nightVision > 0) then {"optic_NVS"} else {"optic_Hamr"}, "acc_pointer_IR"];

_attackerAttachments = ["optic_Holosight", "acc_pointer_IR"];
if (nightVision == 0) then
{
	_attackerAttachments set [1, "acc_flashlight"];
};

_attackerSMG = "SMG_02_F";
_attackerSMGAttachments = ["optic_Holosight_smg", "muzzle_snds_L"];
_attackerSMGMagazine = "30Rnd_9x21_Mag";

_attackerGL = "arifle_MX_GL_F";
_attackerGLMagazines = [["1Rnd_HE_Grenade_shell", 10], ["1Rnd_SmokeGreen_Grenade_shell", 4], ["UGL_FlareWhite_F", if (nightVision == 0) then {8} else {0}], [_attackerHandgunMagazine, 3]];

_attackerLMG = "LMG_Mk200_F";
_attackerLMGMagazines = ["200Rnd_65x39_cased_Box", 3];
_attackerLMGAttachments = _attackerAttachments;

_attackerMG = "LMG_Zafir_F";
_attackerMGMagazines = ["150Rnd_762x54_Box", 3];
_attackerMGAttachments = _attackerAttachments - [_attackerAttachments select 0];

_attackerSR = "srifle_LRR_F";
_attackerSRMagazine = "7Rnd_408_Mag";
_attackerSRScope = "optic_SOS";
_attackerSRNVScope = "optic_NVS";
_attackerSniperUniform = "U_B_GhillieSuit";
_attackerSniperHat = "";

_attackerSuppressor = "muzzle_snds_H";

_attackerHat = "H_Booniehat_mcamo";

_attackerLauncher = "launch_RPG32_F";
_attackerAPRocket = "RPG32_HE_F";
_attackerLauncherAttachments = [];

_attackerHLauncher = "launch_B_Titan_short_F";
_attackerHATRocket = "Titan_AP";

_attackerHelm = "H_HelmetB";
_attackerUniform = "U_B_CombatUniform_mcam";
_attackerVest = "V_PlateCarrier3_rgr";
_attackerBackpack = "B_AssaultPack_cbr";
_attackerGlobalBackpack = "";
_attackerGlasses = "";

_defenderUniform = selectRandom  ["U_BG_Guerrilla_6_1","U_BG_Guerilla1_1","U_BG_Guerilla2_2","U_BG_Guerilla2_1","U_BG_Guerilla2_3","U_BG_Guerilla3_1","U_BG_leader"];
_defenderHelm = "rhs_ssh68_2";//"H_ShemagOpen_khk";
_defenderGlasses = "";
_defenderPrimary = "arifle_Mk20_F";
_defenderMagazine = "30Rnd_556x45_Stanag";
_defenderGrenade = _attackerGrenade;
_defenderSmoke = "SmokeShell";
_defenderColorSmoke = "SmokeShellBlue";
_defenderWeakPrimary = "arifle_Mk20C_F";
_defenderWeakMagazine = "30Rnd_556x45_Stanag";

_defenderHandgun = "hgun_Rook40_F";
_defenderHandgunMagazine = "16Rnd_9x21_Mag";

_defenderGL = "arifle_Mk20_GL_F";
_defenderGLMagazines = [["1Rnd_HE_Grenade_shell", 4 + 2 * defenderGearQuality], ["1Rnd_SmokeBlue_Grenade_shell", 3]];
if ((nightVision >= 0) && (nightVision < 2)) then
{
	_defenderGLMagazines = _defenderGLMagazines + [["UGL_FlareWhite_F", 5]];
};
_defenderMG = "arifle_MX_SW_Black_F";
_defenderMGMagazines = ["100Rnd_65x39_caseless_mag", 3 + defenderGearQuality];

_defenderVest = "V_TacVest_blk";//"V_BandollierB_blk";
_defenderSmallVest = _defenderVest;
_defenderBackpack = "UK3CB_CHC_C_B_HIKER";
_defenderAttachments = if (nightVision >= 0) then {["acc_flashlight"]} else {[]};

_defenderSpecOpsPrimary = _defenderPrimary;
_defenderSpecOpsAttachments = _defenderAttachments + ["optic_ACO_grn"];

_defenderSMG = "SMG_02_F";
_defenderSMGAttachments = ["optic_ACO_grn_smg"];
_defenderSMGMagazine = "30Rnd_9x21_Mag";

_defenderLauncher = _attackerLauncher;
_defenderATRocket = "RPG32_F";
_defenderAPRocket = _attackerAPRocket;
_defenderLauncherAttachments = [];

_defenderMGAttachments = _defenderAttachments;

_defenderMarksmanPrimary = _defenderPrimary;
_defenderMarksmanSight = "Optic_ARCO";
_defenderMarksmanNVSight = "optic_NVS";
_defenderMarksmanAttachments = _defenderAttachments + [_defenderMarksmanSight];
if (nightVision > 1) then
{
	_defenderMarksmanAttachments = _defenderAttachments + [_defenderMarksmanNVSight];
};

if (defenderGearQuality > 0) then
{
	_defenderVest = "V_Chestrig_blk";
	
	_defenderSpecOpsAttachments = _defenderSpecOpsAttachments + ["muzzle_snds_M"];
	
	_defenderAttachments = _defenderAttachments + ["optic_ACO_grn"];
	
	_defenderSMGAttachments = ["optic_ACO_grn_smg", "muzzle_snds_L"];
};

if (attackerFaction < 4) then
{
	attackerNVG = "rhsusf_ANPVS_14";
	if (nightVision > 1) then
	{
		attackerNVG = "rhsusf_ANPVS_15";
	};
	
	_attackerLauncher = "rhs_weap_rpg7";
	_attackerAPRocket = "rhs_rpg7_OG7V_mag";
	_attackerLauncherAttachments = ["rhs_acc_pgo7v"];
};

// IDF equipment.
if (attackerFaction == 0) then
{
	_attackerHelm = "IDF_Helmet_CQB_Golani";
	_attackerUniform = "IDF_Uniform";
	_attackerGlobalBackpack = "IDF_Backpack";
	_attackerBackpack = _attackerGlobalBackpack;
	_attackerVest = "IDF_Vest";
	_attackerPrimary = "idf_x95m";
	_attackerAttachments = [""];
	_attackerMarksmanPrimary = "idf_x95";
	_attackerMarksmanScope = "rhsusf_acc_ACOG2_USMC";
	_attackerMarksmanAttachments = [if (nightVision > 0) then {"optic_NVS"} else {_attackerMarksmanScope}];
	_attackerSMGAttachments = ["IDF_optic_Mars", "rhsusf_acc_anpeq15", "muzzle_snds_L"];
	if (nightVision == 0) then
	{
		_attackerAttachments set [1, "rhsusf_acc_anpeq15_light"];
		_attackerMarksmanAttachments set [1, "rhsusf_acc_anpeq15_light"];
		_attackerSMGAttachments set [1, "rhsusf_acc_anpeq15_light"];
	};
	
	_attackerMagazine = "30Rnd_556x45_Stanag";
	
	_attackerGL = "arifle_TRG21_black_GL_F";
	_attackerGLMagazines = [["1Rnd_HE_Grenade_shell", 10], ["1Rnd_SmokeGreen_Grenade_shell", 4], ["UGL_FlareWhite_F", if (nightVision == 0) then {10} else {0}], [_attackerHandgunMagazine, 3]];
	
	_attackerSuppressor = "rhsusf_acc_nt4_black";
	_attackerSniperUniform = _attackerUniform;
	_attackerSR = "rhs_weap_XM2010";
	_attackerSRMagazine = "rhsusf_5Rnd_300winmag_xm2010";
	_attackerSRScope = "rhsusf_acc_leupoldmk4_2_mrds";
	if (nightVision > 0) then
	{
		_attackerSRScope = _attackerSRNVScope;
	};
	
	_attackerHat = "IDF_Cap_Golani";
	_attackerSniperHat = _attackerHat;
	_attackerHLauncher = "launch_I_Titan_short_F";
};

_attackerGLVest = _attackerVest;
_attackerMedicVest = _attackerVest;
_attackerMGVest = _attackerVest;

// US equipment
if (attackerFaction == 1 || attackerFaction == 2) then
{
	_attackerUniform = "rhs_uniform_g3_m81";//"rhs_uniform_cu_ocp";
	_attackerHelm = "rhsusf_ach_bare_semi_headset_ess";//"rhsusf_ach_helmet_headset_ocp";
	_attackerVest = "rhsusf_mbav_rifleman";//"rhsusf_iotv_ocp_Rifleman";
	_attackerBackpack = "B_AssaultPack_cbr";//"rhsusf_assault_eagleaiii_ocp";
	_attackerGlobalBackpack = _attackerBackpack;
	_attackerHat = "H_Cap_headphones";//"rhs_Booniehat_ocp";
	
	_attackerGLVest = "rhsusf_mbav_grenadier";//"rhsusf_iotv_ocp_Grenadier";
	_attackerMedicVest = "rhsusf_mbav_medic";//"rhsusf_iotv_ocp_Medic";
	_attackerMGVest = "rhsusf_mbav_mg";//"rhsusf_iotv_ocp_SAW";
	
	_attackerSR = "rhs_weap_XM2010_sa";
	_attackerSRMagazine = "rhsusf_5Rnd_300winmag_xm2010";
	_attackerSRScope = "rhsusf_acc_leupoldmk4_2_mrds";
	
	_attackerLauncher = "rhs_weap_maaws";
	_attackerAPRocket = "rhs_mag_maaws_HEDP";
	_attackerLauncherAttachments = ["rhs_optic_maaws"];
	
	if (nightVision > 0) then
	{
		_attackerSRScope = _attackerSRNVScope;
	};
	
	if (attackerFaction == 2) then
	{
		_attackerUniform = "rhs_uniform_cu_ucp";
		_attackerHelm = "rhsusf_ach_helmet_headset_ucp";
		_attackerVest = "rhsusf_iotv_ucp_Rifleman";
		_attackerBackpack = "rhsusf_assault_eagleaiii_ucp";
		_attackerGlobalBackpack = _attackerBackpack;
		_attackerHat = "rhs_Booniehat_ucp";
		
		_attackerGLVest = "rhsusf_iotv_ucp_Grenadier";
		_attackerMedicVest = "rhsusf_iotv_ucp_Medic";
		_attackerMGVest = "rhsusf_iotv_ucp_SAW";
	};
	
	_attackerPrimary = "rhs_weap_mk18_d";//"rhs_weap_m4a1_grip";
	_attackerMagazine = "rhs_mag_30Rnd_556x45_M855A1_PMAG";
	
	_attackerAttachments = ["rhsusf_acc_t1_high","rhsusf_acc_anpeq15_wmx","rhsusf_acc_grip2_tan"];//["rhsusf_acc_eotech_552", "rhsusf_acc_anpeq15"];
	
	_attackerMarksmanPrimary = "rhs_weap_m4a1_grip";
	_attackerMarksmanScope = "rhsusf_acc_su230_c";
	_attackerMarksmanAttachments = [if (nightVision > 0) then {_attackerMarksmanNVScope} else {_attackerMarksmanScope}, "rhsusf_acc_anpeq15"];
	
	_attackerLMG = "rhs_weap_m249_light_S";
	_attackerLMGMagazines = ["rhsusf_200Rnd_556x45_mixed_soft_pouch_coyote", 3];
	_attackerLMGAttachments = ["rhsusf_acc_anpeq15side"];
	_attackerMG = "rhs_weap_m240B_CAP";
	_attackerMGMagazines = ["rhsusf_50Rnd_762x51", 6];
	_attackerMGAttachments = [""];
	
	if (nightVision == 0) then
	{
		_attackerAttachments set [1, "rhsusf_acc_anpeq15_wmx"];
		_attackerMarksmanAttachments set [1, "rhsusf_acc_anpeq15_wmx"];
	};
	
	_attackerSuppressor = "rhsusf_acc_nt4_tan";
	
	_attackerSMG = "rhsusf_weap_MP7A2_desert";
	_attackerSMGAttachments = ["rhsusf_acc_t1_high", "rhsusf_acc_anpeq16a","rhsusf_acc_rotex_mp7_desert"];
	_attackerSMGMagazine = "rhsusf_mag_40Rnd_46x30_FMJ";
	
	
	_attackerGL = "rhs_weap_mk18_m320";
	_attackerGLMagazines = [["rhs_mag_M441_HE", 10], ["rhs_mag_m715_Green", 4], ["rhs_mag_M585_white", if (nightVision == 0) then {10} else {0}], [_attackerHandgunMagazine, 3]];
};

if (attackerFaction == 3) then
{
	_attackerUniform = "rhs_uniform_vdv_emr";
	_attackerHelm = "rhs_6b28";	
	_attackerVest = "rhs_6b23_digi_6sh92_headset";
	_attackerBackpack = "rhs_sidor";
	_attackerGlobalBackpack = "rhs_sidor";
	_attackerHat = "rhs_fieldcap_digi";
	
	_attackerMedicVest = "rhs_6b23_digi_medic";
	_attackerMGVest = _attackerVest;
	
	_attackerPrimary = "rhs_weap_ak74m";
	_attackerMagazine = "rhs_30Rnd_545x39_AK";
	_attackerGrenade = "rhs_mag_rgd5";
	_attackerSmoke = "rhs_mag_rdg2_white";
	_attackerColorSmoke = _attackerSmoke;
	_attackerHandgun = "rhs_weap_pya";
	_attackerHandgunMagazine = "rhs_mag_9x19_17";
	_attackerHandgunSuppressor = "";
	_attackerSuppressor = "rhs_acc_tgpa";
	_attackerAttachments = ["rhs_acc_ekp1"];
	_attackerLMGAttachments = _attackerAttachments;
	
	_attackerSMGAttachments = ["optic_Aco_smg", if (nightVision == 0) then {"acc_flashlight"} else {"acc_pointer_IR"}, "muzzle_snds_L"];
	
	_attackerGL = "rhs_weap_ak74m_gp25";
	_attackerGLMagazines = [["rhs_VOG25", 10], ["rhs_GRD40_Red", 4], ["rhs_VG40OP_white", if (nightVision == 0) then {10} else {0}], [_attackerHandgunMagazine, 3]];
	_attackerGLVest = "rhs_6b23_digi_6sh92_vog_headset";
	
	_attackerMarksmanPrimary = _attackerPrimary;
	_attackerMarksmanScope = "rhs_acc_pso1m2";
	_attackerMarksmanNVScope = "rhs_acc_1pn93_1";
	_attackerMarksmanAttachments = [if (nightVision > 0) then {_attackerMarksmanNVScope} else {_attackerMarksmanScope}];
	
	_attackerLMG = _attackerPrimary;
	_attackerLMGMagazines = ["rhs_45Rnd_545X39_AK", 7];
	_attackerMG = "rhs_weap_pkp";
	_attackerMGMagazines = ["rhs_100Rnd_762x54mmR", 3];
	
	_attackerSR = "rhs_weap_svdp";
	_attackerSRMagazine = "rhs_10Rnd_762x54mmR_7N1";
	_attackerSRScope = "rhs_acc_pso1m2";
	_attackerSRNVScope = "rhs_acc_1pn93_1";
	_attackerSniperUniform = _attackerUniform;
	_attackerSniperHat = _attackerHat;
	
	_attackerHLauncher = "launch_I_Titan_short_F";
};

if (defenderFaction == 1) then
{
	_defenderPrimary = "hlc_rifle_ak47";
	_defenderMagazine = "hlc_30Rnd_762x39_b_ak";
	_defenderWeakPrimary = "hlc_rifle_ak74";
	_defenderWeakMagazine = "hlc_30Rnd_545x39_B_AK";
	_defenderGL = "hlc_rifle_aks74_GL";
	_defenderGLMagazines = [["hlc_VOG25_AK", 4 + 2 * defenderGearQuality], ["hlc_GRD_blue", 3]];
	_defenderMG = "hlc_rifle_rpk";
	_defenderMGMagazines = ["hlc_75Rnd_762x39_m_rpk", 5];
	_defenderAttachments = if (nightVision >= 0) then {["acc_flashlight"]} else {[]};
	_defenderMGAttachments = _defenderAttachments;
	_defenderSpecOpsPrimary = _defenderPrimary;
	_defenderSpecOpsAttachments = _defenderAttachments + ["hlc_optic_kobra"];
	_defenderSpecOpsMagazines = _defenderWeakMagazine;
	
	_defenderMarksmanPrimary = _defenderPrimary;
	_defenderMarksmanSight = "HLC_Optic_PSO1";
	_defenderMarksmanAttachments = _defenderAttachments + [_defenderMarksmanSight];
	if (nightVision > 1) then
	{
		_defenderMarksmanAttachments = _defenderAttachments + [_defenderMarksmanNVSight];
	};
	if (defenderGearQuality > 0) then
	{
		_defenderSpecOpsAttachments = _defenderSpecOpsAttachments + ["hlc_muzzle_762SUP_AK"];
		_defenderAttachments = _defenderAttachments + ["hlc_optic_kobra"];
	};
};

if (defenderFaction == 0 || defenderFaction == 2) then
{
	defenderNVG = "rhsusf_ANPVS_14";
	
	_defenderPrimary = "rhs_weap_aks74";//"rhs_weap_akm";
	_defenderWeakPrimary = "rhs_weap_aks74u";
	_defenderMagazine = "rhs_30Rnd_545x39_7N6M_AK";
	_defenderWeakMagazine = _defenderMagazine;
	_defenderHandgun = "sp_fwa_l9a1_hipower_wood";
	_defenderHandgunMagazine = "sp_fwa_13Rnd_9mm_HiPower";
	_defenderGrenade = "rhs_mag_rgd5";
	_defenderSmoke = "rhs_mag_rdg2_white";
	_defenderColorSmoke = _defenderSmoke;
	_defenderAttachments = [];
	_defenderMGAttachments = [];

	_defenderMG = "rhs_weap_rpk74m";
	_defenderMGMagazines = ["rhs_45Rnd_545X39_AK", 6 + 2 * defenderGearQuality];
	
	_defenderGL = "rhs_weap_aks74_gp25";
	_defenderGLMagazines = [["rhs_VOG25", 4 + 2 * defenderGearQuality], ["rhs_GRD40_Red", 3]];
	
	_defenderLauncher = "rhs_weap_rpg7";
	_defenderATRocket = "rhs_rpg7_PG7VL_mag";
	_defenderAPRocket = "rhs_rpg7_OG7V_mag";
	_defenderrLauncherAttachments = ["rhs_acc_pgo7v"];
	
	if ((nightVision >= 0) && (nightVision < 2)) then
	{
		_defenderGLMagazines = _defenderGLMagazines + [["rhs_VG40OP_white", 5]];
	};
	
	_defenderSpecOpsPrimary = "rhs_weap_aks74un";
	_defenderSpecOpsAttachments = ["rhs_acc_ekp1c"];
	_defenderSpecOpsMagazines = "rhs_30Rnd_545x39_7N10_AK";
	
	if (defenderGearQuality > 0) then
	{
		_defenderSpecOpsAttachments = _defenderSpecOpsAttachments + ["rhs_acc_pbs4"];
		_defenderSpecOpsMagazines = "rhs_30Rnd_545x39_7U1_AK";
	};
	
	_defenderMarksmanPrimary = "sp_fwa_mas_49_56";
	_defenderMarksmanSight = "sp_fwa_acc_mas_scope";
	_defenderMarksmanNVSight = "sp_fwa_acc_mas_scope";
	_defenderMarksmanMagazine = "sp_fwa_10rnd_75_mas49_tracer";
	
	_defenderSMG = "sp_fwa_smg_mat49";
	_defenderSMGAttachments = [];
	_defenderSMGMagazine = "sp_fwa_32Rnd_9x19_MAT49";
	
	_defenderMarksmanAttachments = _defenderAttachments + [_defenderMarksmanSight];
	if (nightVision > 0) then
	{
		_defenderMarksmanAttachments = _defenderAttachments + [_defenderMarksmanNVSight];
	};
};

if (defenderFaction == 0) then
{
	_defenderUniform = "HAMAS_Uniform_rpk";
	_defenderHelm = "";
	_defenderGlasses = "HAMAS_balaclava";
};


aClasses =
[
	// 0:Description
	// 1:Uniform
	// 2:Vest
	// 3:Backpack
	// 4:Helmet
	// 5:Eyewear
	// 6:Weapons,
	// 7:Magazines
	// 8:Items
	// 9:Primary weapon attachments
	// 10:Secondary weapon attachments.
	// 11:Handgun Attachments
	// 12:Init code
	// 13:Condition
	[
		localize "STR_Marksman"
		,_attackerUniform
		,_attackerVest
		,_attackerBackpack//if (attackerFaction == 0) then {_attackerGlobalBackpack} else {""}
		,_attackerHelm
		,_attackerGlasses
		,[_attackerMarksmanPrimary, _attackerHandgun]
		,[[_attackerMagazine, 7], [_attackerGrenade, 1], [_attackerSmoke, 1], [_attackerHandgunMagazine, 3]]
		,_ACEMedicalSet + [["ACE_DefusalKit",1],[_attackerMarksmanScope, if (_attackerMarksmanScope in _attackerMarksmanAttachments) then {0} else {1}]]
		,_attackerMarksmanAttachments
		,[]
		,[]
		,{}
		,"true"
	]

	,[
		localize "STR_Rifleman"
		,_attackerUniform
		,_attackerVest
		,_attackerBackpack//if (attackerFaction == 0) then {_attackerGlobalBackpack} else {""}
		,_attackerHelm
		,_attackerGlasses
		,[_attackerPrimary, _attackerHandgun]
		,[[_attackerMagazine, 9], [_attackerGrenade, 3], [_attackerSmoke, 2], [_attackerColorSmoke, 1], [_attackerHandgunMagazine, 4]]
		,_ACEMedicalSet + [["ACE_DefusalKit",1]]
		,_attackerAttachments
		,[]
		,[_attackerHandgunSuppressor]
		,{}
		,"true"
	]
	
	,[
		localize "STR_SuppressedRifleman"
		,_attackerUniform
		,_attackerVest
		,_attackerBackpack
		,_attackerHelm
		,_attackerGlasses
		,[_attackerPrimary, _attackerHandgun]
		,[[_attackerMagazine, 7], [_attackerGrenade, 1], [_attackerSmoke, 1], [_attackerColorSmoke, 1], [_attackerHandgunMagazine, 3]]
		,_ACEMedicalSet + [["ACE_DefusalKit",1]]
		,_attackerAttachments + [_attackerSuppressor]
		,[]
		,[]
		,{}
		,"true"
	]
	
	,[
		localize "STR_SuppressedSMG"
		,_attackerUniform
		,_attackerVest
		,_attackerBackpack
		,_attackerHelm
		,_attackerGlasses
		,[_attackerSMG, _attackerHandgun]
		,[[_attackerSMGMagazine, 7], [_attackerGrenade, 1], [_attackerSmoke, 1], [_attackerColorSmoke, 1], [_attackerHandgunMagazine, 3]]
		,_ACEMedicalSet + [["ACE_DefusalKit",1]]
		,_attackerSMGAttachments
		,[]
		,[]
		,{}
		,"true"
	]
	
	,[
		localize "STR_Medic"
		,_attackerUniform
		,_attackerMedicVest
		,_attackerBackpack//if (attackerFaction == 0 || attackerFaction == 3) then {_attackerGlobalBackpack} else {""}
		,_attackerHelm
		,_attackerGlasses
		,[_attackerPrimary, _attackerHandgun]
		,[[_attackerMagazine, 7], [_attackerGrenade, 1], [_attackerSmoke, 1], [_attackerColorSmoke, 2], [_attackerHandgunMagazine, 3]]
		,_ACEMedicalSet + [["ACE_fieldDressing",10],["ACE_morphine",6],["ACE_personalAidKit",8]]
		,_attackerAttachments
		,[]
		,[]
		,{isMedic = true;}
		,"true"
	]
	
	,[
		localize "STR_Grenadier"
		,_attackerUniform
		,_attackerGLVest
		,_attackerBackpack//if ((attackerFaction == 0) || ((attackerFaction == 3) && (nightVision == 0))) then {_attackerGlobalBackpack} else {""}
		,_attackerHelm
		,_attackerGlasses
		,[_attackerGL, _attackerHandgun]
		,[[_attackerMagazine, 7], [_attackerGrenade, 1], [_attackerSmoke, 1]] + _attackerGLMagazines
		,_ACEMedicalSet + [["ACE_DefusalKit",1]]
		,if (attackerFaction == 0) then {["IDF_optic_Mars"]} else {_attackerAttachments}
		,[]
		,[]
		,{}
		,"true"
	]
	
	,[
		localize "STR_AutomaticRifleman"
		,_attackerUniform
		,_attackerMGVest
		,_attackerBackpack//if (attackerFaction == 0) then {_attackerGlobalBackpack} else {""}
		,_attackerHelm
		,_attackerGlasses
		,[_attackerLMG, _attackerHandgun]
		,[_attackerLMGMagazines, [_attackerGrenade, 1], [_attackerSmoke, 1], [_attackerHandgunMagazine, 3]]
		,_ACEMedicalSet + [["ACE_personalAidKit", 1]]
		,_attackerLMGAttachments
		,[]
		,[]
		,{}
		,"attackerFaction > 0"
	]
	
	,[
		localize "STR_Machinegunner"
		,_attackerUniform
		,_attackerMGVest
		,_attackerBackpack//if (attackerFaction == 0) then {_attackerGlobalBackpack} else {""}
		,_attackerHelm
		,_attackerGlasses
		,[_attackerMG, _attackerHandgun]
		,[_attackerMGMagazines, [_attackerGrenade, 0], [_attackerSmoke, 0], [_attackerHandgunMagazine, 2]]
		,_ACEMedicalSet
		,_attackerMGAttachments
		,[]
		,[]
		,{}
		,"true"
	]
	
		,[
		localize "STR_RPG_HE"
		,_attackerUniform
		,_attackerVest
		,_attackerBackpack
		,_attackerHelm
		,_attackerGlasses
		,[_attackerPrimary, _attackerLauncher, _attackerHandgun]
		,[[_attackerAPRocket, 1], [_attackerMagazine, 7], [_attackerGrenade, 1], [_attackerSmoke, 1], [_attackerHandgunMagazine, 3]]
		,_ACEMedicalSet
		,_attackerAttachments
		,_attackerLauncherAttachments
		,[]
		,{}
		,"true"
	]
	
	,[
		localize "STR_AssistantRPG"
		,_attackerUniform
		,_attackerVest
		,_attackerBackpack
		,_attackerHelm
		,_attackerGlasses
		,[_attackerPrimary, _attackerHandgun]
		,[[_attackerAPRocket, 3], [_attackerMagazine, 7], [_attackerGrenade, 1], [_attackerSmoke, 2], [_attackerHandgunMagazine, 3]]
		,_ACEMedicalSet
		,_attackerAttachments
		,[]
		,[]
		,{}
		,"true"
	]
	
	,[
		localize "STR_Titan_HE"
		,_attackerUniform
		,_attackerVest
		,_attackerBackpack
		,_attackerHelm
		,_attackerGlasses
		,[_attackerPrimary, _attackerHandgun, _attackerHLauncher]
		,[[_attackerHATRocket, 1], [_attackerMagazine, 7], [_attackerSmoke, 1], [_attackerHandgunMagazine, 3]]
		,_ACEMedicalSet
		,_attackerAttachments
		,[]
		,[]
		,{}
		,"true"
	]
	
	,[
		localize "STR_AssistantTitan"
		,_attackerUniform
		,_attackerVest
		,_attackerBackpack
		,_attackerHelm
		,_attackerGlasses
		,[_attackerPrimary, _attackerHandgun]
		,[[_attackerHATRocket, 2], [_attackerMagazine, 7], [_attackerGrenade, 1], [_attackerSmoke, 2], [_attackerHandgunMagazine, 3]]
		,_ACEMedicalSet
		,_attackerAttachments
		,[]
		,[]
		,{}
		,"true"
	]
	
	,[
		localize "STR_Sniper"
		,_attackerSniperUniform
		,"V_Chestrig_rgr"
		,_attackerBackpack
		,_attackerSniperHat
		,""
		,[_attackerSR, _attackerHandgun]
		,[[_attackerSRMagazine, 11], [_attackerSmoke, 1], [_attackerColorSmoke, 1], [_attackerHandgunMagazine, 3]]
		,_ACEMedicalSet + [["ACE_RangeCard",1],["ACE_Kestrel4500",1],[_attackerSRScope, if (nightVision > 0 && _attackerSRNVScope != _attackerSRScope) then {1} else {0}]]
		,if (nightVision > 0) then {[_attackerSRNVScope]} else {[_attackerSRScope]}
		,[]
		,[]
		,{}
		,"true"
	]
	
	,[
		localize "STR_Spotter"
		,_attackerSniperUniform
		,"V_Chestrig_rgr"
		,_attackerBackpack
		,_attackerSniperHat
		,""
		,[_attackerPrimary, "Rangefinder", _attackerHandgun]
		,[[_attackerMagazine, 7], [_attackerGrenade, 1], [_attackerSmoke, 3], [_attackerColorSmoke, 1], [_attackerHandgunMagazine, 3]]
		,_ACEMedicalSet + [["ACE_RangeCard",1],["ACE_Kestrel4500",1]]
		,_attackerAttachments
		,[]
		,[_attackerHandgunSuppressor]
		,{}
		,"true"
	]
	
	,[
		localize "STR_UAVOperator"
		,_attackerUniform
		,"V_BandollierB_rgr"
		,if (sidePlayer == WEST) then {"B_UAV_01_backpack_F"} else {"O_UAV_01_backpack_F"}
		,_attackerHat
		,""
		,[_attackerPrimary, if (sidePlayer == WEST) then {"B_UavTerminal"} else {"O_UavTerminal"}, _attackerHandgun]
		,[[_attackerMagazine, 7], [_attackerHandgunMagazine, 3]]
		,_ACEMedicalSet
		,_attackerAttachments
		,[]
		,[]
		,{}
		,"true"
	]
	
	,[
		localize "STR_Diver"
		,"U_B_Wetsuit"
		,"V_RebreatherB"
		,_attackerBackpack
		,""
		,"G_Diving"
		,["arifle_SDAR_F", _attackerHandgun]
		,[["30Rnd_556x45_Stanag", 5], ["20Rnd_556x45_UW_mag", 2], [_attackerGrenade, 2], [_attackerSmoke, 1], [_attackerHandgunMagazine, 2]]
		,_ACEMedicalSet
		,[]
		,[]
		,[_attackerHandgunSuppressor]
		,{}
		,"true"
	]

	,[
		localize "STR_Para"
		,_attackerUniform
		,_attackerVest
		,"B_Parachute"
		,_attackerHelm
		,_attackerGlasses
		,[_attackerPrimary]
		,[[_attackerMagazine, 7], [_attackerGrenade, 2], [_attackerSmoke, 1], [_attackerColorSmoke, 1]]
		,_ACEMedicalSet + [["ACE_DefusalKit",1]]
		,_attackerAttachments
		,[]
		,[_attackerHandgunSuppressor]
		,{}
		,"true"
	]

];

dClasses =
[
	// 0:Description
	// 1:Uniform
	// 2:Vest
	// 3:Backpack
	// 4:Helmet
	// 5:Eyewear
	// 6:Weapons,
	// 7:Magazines
	// 8:Items
	// 9:Primary weapon attachments
	// 10:Secondary weapon attachments.
	// 11:Handgun Attachments
	// 12:Init code
	// 13:Condition
	
	[
		localize "STR_SpecOps"
		,_defenderUniform
		,"V_TacVest_blk"
		,_defenderBackpack
		,_defenderHelm
		,_defenderGlasses
		,[_defenderSpecOpsPrimary]
		,[[_defenderSpecOpsMagazines, 6 + defenderGearQuality], [_defenderGrenade, 1], [_defenderSmoke, 2]]
		,_ACEMedicalSet
		,_defenderSpecOpsAttachments
		,[]
		,[]
		,{}
		,"true"
	]

	,[
		localize "STR_Rifleman"
		,_defenderUniform
		,"V_Chestrig_blk"
		,_defenderBackpack
		,_defenderHelm
		,_defenderGlasses
		,[_defenderPrimary]
		,[[_defenderMagazine, 7 + 2 * defenderGearQuality], [_defenderGrenade, 3], [_defenderSmoke, 3]]
		,_ACEMedicalSet
		,_defenderAttachments
		,[]
		,[]
		,{}
		,"true"
	]
	
	,[
		localize "STR_SpecOpsSMG"
		,_defenderUniform
		,"V_TacVest_blk"
		,_defenderBackpack
		,_defenderHelm
		,_defenderGlasses
		,[_defenderSMG]
		,[[_defenderSMGMagazine, 6 + defenderGearQuality], [_defenderGrenade, 1], [_defenderSmoke, 2]]
		,_ACEMedicalSet
		,_defenderSMGAttachments
		,[]
		,[]
		,{}
		,"true"
	]
	
	,[
		localize "STR_Medic"
		,_defenderUniform
		,if (defenderFaction == 1) then {"V_Chestrig_blk"} else {_defenderVest}
		,_defenderBackpack
		,_defenderHelm
		,_defenderGlasses
		,[_defenderWeakPrimary]
		,[[_defenderWeakMagazine, 6 + defenderGearQuality], [_defenderGrenade, 1 + defenderGearQuality], [_defenderSmoke, 1 + defenderGearQuality], [_defenderColorSmoke, 1]]
		,_ACEMedicalSet + [["ACE_fieldDressing",10],["ACE_morphine",6],["ACE_personalAidKit",8]]
		,_defenderAttachments
		,[]
		,[]
		,{isMedic = true;}
		,"true"
	]
	
	,[
		localize "STR_AutomaticRifleman"
		,_defenderUniform
		,if (defenderFaction == 1) then {"V_Chestrig_blk"} else {_defenderVest}
		,_defenderBackpack
		,_defenderHelm
		,_defenderGlasses
		,[_defenderMG]
		,[_defenderMGMagazines, [_defenderGrenade, if (defenderFaction < 3) then {1} else {0}], [_defenderSmoke, defenderGearQuality + (if (defenderFaction < 3) then {1} else {0})]]
		,_ACEMedicalSet
		,_defenderMGAttachments
		,[]
		,[]
		,{}
		,"true"
	]
	
	,[
		localize "STR_Grenadier"
		,_defenderUniform
		,_defenderVest
		,_defenderBackpack
		,_defenderHelm
		,_defenderGlasses
		,[_defenderGL]
		,[[_defenderWeakMagazine, 6 + defenderGearQuality], [_defenderSmoke, defenderGearQuality]] + _defenderGLMagazines
		,_ACEMedicalSet
		,_defenderAttachments
		,[]
		,[]
		,{}
		,"true"
	]
		
	,[
		localize "STR_RPG"
		,_defenderUniform
		,_defenderSmallVest
		,_defenderBackpack
		,_defenderHelm
		,_defenderGlasses
		,[_defenderWeakPrimary, _defenderLauncher]
		,[[_defenderATRocket, 1], [_defenderWeakMagazine, 6 + defenderGearQuality], [_defenderSmoke, 1 + defenderGearQuality]]
		,_ACEMedicalSet
		,_defenderAttachments
		,_defenderLauncherAttachments
		,[]
		,{}
		,"true"
	]
	
	,[
		localize "STR_RPG_HE"
		,_defenderUniform
		,_defenderSmallVest
		,_defenderBackpack
		,_defenderHelm
		,_defenderGlasses
		,[_defenderWeakPrimary, _defenderLauncher]
		,[[_defenderAPRocket, 1], [_defenderWeakMagazine, 6 + defenderGearQuality], [_defenderSmoke, 1 + defenderGearQuality]]
		,_ACEMedicalSet
		,_defenderAttachments
		,_defenderLauncherAttachments
		,[]
		,{}
		,"defenderGearQuality > 0"
	]
	
	,[
		localize "STR_AssistantRPG"
		,_defenderUniform
		,_defenderSmallVest
		,_defenderBackpack
		,_defenderHelm
		,_defenderGlasses
		,[_defenderPrimary]
		,[[_defenderATRocket, 1], [_defenderAPRocket, 2 + defenderGearQuality], [_defenderMagazine, 6 + defenderGearQuality], [_defenderGrenade, 1], [_defenderSmoke, 1 + defenderGearQuality]]
		,_ACEMedicalSet
		,_defenderAttachments
		,[]
		,[]
		,{}
		,"true"
	]

	,[
		localize "STR_Saboteur"
		,_defenderUniform
		,_defenderVest
		,_defenderBackpack
		,_defenderHelm
		,_defenderGlasses
		,[_defenderWeakPrimary]
		,[[_defenderWeakMagazine, 6 + defenderGearQuality], ["APERSTripMine_Wire_Mag", 1 + defenderGearQuality], ["ClaymoreDirectionalMine_Remote_Mag", 1],  [_defenderSmoke, 1]]
		,_ACEMedicalSet + [["ACE_Clacker",1],["ACE_DefusalKit",1]]
		,_defenderAttachments
		,[]
		,[]
		,{}
		,"true"
	]
	
	,[
		localize "STR_Marksman"
		,_defenderUniform
		,_defenderSmallVest
		,_defenderBackpack
		, _defenderHelm
		,_defenderGlasses
		,[_defenderMarksmanPrimary, _defenderHandgun]
		,[[_defenderMarksmanMagazine, 6], [_defenderHandgunMagazine,4], [_defenderSmoke, 2]]
		,_ACEMedicalSet + [["ACE_RangeCard",1],["ACE_Kestrel4500",1],[_defenderMarksmanSight, if (_defenderMarksmanSight in _defenderMarksmanAttachments) then {0} else {1}]]
		,_defenderMarksmanAttachments
		,[]
		,[]
		,{}
		,"true"
	]	
	
	
];

if (defenderGearQuality > 0) then
{

	dClasses =
/*		[
			[
				localize "STR_Marksman"
				,_defenderUniform
				,_defenderSmallVest
				,_defenderBackpack
				, _defenderHelm
				,_defenderGlasses
				,[_defenderMarksmanPrimary, _defenderHandgun]
				,[[_defenderMarksmanMagazine, 6], [_defenderHandgunMagazine,4], [_defenderSmoke, 2]]
				,_ACEMedicalSet + [["ACE_RangeCard",1],["ACE_Kestrel4500",1],[_defenderMarksmanSight, if (_defenderMarksmanSight in _defenderMarksmanAttachments) then {0} else {1}]]
				,_defenderMarksmanAttachments
				,[]
				,[]
				,{}
				,"true"
			]
		]
		+
	
		dClasses
		+*/
		[
			[
				localize "STR_MortarGunner"
				,_defenderUniform
				,_defenderSmallVest
				,_defenderBackpack
				,_defenderHelm
				,_defenderGlasses
				,[_defenderWeakPrimary,"UK3CB_BAF_M6"]
				,[[_defenderWeakMagazine, 6], [_defenderSmoke, 1],["UK3CB_BAF_1Rnd_60mm_Mo_Shells",2],["UK3CB_BAF_1Rnd_60mm_Mo_WPSmoke_White",1]]
				,_ACEMedicalSet
				,[]
				,[]
				,[]
				,{}
				,"true"
			]
	
			,[
				localize "STR_MortarAssistant"
				,_defenderUniform
				,_defenderSmallVest
				,_defenderBackpack
				,_defenderHelm
				,_defenderGlasses
				,[_defenderWeakPrimary, "Rangefinder"]
				,[[_defenderWeakMagazine, 6], [_defenderSmoke, 1], [_defenderColorSmoke, 1],["UK3CB_BAF_1Rnd_60mm_Mo_Shells",4],["UK3CB_BAF_1Rnd_60mm_Mo_WPSmoke_White",2]]
				,_ACEMedicalSet
				,[]
				,[]
				,[]
				,{}
				,"true"
			]
		];
};