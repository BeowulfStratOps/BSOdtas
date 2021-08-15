private ["_params", "_putOn", "_caller"];

_params = _this select 3;
hasMitsnefet = _params select 0;
_caller = _this select 1;
removeHeadGear _caller;
if (hasMitsnefet) then
{
	player addHeadGear mitsnefetHelmet;
}
else
{
	player addHeadGear "IDF_Helmet_CQB_Golani";
};

player playMove "AinvPercMstpSnonWnonDnon_Putdown_AmovPercMstpSnonWnonDnon";
//player playMove "AmovPercMstpSrasWrflDnon_gear_AmovPercMstpSrasWrflDnon";
//player playMove "AmovPercMstpSrasWrflDnon_gear";