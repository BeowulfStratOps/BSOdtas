#include "islandspecific.hpp"

// Create a mission entry for the server and client RPT file, easier to debug when you know what mission created the error
diag_log text ""; 
diag_log text format["|=============================   %1   =============================|", missionName]; // stamp mission name
diag_log text "";

//-----------------------------------------------------------------------------------------------------

// When porting to other islands:

// Edit setdate.sqf to appropriate time/date (matching description.ext options).
// Make sure the mission.sqm/editor are set to the earliest time/date possible.

// Make sure west and east starting areas are not off-map (or else ammo crates become unusable).
// Place the empty markers "mrkSWcorner" and "mrkNEcorner" to the corners of the area where you want the objective to be able to spawn.
// Consider that west spawns in a random direction and distance between minDist and maxDist from the objective, so adjust the zone accordingly.

call compile preprocessFile "islandspecific.sqf";

// minimum and maximum capturing times - Maximum for when only 1 more attackers than defenders, minimum when infinitely more attackers than defenders
minCapTime = 20;
maxCapTime = 60;

// Multipliers for minimum spawn distance of each insertion type.
minDistFactors = [1, 0.7, 0.55, 1];

//------------------------------------------------------------------------------------------------------

waitUntil {!isNil "preInitDone"};

// Run scripts that check the server
[] execVM "serverwarnings\serverwarnings_init.sqf";

// Disable saving
enableSaving [false, false];

// Disable automatic radio messages
enableSentences false;

call compile preprocessFileLineNumbers "modcheck.sqf";

// fix for marker position desync for JIP
[] spawn
{
	waitUntil {!isNil "objPos"};
	"mrkObj" setMarkerPosLocal objPos;
	"mrkObj1" setMarkerPosLocal objPos;
};

fnc_getSqrDist = compile preprocessFileLineNumbers "fnc_getsqrdist.sqf";

fnc_cleanName = compile preprocessFileLineNumbers "fnc_cleanname.sqf";

fnc_airDistance =
{
	sqrt (_this call fnc_getSqrDist)
};

fnc_isCapturing = compile preprocessFileLineNumbers "fnc_iscapturing.sqf";

fnc_vehicleAllowDamage =
{
	{
		_x allowDamage false;
	} forEach vehArr;
	[] spawn
	{
		private ["_endTime", "_oldVehArr"];
		_oldVehArr = vehArr + [];
		_endTime = time + 30;
		waitUntil {time > _endTime};
		{
			if (!(isNull _x)) then
			{
				_x allowDamage true;
			};
		} forEach _oldVehArr;
	};
};

fnc_minGroupSize =
{
	private ["_minGroupSize"];
	_minGroupSize = (playersNumber (attackerSide)) / 3;
	if (_minGroupSize > 3) then
	{
		_minGroupSize = 3;
	};
	
	_minGroupSize
};

// Initialize group scripts
//call compile preprocessFile "groups\groups_init.sqf";

[] execVM "capture.sqf";

// Make sure teamkillers don't go on side enemy
[] spawn
{
	while {true} do 
	{ 
		waitUntil {sideEnemy countSide allUnits > 0};
		{
			if ((side _x == sideEnemy) && (local _x)) then
			{
				_x addRating (-(rating _x)); 
			}; 
		} forEach allUnits; 
	}; 
};

if (isServer) then
{
	["Initialize"] call BIS_fnc_dynamicGroups;
	
	execVM "roundserver.sqf";
};

execVM "endhandler.sqf";

execVM "spawnprotection.sqf";

execVM "weather.sqf";

fnc_DeleteOldBody = compile preprocessFileLineNumbers "deleteoldbody.sqf";

if (!isDedicated) then
{
	waitUntil {!isNull player};
	
	["InitializePlayer", [player]] call BIS_fnc_dynamicGroups;
	
	sidePlayer = side player;

	fnc_addRadio = compile preprocessFileLineNumbers "addradio.sqf";
	fnc_assigngear = compile preprocessFileLineNumbers "assigngear.sqf";
	
	isJoining = false;
	
	execVM "briefing.sqf";
	execVM "unitmarkers.sqf";

	[] call compile preprocessFileLineNumbers "defineclasses.sqf";
	
	// Add mitsnefet handling for IDF.
	if (attackerFaction == 0) then
	{
		[] call compile preprocessFileLineNumbers "mitsnefet.sqf";
	};
	
	sleep .01;
	
	execVM "roundclient.sqf";
};


[false, true] call acre_api_fnc_setupMission;