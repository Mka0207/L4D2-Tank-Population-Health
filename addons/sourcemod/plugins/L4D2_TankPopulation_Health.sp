public Plugin:myinfo =
{
	name = "[L4D2] Tank Population Health",
	author = "Mka0207",
	description = "Tank Health is controlled by number of players. [Requires XeroX's Plugin']",
	version = "1.0",
	url = ""
}

new Handle:l4d_tank_pop_convar;

public OnPluginStart()
{
	l4d_tank_pop_convar = CreateConVar("tank_population_health","1", "Should Tanks health be population based? Default = 1", 262144, true, 0.0);
	HookEvent("tank_spawn", Event_TankSpawn, EventHookMode:1);

	AutoExecConfig(true,"TankPopL4D");
}

public Action:Event_TankSpawn(Handle:event, String:event_name[], bool:dontBroadcast)
{
	if (GetConVarBool(l4d_tank_pop_convar))
	{
		new client = GetClientOfUserId( GetEventInt(event, "userid") );
		new survivorcount = 0;
		new Float:hptoadd = 0.0;
		
		if ( survivorcount > 0 )
		{
			survivorcount = 0;
		}
		
		for ( new i = 1; i <= MaxClients; i++ )
		{
			if ( IsClientConnected(i) )
			{
				if ( GetClientTeam(i) == 2 )
				{
					survivorcount++;
				}
			}
		}

		if ( hptoadd > 0.0 )
		{
			hptoadd = 0.0;
		}
		
		if (client)
		{
			hptoadd = 4000.0 * survivorcount;
			SetConVarFloat( FindConVar("z_tank_health"), hptoadd, false, false );
		}
	}
}
