/// one of the lightest antags on a datum level tbh; not much special outside of what's on the mob from
/datum/antagonist/slasher/borgmire
	name = "\improper Borgmire"
	mob_type = /mob/living/basic/slasher/borgmire
	fluff = "Your cold; metallic heart beats..."
	ui_name = "AntagInfoBorgmire"

	var/datum/looping_sound/borgmire_heartbeat/our_heartbeat
	var/datum/looping_sound/borgmire_breathing/our_breathing
	var/datum/looping_sound/borgmire_malding/our_malding

/datum/antagonist/slasher/borgmire/setup_chase_music()
	our_chase_music.start_sound = 'local/code/modules/slashco13/sound/slasher/borgmire/chasemusic/01ChaseMusic.ogg'
	our_chase_music.start_length = 3 SECONDS
	our_chase_music.mid_sounds = list(
		'local/code/modules/slashco13/sound/slasher/borgmire/chasemusic/02ChaseMusic.ogg' = 1, \
		'local/code/modules/slashco13/sound/slasher/borgmire/chasemusic/03ChaseMusic.ogg' = 1, \
		'local/code/modules/slashco13/sound/slasher/borgmire/chasemusic/04ChaseMusic.ogg' = 1, \
		'local/code/modules/slashco13/sound/slasher/borgmire/chasemusic/05ChaseMusic.ogg' = 1, \
		'local/code/modules/slashco13/sound/slasher/borgmire/chasemusic/06ChaseMusic.ogg' = 1, \
		'local/code/modules/slashco13/sound/slasher/borgmire/chasemusic/07ChaseMusic.ogg' = 1, \
		'local/code/modules/slashco13/sound/slasher/borgmire/chasemusic/08ChaseMusic.ogg' = 1, \
		'local/code/modules/slashco13/sound/slasher/borgmire/chasemusic/09ChaseMusic.ogg' = 1, \
		'local/code/modules/slashco13/sound/slasher/borgmire/chasemusic/10ChaseMusic.ogg' = 1, \
		'local/code/modules/slashco13/sound/slasher/borgmire/chasemusic/11ChaseMusic.ogg' = 1, \
		'local/code/modules/slashco13/sound/slasher/borgmire/chasemusic/12ChaseMusic.ogg' = 1, \
		'local/code/modules/slashco13/sound/slasher/borgmire/chasemusic/13ChaseMusic.ogg' = 1, \
		'local/code/modules/slashco13/sound/slasher/borgmire/chasemusic/14ChaseMusic.ogg' = 1, \
		'local/code/modules/slashco13/sound/slasher/borgmire/chasemusic/15ChaseMusic.ogg' = 1, \
		'local/code/modules/slashco13/sound/slasher/borgmire/chasemusic/16ChaseMusic.ogg' = 1, \
		'local/code/modules/slashco13/sound/slasher/borgmire/chasemusic/17ChaseMusic.ogg' = 1, \
		'local/code/modules/slashco13/sound/slasher/borgmire/chasemusic/18ChaseMusic.ogg' = 1, \
		'local/code/modules/slashco13/sound/slasher/borgmire/chasemusic/19ChaseMusic.ogg' = 1, \
		'local/code/modules/slashco13/sound/slasher/borgmire/chasemusic/20ChaseMusic.ogg' = 1, \
		'local/code/modules/slashco13/sound/slasher/borgmire/chasemusic/21ChaseMusic.ogg' = 1, \
		'local/code/modules/slashco13/sound/slasher/borgmire/chasemusic/22ChaseMusic.ogg' = 1, \
		'local/code/modules/slashco13/sound/slasher/borgmire/chasemusic/23ChaseMusic.ogg' = 1, \
		'local/code/modules/slashco13/sound/slasher/borgmire/chasemusic/24ChaseMusic.ogg' = 1, \
		'local/code/modules/slashco13/sound/slasher/borgmire/chasemusic/25ChaseMusic.ogg' = 1, \
		'local/code/modules/slashco13/sound/slasher/borgmire/chasemusic/26ChaseMusic.ogg' = 1, \
		'local/code/modules/slashco13/sound/slasher/borgmire/chasemusic/27ChaseMusic.ogg' = 1, \
		'local/code/modules/slashco13/sound/slasher/borgmire/chasemusic/28ChaseMusic.ogg' = 1, \
		'local/code/modules/slashco13/sound/slasher/borgmire/chasemusic/29ChaseMusic.ogg' = 1, \
		'local/code/modules/slashco13/sound/slasher/borgmire/chasemusic/30ChaseMusic.ogg' = 1, \
		'local/code/modules/slashco13/sound/slasher/borgmire/chasemusic/31ChaseMusic.ogg' = 1, \
		'local/code/modules/slashco13/sound/slasher/borgmire/chasemusic/32ChaseMusic.ogg' = 1, \
		'local/code/modules/slashco13/sound/slasher/borgmire/chasemusic/33ChaseMusic.ogg' = 1, \
		'local/code/modules/slashco13/sound/slasher/borgmire/chasemusic/34ChaseMusic.ogg' = 1, \
		'local/code/modules/slashco13/sound/slasher/borgmire/chasemusic/35ChaseMusic.ogg' = 1, \
		'local/code/modules/slashco13/sound/slasher/borgmire/chasemusic/36ChaseMusic.ogg' = 1, \
		'local/code/modules/slashco13/sound/slasher/borgmire/chasemusic/37ChaseMusic.ogg' = 1, \
		'local/code/modules/slashco13/sound/slasher/borgmire/chasemusic/38ChaseMusic.ogg' = 1, \
		'local/code/modules/slashco13/sound/slasher/borgmire/chasemusic/39ChaseMusic.ogg' = 1, \
		'local/code/modules/slashco13/sound/slasher/borgmire/chasemusic/40ChaseMusic.ogg' = 1, \
		'local/code/modules/slashco13/sound/slasher/borgmire/chasemusic/41ChaseMusic.ogg' = 1, \
		'local/code/modules/slashco13/sound/slasher/borgmire/chasemusic/42ChaseMusic.ogg' = 1, \
		'local/code/modules/slashco13/sound/slasher/borgmire/chasemusic/43ChaseMusic.ogg' = 1, \
		'local/code/modules/slashco13/sound/slasher/borgmire/chasemusic/44ChaseMusic.ogg' = 1, \
		'local/code/modules/slashco13/sound/slasher/borgmire/chasemusic/45ChaseMusic.ogg' = 1, \
		'local/code/modules/slashco13/sound/slasher/borgmire/chasemusic/46ChaseMusic.ogg' = 1, \
		'local/code/modules/slashco13/sound/slasher/borgmire/chasemusic/47ChaseMusic.ogg' = 1, \
		'local/code/modules/slashco13/sound/slasher/borgmire/chasemusic/48ChaseMusic.ogg' = 1, \
		'local/code/modules/slashco13/sound/slasher/borgmire/chasemusic/49ChaseMusic.ogg' = 1, \
		'local/code/modules/slashco13/sound/slasher/borgmire/chasemusic/50ChaseMusic.ogg' = 1, \
		'local/code/modules/slashco13/sound/slasher/borgmire/chasemusic/51ChaseMusic.ogg' = 1, \
		'local/code/modules/slashco13/sound/slasher/borgmire/chasemusic/52ChaseMusic.ogg' = 1, \
		'local/code/modules/slashco13/sound/slasher/borgmire/chasemusic/53ChaseMusic.ogg' = 1, \
		'local/code/modules/slashco13/sound/slasher/borgmire/chasemusic/54ChaseMusic.ogg' = 1, \
		'local/code/modules/slashco13/sound/slasher/borgmire/chasemusic/55ChaseMusic.ogg' = 1, \
		'local/code/modules/slashco13/sound/slasher/borgmire/chasemusic/56ChaseMusic.ogg' = 1, \
		'local/code/modules/slashco13/sound/slasher/borgmire/chasemusic/57ChaseMusic.ogg' = 1, \
		'local/code/modules/slashco13/sound/slasher/borgmire/chasemusic/58ChaseMusic.ogg' = 1, \
		'local/code/modules/slashco13/sound/slasher/borgmire/chasemusic/59ChaseMusic.ogg' = 1, \
	)
	our_chase_music.mid_length = 3 SECONDS
	our_chase_music.end_sound = null
	return

