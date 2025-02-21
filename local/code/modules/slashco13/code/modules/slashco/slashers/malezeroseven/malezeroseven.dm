/datum/antagonist/slasher/malezeroseven
	name = "Male_07"
	mob_type = /mob/living/basic/slasher/malezeroseven
	ui_name = "AntagInfoMaleZeroSeven"
	fluff = "One of many..."
	jumpscare_sound = 'local/code/modules/slashco13/sound/slasher/malezeroseven/kill.ogg'
	jumpscare_icon = 'local/code/modules/slashco13/icons/ui/jumpscares/malezeroseven.dmi'
	jumpscare_icon_state = "malezeroseven"
	jumpscare_volume = 75

/datum/antagonist/slasher/malezeroseven/give_slasher_abilities()
	. = ..()
	for(var/found_npc_spawn in GLOB.slash_npc_spawns)
		if(prob(15))
			for(var/integer=1 to 2)
				new /mob/living/basic/slasher/malezeroseven(found_npc_spawn)
		else
			new /mob/living/basic/slasher/malezeroseven(found_npc_spawn)

/datum/antagonist/slasher/malezeroseven/setup_chase_music()
	our_chase_music.start_sound = 'local/code/modules/slashco13/sound/slasher/malezeroseven/chasemusic/01ChaseMusic.ogg'
	our_chase_music.start_length = 1 SECONDS
	our_chase_music.mid_sounds = list(
		'local/code/modules/slashco13/sound/slasher/malezeroseven/chasemusic/02ChaseMusic.ogg' = 1, \
		'local/code/modules/slashco13/sound/slasher/malezeroseven/chasemusic/03ChaseMusic.ogg' = 1, \
		'local/code/modules/slashco13/sound/slasher/malezeroseven/chasemusic/04ChaseMusic.ogg' = 1, \
		'local/code/modules/slashco13/sound/slasher/malezeroseven/chasemusic/05ChaseMusic.ogg' = 1, \
		'local/code/modules/slashco13/sound/slasher/malezeroseven/chasemusic/06ChaseMusic.ogg' = 1, \
		'local/code/modules/slashco13/sound/slasher/malezeroseven/chasemusic/07ChaseMusic.ogg' = 1, \
		'local/code/modules/slashco13/sound/slasher/malezeroseven/chasemusic/08ChaseMusic.ogg' = 1, \
		'local/code/modules/slashco13/sound/slasher/malezeroseven/chasemusic/09ChaseMusic.ogg' = 1, \
		'local/code/modules/slashco13/sound/slasher/malezeroseven/chasemusic/10ChaseMusic.ogg' = 1, \
		'local/code/modules/slashco13/sound/slasher/malezeroseven/chasemusic/11ChaseMusic.ogg' = 1, \
		'local/code/modules/slashco13/sound/slasher/malezeroseven/chasemusic/12ChaseMusic.ogg' = 1, \
		'local/code/modules/slashco13/sound/slasher/malezeroseven/chasemusic/13ChaseMusic.ogg' = 1, \
		'local/code/modules/slashco13/sound/slasher/malezeroseven/chasemusic/14ChaseMusic.ogg' = 1, \
		'local/code/modules/slashco13/sound/slasher/malezeroseven/chasemusic/15ChaseMusic.ogg' = 1, \
		'local/code/modules/slashco13/sound/slasher/malezeroseven/chasemusic/16ChaseMusic.ogg' = 1, \
		'local/code/modules/slashco13/sound/slasher/malezeroseven/chasemusic/17ChaseMusic.ogg' = 1, \
		'local/code/modules/slashco13/sound/slasher/malezeroseven/chasemusic/18ChaseMusic.ogg' = 1, \
		'local/code/modules/slashco13/sound/slasher/malezeroseven/chasemusic/19ChaseMusic.ogg' = 1, \
		'local/code/modules/slashco13/sound/slasher/malezeroseven/chasemusic/20ChaseMusic.ogg' = 1, \
		'local/code/modules/slashco13/sound/slasher/malezeroseven/chasemusic/21ChaseMusic.ogg' = 1, \
		'local/code/modules/slashco13/sound/slasher/malezeroseven/chasemusic/22ChaseMusic.ogg' = 1, \
		'local/code/modules/slashco13/sound/slasher/malezeroseven/chasemusic/23ChaseMusic.ogg' = 1, \
		'local/code/modules/slashco13/sound/slasher/malezeroseven/chasemusic/24ChaseMusic.ogg' = 1, \
		'local/code/modules/slashco13/sound/slasher/malezeroseven/chasemusic/25ChaseMusic.ogg' = 1, \
		'local/code/modules/slashco13/sound/slasher/malezeroseven/chasemusic/26ChaseMusic.ogg' = 1, \
		'local/code/modules/slashco13/sound/slasher/malezeroseven/chasemusic/27ChaseMusic.ogg' = 1, \
		'local/code/modules/slashco13/sound/slasher/malezeroseven/chasemusic/28ChaseMusic.ogg' = 1, \
		'local/code/modules/slashco13/sound/slasher/malezeroseven/chasemusic/29ChaseMusic.ogg' = 1, \
		'local/code/modules/slashco13/sound/slasher/malezeroseven/chasemusic/30ChaseMusic.ogg' = 1, \
		'local/code/modules/slashco13/sound/slasher/malezeroseven/chasemusic/31ChaseMusic.ogg' = 1, \
		'local/code/modules/slashco13/sound/slasher/malezeroseven/chasemusic/32ChaseMusic.ogg' = 1, \
		'local/code/modules/slashco13/sound/slasher/malezeroseven/chasemusic/33ChaseMusic.ogg' = 1, \
		'local/code/modules/slashco13/sound/slasher/malezeroseven/chasemusic/34ChaseMusic.ogg' = 1, \
		'local/code/modules/slashco13/sound/slasher/malezeroseven/chasemusic/35ChaseMusic.ogg' = 1, \
		'local/code/modules/slashco13/sound/slasher/malezeroseven/chasemusic/36ChaseMusic.ogg' = 1, \
		'local/code/modules/slashco13/sound/slasher/malezeroseven/chasemusic/37ChaseMusic.ogg' = 1, \
		'local/code/modules/slashco13/sound/slasher/malezeroseven/chasemusic/38ChaseMusic.ogg' = 1, \
		'local/code/modules/slashco13/sound/slasher/malezeroseven/chasemusic/39ChaseMusic.ogg' = 1, \
		'local/code/modules/slashco13/sound/slasher/malezeroseven/chasemusic/40ChaseMusic.ogg' = 1, \
		'local/code/modules/slashco13/sound/slasher/malezeroseven/chasemusic/41ChaseMusic.ogg' = 1, \
		'local/code/modules/slashco13/sound/slasher/malezeroseven/chasemusic/42ChaseMusic.ogg' = 1, \
		'local/code/modules/slashco13/sound/slasher/malezeroseven/chasemusic/43ChaseMusic.ogg' = 1, \
		'local/code/modules/slashco13/sound/slasher/malezeroseven/chasemusic/44ChaseMusic.ogg' = 1, \
		'local/code/modules/slashco13/sound/slasher/malezeroseven/chasemusic/45ChaseMusic.ogg' = 1, \
		'local/code/modules/slashco13/sound/slasher/malezeroseven/chasemusic/46ChaseMusic.ogg' = 1, \
		'local/code/modules/slashco13/sound/slasher/malezeroseven/chasemusic/47ChaseMusic.ogg' = 1, \
		'local/code/modules/slashco13/sound/slasher/malezeroseven/chasemusic/48ChaseMusic.ogg' = 1, \
		'local/code/modules/slashco13/sound/slasher/malezeroseven/chasemusic/49ChaseMusic.ogg' = 1, \
		'local/code/modules/slashco13/sound/slasher/malezeroseven/chasemusic/50ChaseMusic.ogg' = 1, \
		'local/code/modules/slashco13/sound/slasher/malezeroseven/chasemusic/51ChaseMusic.ogg' = 1, \
		'local/code/modules/slashco13/sound/slasher/malezeroseven/chasemusic/52ChaseMusic.ogg' = 1, \
		'local/code/modules/slashco13/sound/slasher/malezeroseven/chasemusic/53ChaseMusic.ogg' = 1, \
		'local/code/modules/slashco13/sound/slasher/malezeroseven/chasemusic/54ChaseMusic.ogg' = 1, \
		'local/code/modules/slashco13/sound/slasher/malezeroseven/chasemusic/55ChaseMusic.ogg' = 1, \
		'local/code/modules/slashco13/sound/slasher/malezeroseven/chasemusic/56ChaseMusic.ogg' = 1, \
		'local/code/modules/slashco13/sound/slasher/malezeroseven/chasemusic/57ChaseMusic.ogg' = 1, \
		'local/code/modules/slashco13/sound/slasher/malezeroseven/chasemusic/58ChaseMusic.ogg' = 1, \
		'local/code/modules/slashco13/sound/slasher/malezeroseven/chasemusic/59ChaseMusic.ogg' = 1, \
		'local/code/modules/slashco13/sound/slasher/malezeroseven/chasemusic/60ChaseMusic.ogg' = 1, \
	)
	our_chase_music.mid_length = 1 SECONDS
	our_chase_music.end_sound = null
	return
