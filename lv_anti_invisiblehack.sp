#include <sourcemod>

#define TEAM_SPECTATOR	1
#define TEAM_SURVIVOR	2
#define TEAM_INFECTED	3

public Plugin:myinfo = 
{
	name = "Anti invisible hack",
	author = "LEaver",
	description = "To overcome invisible survivor hack issue",
	version = "2.3",
	url = "https://www.facebook.com/ImLEaver"
}

public OnPluginStart()
{
	HookEvent("player_hurt", event_survivor_hurt);
}

public Action:event_survivor_hurt(Handle:event, const String:name[], bool:dontBroadcast)
{
	new client_attacker = GetClientOfUserId(GetEventInt(event, "attacker"));
	DetectHack(client_attacker);	
}

//detect invisible hack here
DetectHack(fucker)
{
	if(IsPlayerAlive(fucker) == false && IsValidClients(fucker) == true && GetClientTeam(fucker) == TEAM_SURVIVOR && IsClientConnected(fucker) == true )
	{
		new String:fuckerName[1024];
		GetClientName(fucker, fuckerName, sizeof(fuckerName));
		PrintToChat(fucker, "Invisible Hack detected!");
		PrintToChatAll("[LEaver Anti Invisible Hack] Detected %s using invisible hack!", fuckerName);
		BanClient(fucker, 0, BANFLAG_AUTO, "Banned for potentially using invisible survivor hack.");
		KickClient(fucker,"Get off invisible! Request unban at My ANiME Clan steam group if you are clean player");
	}
}

// Simplified processing function, return true if client is human and in game
bool:IsValidClients(client)
{
	if(client < 1 || client > MaxClients) 
		return false;

	if(!IsClientConnected(client))
		return false;

	return (IsClientInGame(client) && !IsFakeClient(client));
}

///testing nia