/datum/looping_sound/borgmire_heartbeat
	start_sound = null
	start_length = 1
	mid_sounds = list(
		'local/code/modules/slashco13/sound/slasher/borgmire/heartbeat.ogg' = 1, \
		)
	mid_length = 8 SECONDS
	end_sound = null
	volume = 15

/datum/looping_sound/borgmire_breathing
	start_sound = null
	start_length = 1
	mid_sounds = list(
		'local/code/modules/slashco13/sound/slasher/borgmire/breath_base.ogg' = 1, \
		)
	mid_length = 9 SECONDS
	end_sound = null
	volume = 50

/datum/looping_sound/borgmire_malding
	start_sound = null
	start_length = 1
	mid_sounds = list(
		'local/code/modules/slashco13/sound/slasher/borgmire/breath_chase.ogg' = 1, \
		)
	mid_length = 9 SECONDS
	end_sound = null
	volume = 50

/datum/antagonist/slasher/borgmire/give_slasher_abilities()
	. = ..()
	our_heartbeat = new
	our_heartbeat.start(owner.current)
	our_breathing = new
	our_breathing.start(owner.current)
	our_malding = new

/datum/antagonist/slasher/borgmire/slasher_specific_chase_handling()
	our_breathing.stop(TRUE)
	our_malding.start(owner.current)
	addtimer(CALLBACK(src, PROC_REF(switch_grumbles_back)), chase_length)
	return TRUE

/datum/antagonist/slasher/borgmire/proc/switch_grumbles_back()
	our_malding.stop(TRUE)
	our_breathing.start(owner.current)
