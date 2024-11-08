SUBSYSTEM_DEF(macrogames)
	name = "Macrogames"
	flags = SS_BACKGROUND
	/// All currently running gamemodes.
	var/list/running_gamemodes = list()
	/// All gamemodes queued for the next round.
	var/list/queued_gamemodes = list()
	/// Are we allowing players to vote for gamemodes?
	var/can_players_vote = FALSE
