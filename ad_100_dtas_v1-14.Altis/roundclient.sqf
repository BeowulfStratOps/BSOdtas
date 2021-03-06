Private ["_defaultInsertionMarker", "_aRadiusMarker", "_xOffset", "_yOffset", "_pos", "_taskMessageTitle", "_taskMessageText", "_endTime"];

fnc_findFlatEmpty = compile preprocessFileLineNumbers "fnc_findflatempty.sqf";

fnc_roundEndMessage = compile preprocessFileLineNumbers "roundendmsg.sqf";

capPercentage = 0;

execVM "capturetriggermsg.sqf";
execVM "afkkiller.sqf";

nameTagMaxDistance = 60;
[] execVM "cursornames\cursornames_init.sqf";

player setVariable ["shortName", "-", true];
preferDriver = false;
player setVariable ["preferDriver", preferDriver, true];
player setVariable ["vehicleRole", [objNull, false]];
isPlaying = false;

isGroupLeader = false;

// Run key press handler (disable spacebar scanning, group joining)
disableSerialization;
waituntil {!(IsNull (findDisplay 46))};
fnc_keyUp = compile preprocessFileLineNumbers "keyup.sqf";
_display = findDisplay 46;
_display displayAddEventHandler ["keyUp", "_this call fnc_keyUp"];
_display displayAddEventHandler ["onMouseButtonUp", "_this call fnc_keyUp"];
_display displayAddEventHandler ["onJoystickButton", "_this call fnc_keyUp"];

