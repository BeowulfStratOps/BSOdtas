// moves people into or out of spectator
// handles acre accordingly

params ["_doSpectate"];

if (_doSpectate) then {
    private _isAdmin = call BIS_fnc_admin > 0;
    [true, !_isAdmin, false] call ace_spectator_fnc_setSpectator;
    [true] call acre_api_fnc_setSpectator;
} else {
    [false] call ace_spectator_fnc_setSpectator;
    [false] call acre_api_fnc_setSpectator;
};
