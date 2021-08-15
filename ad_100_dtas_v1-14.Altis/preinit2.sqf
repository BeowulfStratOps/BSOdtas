private ["_paramName", "_paramValue", "_i"];

// Workaround for bug 24051 - Disable time of day settings.
nightOrDay = 0;
NightvisionParam = 1;
[] call compile preprocessFileLineNumbers "setdate.sqf";
waitUntil {!isNil "paramsArray"};

for [{_i = 0}, {_i < count paramsArray}, {_i = _i +1 }] do
{
	_paramName =(configName ((missionConfigFile >> "Params") select _i));
	_paramValue = (paramsArray select _i);
	missionNameSpace setVariable [_paramName, _paramValue];
};

timeLimit = timeLimit * 60;

// Disabled due to bug 24051 (see above).
//[] call compile preprocessFileLineNumbers "setdate.sqf";

all_crates = [];

// TacBF Workarounds.
ICE_fnc_gear_adjustMaxKitsAllowed = {0};

preInitDone = true;