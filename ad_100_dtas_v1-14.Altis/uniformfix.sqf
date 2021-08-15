while {true} do
{
	waitUntil {uniform player != currentUniform && alive player && gearAssigned};

	removeUniform player;
	player forceAddUniform currentUniform;
};