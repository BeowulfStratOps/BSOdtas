private ["_veh", "_cond"];
waitUntil {!isNull player};

_veh = _this select 0;

_veh allowDammage false;

waituntil {!(isNil "aClasses")};
waitUntil {!(isNil "dClasses")};

{
	_cond = format ["(nextAttackerSide==sidePlayer) && canChangeClass && (%1)", _x select 13];
	_veh addAction [_x select 0, "classaction.sqf", [_x, WEST], 4, false, true, "", _cond];
} forEach aClasses;

// Add mitsnefet options for IDF.
if (attackerFaction == 0) then
{
	for "_i" from 1 to 3 do
	{
		_veh addAction [format [localize "STR_SelectMitsnefet", _i], "mitsnefetselect.sqf", [_i], 0, false, true, "", "(nextAttackerSide==sidePlayer) && canChangeClass"];
	};
};

{
	_cond = format ["(nextAttackerSide!=sidePlayer) && canChangeClass && (%1)", _x select 13];
	_veh addAction [_x select 0, "classaction.sqf", [_x, EAST], 4, false, true, "", _cond];
} forEach dClasses;