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

	var/datum/looping_sound/princess_grumbling_idle/our_grumbles
	var/datum/looping_sound/princess_grumbling_angry/our_angry_grumbles

/datum/looping_sound/slasher_chase/princess
	start_sound = 'local/code/modules/slashco13/sound/slasher/princess/chase.ogg'
	start_length = 5 // needs in-game testing (needs to be cranked tf up)
	mid_sounds = list('local/code/modules/slashco13/sound/slasher/princess/chase.ogg' = 1)
	mid_length = 5 // ditto
	end_sound = null

/datum/looping_sound/princess_grumbling_idle
	start_sound = null
	start_length = 1
	mid_sounds = list(
		'local/code/modules/slashco13/sound/slasher/princess/idle1.ogg' = 1, \
		'local/code/modules/slashco13/sound/slasher/princess/idle2.ogg' = 1, \
		'local/code/modules/slashco13/sound/slasher/princess/idle3.ogg' = 1, \
		'local/code/modules/slashco13/sound/slasher/princess/idle4.ogg' = 1, \
		'local/code/modules/slashco13/sound/slasher/princess/idle5.ogg' = 1, \
		'local/code/modules/slashco13/sound/slasher/princess/idle6.ogg' = 1, \
		'local/code/modules/slashco13/sound/slasher/princess/idle7.ogg' = 1, \
		'local/code/modules/slashco13/sound/slasher/princess/idle8.ogg' = 1, \
		'local/code/modules/slashco13/sound/slasher/princess/idle9.ogg' = 1, \
		)
	mid_length = 8 SECONDS
	end_sound = null

/datum/looping_sound/princess_grumbling_angry
	start_sound = null
	start_length = 1
	mid_sounds = list(
		'local/code/modules/slashco13/sound/slasher/princess/chase1.ogg' = 1, \
		'local/code/modules/slashco13/sound/slasher/princess/chase2.ogg' = 1, \
		'local/code/modules/slashco13/sound/slasher/princess/chase3.ogg' = 1, \
		'local/code/modules/slashco13/sound/slasher/princess/chase4.ogg' = 1, \
		'local/code/modules/slashco13/sound/slasher/princess/chase5.ogg' = 1, \
		'local/code/modules/slashco13/sound/slasher/princess/chase6.ogg' = 1, \
		'local/code/modules/slashco13/sound/slasher/princess/chase7.ogg' = 1, \
		'local/code/modules/slashco13/sound/slasher/princess/chase8.ogg' = 1, \
		'local/code/modules/slashco13/sound/slasher/princess/chase9.ogg' = 1, \
		'local/code/modules/slashco13/sound/slasher/princess/chase10.ogg' = 1, \
		'local/code/modules/slashco13/sound/slasher/princess/chase11.ogg' = 1, \
		'local/code/modules/slashco13/sound/slasher/princess/chase12.ogg' = 1, \
		'local/code/modules/slashco13/sound/slasher/princess/chase13.ogg' = 1, \
		'local/code/modules/slashco13/sound/slasher/princess/chase14.ogg' = 1, \
		'local/code/modules/slashco13/sound/slasher/princess/chase15.ogg' = 1, \
		)
	mid_length = 4 SECONDS
	end_sound = null

/datum/antagonist/slasher/princess/give_slasher_abilities()
	our_grumbles = new
	our_grumbles.start(owner.current)
	our_angry_grumbles = new
	START_PROCESSING(SSprocessing, src)

/datum/antagonist/slasher/princess/process(seconds_per_tick)
	aggression += (seconds_per_tick * aggression_prestige)
	if(aggression > maximum_aggression)
		aggression = maximum_aggression

/datum/action/cooldown/spell/slasher_chase/princess/cast(mob/living/cast_on)
	for(var/datum/antagonist/slasher/princess/our_slasher in owner?.mind?.antag_datums)
		our_slasher.chase_movespeed_mod = initial(our_slasher.chase_movespeed_mod)
		our_slasher.chase_movespeed_mod -= (our_slasher.aggression * 0.005) // get speedy; get silly
		our_slasher.our_grumbles.stop(TRUE)
		our_slasher.our_angry_grumbles.start(owner)
		addtimer(CALLBACK(src, PROC_REF(switch_grumbles_back), cast_on), our_slasher.chase_length)
	. = ..()

/datum/action/cooldown/spell/slasher_chase/princess/proc/switch_grumbles_back(mob/living/cast_on)
	for(var/datum/antagonist/slasher/princess/our_slasher in owner?.mind?.antag_datums)
		our_slasher.our_angry_grumbles.stop(TRUE)
		our_slasher.our_grumbles.start(owner)
