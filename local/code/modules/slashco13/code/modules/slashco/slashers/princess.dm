/datum/antagonist/slasher/princess
	name = "Princess"
	mob_type = /mob/living/basic/slasher/princess
	our_chase_music = /datum/looping_sound/slasher_chase/princess
	/// Our current aggression value. Increases by 1 each second.
	var/aggression = 0
	/// Our maximum aggression value. Clamps at 100; starts at 50.
	var/maximum_aggression = 50
	/// Our aggression 'prestige'. Increases by when Princess eats a Faustian doll; and acts as a multiplier for aggression gain.
	var/aggression_prestige = 1

/datum/looping_sound/slasher_chase/princess
	start_sound = 'local/code/modules/slashco13/sound/slasher/princess/chase.ogg'
	start_length = 5 // needs in-game testing (needs to be cranked tf up)
	mid_sounds = list('local/code/modules/slashco13/sound/slasher/princess/chase.ogg' = 1)
	mid_length = 5 // ditto
	end_sound = null
