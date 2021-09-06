overviewText = "DTAS!";
OnLoadName = "DTAS!";									// <!-- Mission Name (Just Text)
OnLoadMission = "Dynamic Take and Secure"; 			// <!-- A VERY brief overview (Copy from above)

class CfgBsoLoadouts {
	//#include "loadouts\blufor.cpp"
  //#include "loadouts\opfor.cpp" //create this file by copying blufor.cpp and renaming
  //#include "loadouts\indep.cpp" //create this file by copying blufor.cpp and renaming
};

// Used for custom debriefing screens launched by the admin or triggers ingame. See briefing.sqf for admin interactions
class CfgDebriefing
{  
	class End1
	{
		title = $STR_YourTeamWon;
		//subtitle = "";
		description = $STR_TryWinAgain;
		//backgroundPicture = "";
		//picture = "b_inf";
		//pictureColor[] = {0.0,0.3,0.6,1};
	};
	
	class End2
	{
		title = $STR_YourTeamLost;
		//subtitle = "";
		description = $STR_TryWinNext;
		//backgroundPicture = "";
		//picture = "b_inf";
		//pictureColor[] = {0.0,0.3,0.6,1};
	};
};


class Header
{
	gameType = Seize;
	minPlayers = 4;
	maxPlayers = 100;
};
