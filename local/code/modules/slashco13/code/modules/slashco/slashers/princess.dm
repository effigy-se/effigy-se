/datum/antagonist/slasher/princess
	name = "Princess"
	mob_type = /mob/living/basic/slasher/princess
	chase_length = 10 SECONDS
	jumpscare_icon = null
	jumpscare_time = 1.5 SECONDS
	jumpscare_sound = 'local/code/modules/slashco13/sound/slasher/princess/attack.ogg'
	clear_sounds_when_chase_over = TRUE
	/// Our current aggression value. Increases by 1 each second.
	var/aggression = 0
	/// Our maximum aggression value. Clamps at 100; starts at 50.
	var/maximum_aggression = 50
	/// Our aggression 'prestige'. Increases by when Princess eats a Faustian doll; and acts as a multiplier for aggression gain.
	var/aggression_prestige = 0.1

	var/datum/looping_sound/princess_grumbling_idle/our_grumbles
	var/datum/looping_sound/princess_grumbling_angry/our_angry_grumbles

/datum/antagonist/slasher/princess/setup_chase_music()
	our_chase_music.start_sound = 'local/code/modules/slashco13/sound/slasher/princess/chase.ogg'
	our_chase_music.start_length = 240
	our_chase_music.mid_sounds = list('local/code/modules/slashco13/sound/slasher/princess/chase.ogg' = 1)
	our_chase_music.mid_length = 240
	our_chase_music.end_sound = null
	return

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
	. = ..()
	our_grumbles = new
	our_grumbles.start(owner.current)
	our_angry_grumbles = new
	START_PROCESSING(SSprocessing, src)

/datum/antagonist/slasher/princess/process(seconds_per_tick)
	aggression += (seconds_per_tick * aggression_prestige)
	if(aggression > maximum_aggression)
		aggression = maximum_aggression

/datum/antagonist/slasher/princess/jumpscare(mob/living/target, mob/living/user)
	. = ..()
	playsound(src, 'local/code/modules/slashco13/sound/slasher/princess/bite.ogg', 75, FALSE)

/datum/antagonist/slasher/princess/slasher_specific_chase_handling()
	chase_movespeed_mod = initial(chase_movespeed_mod)
	chase_movespeed_mod -= (aggression * 0.0025) // get speedy; get silly
	our_grumbles.stop(TRUE)
	our_angry_grumbles.start(owner.current)
	aggression -= 10
	addtimer(CALLBACK(src, PROC_REF(switch_grumbles_back)), chase_length)
	return TRUE

/datum/antagonist/slasher/princess/proc/switch_grumbles_back()
	our_angry_grumbles.stop(TRUE)
	our_grumbles.start(owner.current)
