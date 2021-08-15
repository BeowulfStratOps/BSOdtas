// mod synchronization check to prevent bugs caused by missing critical mods that run on the server
private ["_missingAttackerModMessage", "_missingDefenderModMessage", "_attackerModsAvailable", "_defenderModsAvailable", "_defaultAttackerMod", "_defaultDefenderMod", "_attackerMissingModsMessages", "_defenderMissingModsMessages"];
missingModsMessage = "";
missingTFRMessage = "";

_attackerModsAvailable =
[
	// IDF
	isClass(configFile >> "CfgPatches" >> "IDF_helmets")
	// RHS US OCP
	,isClass(configFile >> "CfgPatches" >> "rhsusf_main")
	// RHS US UCP
	,isClass(configFile >> "CfgPatches" >> "rhsusf_main")
	// RHS RU EMR
	,isClass(configFile >> "CfgPatches" >> "rhs_main")
	,true
];

_attackerMissingModsMessages =
[
	"@IDF"
	,"@rhs_usf3"
	,"@rhs_usf3"
	,"@rhs_afrf3"
];

_defenderModsAvailable =
[
	isClass(configFile >> "CfgPatches" >> "IDF_helmets")
	,isClass(configFile >> "CfgPatches" >> "hlcweapons_aks")
	,isClass(configFile >> "CfgPatches" >> "rhs_main")
	,true
];

_defenderMissingModsMessages =
[
	"@IDF"
	,"@hlcmods_ak"
	,"@rhs_afrf3"
];

if (isServer) then
{
	attackerFaction = AttackerFactionParam;
	_defaultAttackerMod = false;
	if (AttackerFactionParam < 0) then
	{
		_defaultAttackerMod = true;
	}
	else
	{
		if (!(_attackerModsAvailable select AttackerFactionParam)) then
		{
			_defaultAttackerMod = true;
		};
	};
	if (_defaultAttackerMod) then
	{
		attackerFaction = 0;
		while {!(_attackerModsAvailable select attackerFaction)} do
		{
			attackerFaction = attackerFaction + 1;
		};
	};
	publicVariable "attackerFaction";
	
	defenderFaction = DefenderFactionParam;
	_defaultDefenderMod = false;
	if (DefenderFactionParam < 0) then
	{
		_defaultDefenderMod = true;
	}
	else
	{
		if (!(_defenderModsAvailable select DefenderFactionParam)) then
		{
			_defaultDefenderMod = true;
		};
	};
	if (_defaultDefenderMod) then
	{
		defenderFaction = 0;
		while {!(_defenderModsAvailable select defenderFaction)} do
		{
			defenderFaction = defenderFaction + 1;
		};
	};
	publicVariable "defenderFaction";
	
	// Check for TFR server/host availability.
	canHaveRadio = true;
	if (isClass(configFile >> "CfgPatches" >> "task_force_radio")) then
	{
		isTFR = true;
	}
	else
	{
		isTFR = false;
	};
	publicVariable "isTFR";
}
else
{
	_missingAttackerModMessage = "";
	waitUntil {!isNil "attackerFaction"};
	if (!(_attackerModsAvailable select attackerFaction)) then
	{
		if (missingModsMessage != "") then
		{
			missingModsMessage = missingModsMessage + ", ";
		}
		else
		{
			missingModsMessage = localize "STR_MissingMods" + " ";
		};
		missingModsMessage = missingModsMessage + (_attackerMissingModsMessages select attackerFaction);
	};
	
	waitUntil {!isNil "defenderFaction"};
	if (!(_defenderModsAvailable select defenderFaction)) then
	{
		if (missingModsMessage != "") then
		{
			missingModsMessage = missingModsMessage + ", ";
		}
		else
		{
			missingModsMessage = localize "STR_MissingMods" + " ";
		};
		missingModsMessage = missingModsMessage + (_defenderMissingModsMessages select defenderFaction);
	};
	
	// Check for TFR client availability.
	// No forcing of TFR.
	// Player will just get errors and have no radio if he doesn't run the mod, but can otherwise play.
	waitUntil {!isNil "isTFR"};
	canHaveRadio = true;
	if (isTFR && !isClass(configFile >> "CfgPatches" >> "task_force_radio")) then
	{
		canHaveRadio = false;
		// If there is already a missing mods message, add TFR to it.
		// Otherwise, have a separate message for TFR since missingModsMessage also means player can't play.
		if (missingModsMessage != "") then
		{
			missingModsMessage = missingModsMessage + ", ";
			missingModsMessage = missingModsMessage + "@task_force_radio";
		}
		else
		{
			missingTFRMessage = localize "STR_MissingTFRMod";
		};
	};
};

if (missingModsMessage != "") then
{
	sleep .01;
	missingModsMessage = missingModsMessage + ". " + (localize "STR_InstallPWS");
	hintC missingModsMessage;
}
else
{
	if (missingTFRMessage != "") then
	{
		sleep .01;
		hintC missingTFRMessage;
	};
};

modCheckDone = true;