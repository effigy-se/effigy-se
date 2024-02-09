//Cursed Items. Gives everyone unremoval annoying cursed items that usually messes with protections, such as EVA suits and gas masks. Removed because way too powerful.
/datum/round_event_control/wizard/cursed_items
	max_occurrences = 0
	weight = 0

//Departmental Revolt. Basically a department goes into Nations mode and is supposed to fight another department. Code says this is disabled but I don't trust it.
/datum/round_event_control/wizard/deprevolt
	max_occurrences = 0
	weight = 0

//Curse of madness. Gives everyone a very bad trauma. Very crippling if it chooses something like blindness, deafness, or paralysis.
/datum/round_event_control/wizard/madness
	max_occurrences = 0
	weight = 0

//Race Swap. Everyone gets a new race. It's disabled on Skyrat because it upset snowflakes, but we're making sure here.
/datum/round_event_control/wizard/race
	max_occurrences = 0
	weight = 0

//Tower of Babel. Everyone has all their languages removed and a new one is given. Very bad for a roleplay server since no one can now effectively communicate.
// Also, a lot of features don't really blend well with not knowning Galactic Common
/datum/round_event_control/wizard/tower_of_babel
	max_occurrences = 0
	weight = 0

//Summon Magic and Summon Guns. Removes giving the survival objective so people don't turn into antags and have an excuse to murder eachother over a pointless greentext.
/datum/round_event/wizard/summonmagic/start()
	summon_magic(survivor_probability = 0)

/datum/round_event/wizard/summonguns/start()
	summon_guns(survivor_probability = 0)

// Annihilation. Summons meteors, tesla, or singulo. Removed because it does that (and the meteor spam can cause REALLY bad lag).
/datum/grand_finale/armageddon
	desc = null

// Jubilation.  Turns everyone into clowns. Kind of pointless because SAD exists. Also snowflakes will complain.
/datum/grand_finale/clown
	desc = null
