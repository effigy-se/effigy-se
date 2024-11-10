SUBSYSTEM_DEF(macrogames)
	name = "Macrogames"
	flags = SS_BACKGROUND
	/// All currently running gamemodes.
	var/list/running_gamemodes = list()
	/// All gamemodes queued for the next round.
	var/list/queued_gamemodes = list()
	/// Are we allowing players to vote for gamemodes?
	var/can_players_vote = FALSE
	/// Should we run our current gamemode in perpetuity?
	var/should_perpetually_run = FALSE

/datum/controller/subsystem/macrogames/Initialize()
	/// SHOG TODO: running_gamemodes should autopopulate from a json file in data/ after a round ends with queued_gamemodes filled up. Send help!!!
	return SS_INIT_SUCCESS
