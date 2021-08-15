private ["_bGiveWeapons", "_aClassSide", "_currentClass", "_i", "_magCount", "_tempBackpackItems", "_backpack"];

_bGiveWeapons = _this select 0;

gearAssigned = false;

_aClassSide = nextAttackerSide;
if (_bGiveWeapons) then
{
	_aClassSide = attackerSide;
};
_currentClass = currentDClass;
if (_aClassSide == sidePlayer) then
{
	_currentClass = currentAClass;
};

if (!_bGiveWeapons) then
{
	hint ((format [localize "STR_SelectedClass", _currentClass select 0]) + " " + (localize "STR_WeaponsWillBeGiven"));
};

removeAllWeapons player;
removeUniform player;
removeBackPack player;
removeVest player;
removeHeadGear player;
removeAllAssignedItems player;
removeGoggles  player;
isMedic = false;

sleep .1;

player addWeapon "ItemMap";
player addWeapon "ItemCompass";
player addWeapon "ItemWatch";
player addWeapon "ItemGPS";

// Call init code (ex: isMedic = true;)
[] call (_currentClass select 12);

currentUniform = _currentClass select 1;
player forceAddUniform currentUniform;

if ((_currentClass select 2) != "") then
{
	player addVest (_currentClass select 2);
};
_backpack = _currentClass select 3;
if (_backpack != "" && _bGiveWeapons) then
{
	player addBackpack _backpack;
	_backpackItems = backpackItems player;
	{
		player removeItemFromBackpack _x;
	} forEach _backpackItems;
};

if ((_currentClass select 4) != "") then
{
	if (hasMitsnefet && (_aClassSide == sidePlayer)) then
	{
		player addHeadgear mitsnefetHelmet;
	}
	else
	{
		player addHeadgear (_currentClass select 4);
	};
};
if ((_currentClass select 5) != "") then
{
	player linkItem (_currentClass select 5);
};

if (_bGiveWeapons) then
{
	
	// Fix for lack of room for launcher ammo in vest
	if (_backpack == "") then
	{
		player addBackPack "B_Bergen_sgg";
	};
	
	// Add 1 of each magazine
	
	{
		if ((_x select 1) > 0) then
		{
			player addMagazine (_x select 0);
		};
	} forEach (_currentClass select 7);

	// Add weapons
	{
		player addWeapon _x;
	} forEach (_currentClass select 6);
	
	// Fix for lack of room for launcher ammo in vest
	if (_backpack == "") then
	{
		_tempBackpackItems = backpackItems player;
		removeBackPack player;
		{player addMagazine _x} forEach _tempBackpackItems;
	};
	
	// Add rest of magazines
	{
		_magCount = (_x select 1) - 1;
		if (_magCount > 0) then
		{
			player addMagazines [_x select 0, _magCount];
		};
	} forEach (_currentClass select 7);

	_primaryWeapon = primaryWeapon player;
	if (_primaryWeapon != "") then
	{
		player selectWeapon _primaryWeapon;
		// Fix for weapons with grenade launcher
		_muzzles = getArray(configFile>>"cfgWeapons" >> _primaryWeapon >> "muzzles");
		player selectWeapon (_muzzles select 0);
	};
	
	{
		if (_x != "") then
		{
			player addPrimaryWeaponItem _x;
		};
	} forEach (_currentClass select 9);
	
	{
		if (_x != "") then
		{
			player addSecondaryWeaponItem _x;
		};
	} forEach (_currentClass select 10);
	
	{
		player addHandgunItem _x;
	} forEach (_currentClass select 11);
};

// Add items
{
	for "_i" from 1 to (_x select 1) do
	{
		player addItem (_x select 0);
	};
} forEach (_currentClass select 8);

if ((!(_bGiveWeapons)) && (nightVision >= 0)) then
{
	player linkItem attackerNVG;
}
else
{
	if ((nightVision > 0) && (_aClassSide == sidePlayer)) then
	{
		player linkItem attackerNVG;
	}
	else
	{
		if (nightVision > 1) then
		{
			player linkItem defenderNVG;
		};
	};
};

if (!(player hasWeapon "Rangefinder")) then
{
	// Disabled binoculars until BIS fix super sprinting with binoculars.
	//player addWeapon "Binocular";
};

if (_bGiveWeapons || !isTFR) then
{
	[] call fnc_addRadio;
};

gearAssigned = true;