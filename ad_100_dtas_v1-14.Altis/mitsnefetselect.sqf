private ["_params", "_helmIndex", "_newMitsnefet"];

_params = _this select 3;
_helmIndex = _params select 0;

_newMitsnefet = format ["IDF_Helmet_Mitsnefet_%1", _helmIndex];

if (mitsnefetHelmet == toLower (headGear player)) then
{
	removeHeadgear player;
	player addHeadGear _newMitsnefet;
};
mitsnefetHelmet = _newMitsnefet;