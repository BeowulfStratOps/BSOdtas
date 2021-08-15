overviewText = "DTAS!";
OnLoadName = "DTAS!";									// <!-- Mission Name (Just Text)
OnLoadMission = "Pew Pew Pew Pew Pew"; 			// <!-- A VERY brief overview (Copy from above)

class CfgBsoLoadouts {
	#include "loadouts\blufor.cpp"
  //#include "loadouts\opfor.cpp" //create this file by copying blufor.cpp and renaming
  //#include "loadouts\indep.cpp" //create this file by copying blufor.cpp and renaming
};

class Header {
	maxPlayers = 32;						// <!-- CHANGE Where the number is the total playable slots
	minPlayers = 2;
	gameType = FUN;						// <!-- Mission Type
};

// Used for custom debriefing screens launched by the admin or triggers ingame. See briefing.sqf for admin interactions
class CfgDebriefing
{  
	class End1
	{
		title = "GAME OVER";
		subtitle = "";
		description = "Well, someone won";
		pictureBackground = "";
		picture = "b_inf";
		pictureColor[] = {0.0,0.3,0.6,1};
	};	
};


