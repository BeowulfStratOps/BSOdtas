private["_handled", "_ctrl", "_dikCode", "_shift", "_ctrlKey", "_alt"];
_ctrl = _this select 0;
_dikCode = _this select 1;
_shift = _this select 2;
_ctrlKey = _this select 3;
_alt = _this select 4;
  
_handled = false;

if (!_shift && !_ctrlKey && !_alt) then
{
	if (_dikCode in (actionKeys "ForceCommandingMode")) then
	{
		//_handled = true;
	};
	
	// Handle group management keys
	//if (_dikCode in (actionKeys "TeamSwitch")) then
	//{
	//	[] call fnc_groupRefresh;
	//	_handled = true;
	//};
	
	// Handle spectator keys
	if (isSpectating) then
	{
		if ((_dikCode in (actionKeys "MoveForward")) || (_dikCode in (actionKeys "MoveRight"))) then
		{
			[1] call fnc_nextSpectateUnit;
			_handled = true;
		};
		if ((_dikCode in (actionKeys "MoveBack")) || (_dikCode in (actionKeys "MoveLeft"))) then
		{
			[-1] call fnc_nextSpectateUnit;
			_handled = true;
		};
		// Exit spectator (prone not working for some reason)
		if
		(
			(_dikCode in (actionKeys "Prone"))
			||
			(_dikCode in (actionKeys "Stand"))
			||
			(_dikCode in (actionKeys "Crouch"))
			||
			(_dikCode in (actionKeys "LeanLeft"))
			||
			(_dikCode in (actionKeys "LeanRight"))
		) then
		{
			spectateUnit = player;
			isSpectating = false;
			[] call fnc_switchCamera;
			_handled = true;
		};
	};
};

_handled