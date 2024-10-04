/datum/antagonist/slasher/princess
	name = "Princess"
	mob_type = /mob/living/basic/slasher/princess
	our_chase_music = /datum/looping_sound/slasher_chase/princess
	chase_length = 10 SECONDS
	jumpscare_icon = null
	jumpscare_time = 1.5 SECONDS
	jumpscare_sound = 'local/code/modules/slashco13/sound/slasher/princess/attack.ogg'
	our_chase_attack = /datum/action/cooldown/spell/slasher_chase/princess
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

/datum/antagonist/slasher/princess/give_slasher_abilities()
	START_PROCESSING(SSprocessing, src)

/datum/antagonist/slasher/princess/process(seconds_per_tick)
	aggression += (seconds_per_tick * aggression_prestige)
	if(aggression > maximum_aggression)
		aggression = maximum_aggression

/datum/action/cooldown/spell/slasher_chase/princess/cast(mob/living/cast_on)
	for(var/datum/antagonist/slasher/princess/our_slasher in owner?.mind?.antag_datums)
		our_slasher.chase_movespeed_mod = initial(our_slasher.chase_movespeed_mod)
		our_slasher.chase_movespeed_mod -= (our_slasher.aggression * 0.005) // get speedy; get silly
	. = ..()