unstuck_enabled = true;
commandChannelEnabled = true;
//Player actions
fnc_addActions =
{
	player addAction [localize "STR_UnStuck", "unstuck.sqf", [], 0, false, true, "",
	"
		unstuck_enabled
		&&
		isPlaying && ((time + timeLimit - endTime) > 5)
		&&
		(
			(sidePlayer != attackerSide) && ((time + timeLimit - endTime) < 45) && (([getPos player, objPos] call fnc_getSqrDist) < 10000)
			||
			((vehicle player != player) && (player == driver (vehicle player)) && ([getPos player, ((group player) getVariable ['insertionPos', [0, 0, 0]])] call fnc_getSqrDist) < 5625)
		)
	"];
	
	// Add IDF mitsnefet actions.
	if (attackerFaction == 0) then
	{
		player addAction [localize "STR_RemoveMitsnefet", "mitsnefettoggle.sqf", [false], 0, false, true, "", "(vehicle player == player) && ((toLower (headGear player)) == mitsnefetHelmet)"];
		player addAction [localize "STR_PutOnMitsnefet", "mitsnefettoggle.sqf", [true], 0, false, true, "", "(vehicle player == player) && ((toLower (headGear player)) == 'IDF_Helmet_CQB_Golani')"];
	};
};

basePos = getPos player;
_xOffset = (getPos player select 0) - (markerPos "respawn_west" select 0);
_yOffset = (getPos player select 1) - (markerPos "respawn_west" select 1);
if (sidePlayer == EAST) then
{
	_xOffset = (getPos player select 0) - (markerPos "respawn_east" select 0);
	_yOffset = (getPos player select 1) - (markerPos "respawn_east" select 1);
};

fnc_respawn = // wait for player to respawn, assign gear
{
	private ["_bGiveWeapons"];
	_bGiveWeapons = _this select 0;
	if (!alive player) then
	{
		waitUntil {alive player};
		[] call fnc_addActions;
	};
	player setVariable ["preferDriver", preferDriver, true];
	player setVariable ["vehicleRole", [objNull, false]];
	player setVariable ["playerAllowDamage", false, true];
	[_bGiveWeapons] call fnc_assignGear;
	player setFatigue 0;
};

fnc_reveal =
{
	{(group player) reveal _x;} forEach ((getPos player) nearObjects ["B_SupplyCrate_F", 50]);
	if (sidePlayer == WEST) then
	{
		(group player) reveal westMenuFlag;
	}
	else
	{
		(group player) reveal eastMenuFlag;
	};
};

trgCapMsg setTriggerArea [capRad, capRad, 0, false];

_defaultInsertionMarker = createMarkerLocal ["mrkDefaultInsertion", [1, 1]];
_defaultInsertionMarker setMarkerShapeLocal "ICON";
_defaultInsertionMarker setMarkerTypeLocal "mil_start";
_defaultInsertionMarker setMarkerTextLocal format [localize "STR_DefaultInsertion", localize "STR_InsertionVehicle0s"];
_defaultInsertionMarker setMarkerColorLocal "COLORGREEN";
_defaultInsertionMarker setMarkerSizeLocal [1.1, 1.1];
_defaultInsertionMarker setMarkerAlphaLocal 0;

_aRadiusMarker = createMarkerLocal ["mrkAZone", [1, 1]];
_aRadiusMarker setMarkerShapeLocal "ELLIPSE";
_aRadiusMarker setMarkerBrushLocal "Border";
_aRadiusMarker setMarkerColorLocal "COLORRED";
_aRadiusMarker setMarkerSizeLocal [minDist, minDist];
_aRadiusMarker setMarkerAlphaLocal 0;

objPosHandlerClient =
{
	trgCapMsg setPos objPos;
	if ((!roundInProgress) && (attackerSide == sidePlayer) && ([player] call fnc_isLeaderWithGroup)) then
	{
		hint (localize "STR_SelectInsertionMethod");
	};
};
"objPos" addPublicVariableEventHandler objPosHandlerClient;

defaultInsertionPosHandler =
{
	private ["_dx", "_dy", "_dir"];
	if (sidePlayer == attackerSide) then
	{
		_dx = (objPos select 0) - (defaultInsertionPos select 0);
		_dy = (objPos select 1) - (defaultInsertionPos select 1);
		_dir = atan (_dy/_dx);
		if (_dx<0) then
		{
			_dir = _dir + 180;
		};
		if (_dx==0) then
		{
			if (_dy>0) then
			{
				_dir = 90;
			}
			else
			{
				_dir = -90;
			};
		};
		_dir = 90 - _dir;

		"mrkDefaultInsertion" setMarkerPosLocal defaultInsertionPos;
		"mrkDefaultInsertion" setMarkerDirLocal _dir;
		"mrkDefaultInsertion" setMarkerAlphaLocal 1;
	};
};
"defaultInsertionPos" addPublicVariableEventHandler defaultInsertionPosHandler;

waitUntil {!(isNil "fnc_isLeaderWithGroup")};

vehArrHandler =
{
	{player reveal _x} forEach vehArr;
	[] call fnc_vehicleAllowDamage;
};
"vehArr" addPublicVariableEventHandler vehArrHandler;

currentVehHandler =
{
	private ["_veh", "_roleIndex", "_slotIndex"];
		
	_veh = (_this select 0) select 0;
	_roleIndex = (_this select 0) select 1;
	
	bKeepPlayerInBox = false;
	
	// Place the player near the vehicle, just in case getting the the vehicle gets messed up.
	player setPos ([getPos _veh, 3] call fnc_findFlatEmpty);
	
	// Get in the vehicle.
	if (_roleIndex == 0) then
	{
		player moveInDriver _veh;
	}
	else
	{
		_slotIndex = _roleIndex - 1;
		if (((toLower (typeOf _veh)) == (toLower "B_Heli_Light_01_F")) || ((toLower (typeOf _veh)) == (toLower "B_SDV_01_F"))) then
		{
			_slotIndex = _slotIndex - 1;
		};
		if (_slotIndex < 0) then
		{
			player moveInTurret [_veh, [0]];
		}
		else
		{
			player moveInCargo [_veh, _slotIndex];
		};
	};
};
"currentVeh" addPublicVariableEventHandler
{
	[_this select 1] call currentVehHandler;
};

waitUntil {!(isNil "objPos")};
[] call objPosHandlerClient;

waitUntil {!(isNil "defaultInsertionPos")};
[] call defaultInsertionPosHandler;

waitUntil {alive player && (!isNil "nextAttackerSide")};
[] call objPosHandlerClient;

[] call compile preprocessFileLineNumbers "hud_create.sqf";

fnc_HUDUpdate = compile preprocessFileLineNumbers "hud_update.sqf";

execVM "timerupdateclient.sqf";

player addEventHandler ["Killed",
{
	private ["_killer"];
	_killer = _this select 1;
	
	if (sidePlayer == side _killer) then
	{
		TKer = _killer;
		publicVariable "TKer";
		[TKer] call TKerPVHandler;	
	};
	
	isPlaying = false;
}];

TKerPVHandler =
{
	private ["_killer"];

	_killer = _this select 0;
	
	if (side _killer == sidePlayer) then
	{
		systemChat format [localize "STR_TKMessage", name _killer];
	};
};
"TKer" addPublicVariableEventHandler
{
	[_this select 1] call TKerPVHandler;
};

currentClass = ["", ""];
currentAClass = aClasses select 0;
currentDClass = dClasses select 0;
hasMitsnefet = false;

[false] call fnc_respawn;
bKeepPlayerInBox = true;

if (alive player) then
{
	[] call fnc_addActions;
};

execVM "uniformfix.sqf";

// Variables for restriction checking.
// Set enableRestrictionChecking to false and wait for restrictionCheckingEnabled to become false.
// To re-enable, set restrictionCheckingEnabled and enableRestrictionChecking to true (in that order).
enableRestrictionChecking = true;
restrictionCheckingEnabled = true;

[] spawn
{
	private ["_xPos", "_yPos", "_sight", "_FAKCount", "_maxFAKCount"];
	_xPos = (markerPos "respawn_east") select 0;
	_yPos = (markerPos "respawn_east") select 1;
	if (sidePlayer == WEST) then
	{
		_xPos = (markerPos "respawn_west") select 0;
		_yPos = (markerPos "respawn_west") select 1;
	};
	
	while {true} do
	{
		/* Temporarily disable restriction checking while initializing round. */
		if (!enableRestrictionChecking) then
		{
			restrictionCheckingEnabled = false;
			waitUntil {enableRestrictionChecking};
		};
		
		if (bKeepPlayerInBox) then
		{
			if ((alive player) && (((abs((getPos player select 0) - _xPos)) > 14) || ((abs ((getPos player select 1) - _yPos)) > 10))) then
			{
				player setPos [_xPos, _yPos];
				player setVelocity [0, 0, 0];
			};
		};
		
		if (player getVariable "groupKicked") then
		{
			[] call fnc_groupLeave;
		};
		
		sleep .01;
	};
};

while {isNil "roundInProgress"} do
{
	waitUntil {!isNil "roundInProgress" || !alive player};
	if (!alive player) then
	{
		[false] call fnc_respawn;
	};
};

if (roundInProgress) then
{
	if (missingModsMessage == "" && missingTFRMessage == "") then
	{
		hintC localize "STR_WaitNextRound";
	};
};


if (roundInProgress) then
{
    [true] call bso_dtas_fnc_spectate;
	while {roundInProgress} do
	{
		waitUntil {!roundInProgress || !alive player};
		if (!alive player) then
		{
			[false] call fnc_respawn;
		};
	};
};

// hud hotfix
[] spawn {
    while {true} do {
        sleep 5;
        if (isNull (uiNamespace getVariable ["DTASHUD", displayNull])) then {
            [] execVM "hud_create.sqf";
        };
    };
};

// THIS IS THE MAIN ROUND HANDLER. anything before this was setupTime
// mission lifecycle (assumed): get out of spectator, start in box, select loadouts etc. etc., play, die -> spectate, wait for round to be done
while {true} do
{
	[false] call bso_dtas_fnc_spectate;

	player setVariable ["isPlaying", false];
	player setVariable ["ready", true, true];
	
	while {(!roundInProgress) || (!(player getVariable ["isPlaying", false]))} do
	{
		waitUntil {(roundInProgress && (player getVariable ["isPlaying", false])) || !alive player};
		if (!alive player) then
		{
			[false] call fnc_respawn;
			player setVariable ["ready", true, true];
		};
	};
	
	["DTASChooseAPos", "onMapSingleClick"] call BIS_fnc_removeStackedEventHandler;
	["DTASChooseObjPos", "onMapSingleClick"] call BIS_fnc_removeStackedEventHandler;
	"mrkAZone" setMarkerAlphaLocal 0;
	
	lastAttackerSide = attackerSide;

	// Stop restriction checking to allow "thread-safe" round initialization.
	enableRestrictionChecking = false;
	waitUntil {!restrictionCheckingEnabled};
	
	player setVelocity [0,0,0];
	if (sidePlayer == attackerSide) then
	{
		if ((vehicle player == player) && (isNil "currentVeh")) then
		{
			waitUntil {!isNil "currentVeh"};
			if (vehicle player == player) then
			{
				[currentVeh] call currentVehHandler;
			};
		};
	}
	else
	{
		_pos = [(objPos select 0) + _xOffset, (objPos select 1) + _yOffset];
		_pos = [_pos, 3] call fnc_findFlatEmpty;
		bKeepPlayerInBox = false;
		player setPos _pos;
	};
	
	player setDamage 0;
	
	isPlaying = true;
	
	[true] call fnc_respawn;
	
	// Re-enable restriction checking.
	restrictionCheckingEnabled = true;
	enableRestrictionChecking = true;
	
	[] spawn
	{
		private ["_endTime"];
		_endTime = time + 30;
		waitUntil {(!(alive player)) || (!roundInProgress) || (time > _endTime)};
		if ((time > _endTime) && (alive player) && roundInProgress) then
		{
			player setVariable ["playerAllowDamage", true, true];
		};
	};

	if (sidePlayer == attackerSide) then
	{
		_taskMessageTitle = "STR_CaptureTheZone";
		_taskMessageText = "STR_CaptureTheZoneLong";
		["DTASNotificationAttackStart", [localize _taskMessageTitle, localize _taskMessageText]] spawn BIS_fnc_showNotification;
	}
	else
	{
		_taskMessageTitle = "STR_DefendTheZone";
		_taskMessageText = "STR_DefendTheZoneLong";
		["DTASNotificationDefenseStart", [localize _taskMessageTitle, localize _taskMessageText]] spawn BIS_fnc_showNotification;
	};
	//["DTASNotificationAssigned", [localize _taskMessageTitle, localize _taskMessageText]] spawn BIS_fnc_showNotification;
	
	if (missingModsMessage != "") then
	{
		[] spawn
		{
			removeAllWeapons player;
			removeUniform player;
			removeBackPack player;
			removeVest player;
			removeHeadGear player;
			removeAllAssignedItems player;
			player setDamage 1;
			hintC missingModsMessage;
		};
	};
	
	waitUntil {!(alive player) || !roundInProgress};
	isPlaying = false;
	player setVariable ["isPlaying", false];
	bKeepPlayerInBox = true;
	[false] call fnc_respawn;
	
	if (roundInProgress) then
	{
		[true] call bso_dtas_fnc_spectate;
	}
	else
	{
		if (vehicle player != player) then
		{
			player action ["Eject", vehicle player];
		};
		player setPos basePos;
		player setVelocity [0,0,0];
		player setDamage 0;
	};
	while {roundInProgress} do
	{
		waitUntil {!roundInProgress || (!(alive player))};
		if (!alive player) then
		{
			[false] call fnc_respawn;
		};
	};
	(group player) setVariable ["groupReady", false];
	"mrkDefaultInsertion" setMarkerAlphaLocal 0;
	[] call fnc_reveal;
	[] call fnc_roundEndMessage;
};
