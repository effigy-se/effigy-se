/datum/antagonist/slasher/bababooey
	name = "Bababooey"
	mob_type = /mob/living/basic/slasher/bababooey
	fluff = "Bababooey."
	ui_name = "AntagInfoBababooey"
	jumpscare_icon_state = "bababooey"
	jumpscare_sound = 'local/code/modules/slashco13/sound/slasher/bababooey/kill.ogg'
	jumpscare_volume = 25
	jumpscare_time = 2 SECONDS
	chase_cooldown_length = 28

/datum/antagonist/slasher/bababooey/setup_chase_music()
	our_chase_music.start_sound = null
	our_chase_music.start_length = 1
	our_chase_music.mid_sounds = list(
		'local/code/modules/slashco13/sound/slasher/bababooey/chasemusic/01ChaseMusic.ogg' = 1, \
		'local/code/modules/slashco13/sound/slasher/bababooey/chasemusic/02ChaseMusic.ogg' = 1, \
		'local/code/modules/slashco13/sound/slasher/bababooey/chasemusic/03ChaseMusic.ogg' = 1, \
		'local/code/modules/slashco13/sound/slasher/bababooey/chasemusic/04ChaseMusic.ogg' = 1, \
		'local/code/modules/slashco13/sound/slasher/bababooey/chasemusic/05ChaseMusic.ogg' = 1, \
		'local/code/modules/slashco13/sound/slasher/bababooey/chasemusic/06ChaseMusic.ogg' = 1, \
		'local/code/modules/slashco13/sound/slasher/bababooey/chasemusic/07ChaseMusic.ogg' = 1, \
		'local/code/modules/slashco13/sound/slasher/bababooey/chasemusic/08ChaseMusic.ogg' = 1, \
		'local/code/modules/slashco13/sound/slasher/bababooey/chasemusic/09ChaseMusic.ogg' = 1, \
		'local/code/modules/slashco13/sound/slasher/bababooey/chasemusic/10ChaseMusic.ogg' = 1, \
		'local/code/modules/slashco13/sound/slasher/bababooey/chasemusic/11ChaseMusic.ogg' = 1, \
		'local/code/modules/slashco13/sound/slasher/bababooey/chasemusic/12ChaseMusic.ogg' = 1, \
		'local/code/modules/slashco13/sound/slasher/bababooey/chasemusic/13ChaseMusic.ogg' = 1, \
		'local/code/modules/slashco13/sound/slasher/bababooey/chasemusic/14ChaseMusic.ogg' = 1, \
		'local/code/modules/slashco13/sound/slasher/bababooey/chasemusic/15ChaseMusic.ogg' = 1, \
		'local/code/modules/slashco13/sound/slasher/bababooey/chasemusic/16ChaseMusic.ogg' = 1, \
		'local/code/modules/slashco13/sound/slasher/bababooey/chasemusic/17ChaseMusic.ogg' = 1, \
		'local/code/modules/slashco13/sound/slasher/bababooey/chasemusic/18ChaseMusic.ogg' = 1, \
		'local/code/modules/slashco13/sound/slasher/bababooey/chasemusic/19ChaseMusic.ogg' = 1, \
		'local/code/modules/slashco13/sound/slasher/bababooey/chasemusic/20ChaseMusic.ogg' = 1, \
		'local/code/modules/slashco13/sound/slasher/bababooey/chasemusic/21ChaseMusic.ogg' = 1, \
		'local/code/modules/slashco13/sound/slasher/bababooey/chasemusic/22ChaseMusic.ogg' = 1, \
		'local/code/modules/slashco13/sound/slasher/bababooey/chasemusic/23ChaseMusic.ogg' = 1, \
		'local/code/modules/slashco13/sound/slasher/bababooey/chasemusic/24ChaseMusic.ogg' = 1, \
		'local/code/modules/slashco13/sound/slasher/bababooey/chasemusic/25ChaseMusic.ogg' = 1, \
		'local/code/modules/slashco13/sound/slasher/bababooey/chasemusic/26ChaseMusic.ogg' = 1, \
		'local/code/modules/slashco13/sound/slasher/bababooey/chasemusic/27ChaseMusic.ogg' = 1, \
		'local/code/modules/slashco13/sound/slasher/bababooey/chasemusic/28ChaseMusic.ogg' = 1, \
		'local/code/modules/slashco13/sound/slasher/bababooey/chasemusic/29ChaseMusic.ogg' = 1, \
		'local/code/modules/slashco13/sound/slasher/bababooey/chasemusic/30ChaseMusic.ogg' = 1, \
		'local/code/modules/slashco13/sound/slasher/bababooey/chasemusic/31ChaseMusic.ogg' = 1, \
		'local/code/modules/slashco13/sound/slasher/bababooey/chasemusic/32ChaseMusic.ogg' = 1, \
		'local/code/modules/slashco13/sound/slasher/bababooey/chasemusic/33ChaseMusic.ogg' = 1, \
		'local/code/modules/slashco13/sound/slasher/bababooey/chasemusic/34ChaseMusic.ogg' = 1, \
		'local/code/modules/slashco13/sound/slasher/bababooey/chasemusic/35ChaseMusic.ogg' = 1, \
		'local/code/modules/slashco13/sound/slasher/bababooey/chasemusic/36ChaseMusic.ogg' = 1, \
		'local/code/modules/slashco13/sound/slasher/bababooey/chasemusic/37ChaseMusic.ogg' = 1, \
		'local/code/modules/slashco13/sound/slasher/bababooey/chasemusic/38ChaseMusic.ogg' = 1, \
		'local/code/modules/slashco13/sound/slasher/bababooey/chasemusic/39ChaseMusic.ogg' = 1, \
		'local/code/modules/slashco13/sound/slasher/bababooey/chasemusic/40ChaseMusic.ogg' = 1, \
		'local/code/modules/slashco13/sound/slasher/bababooey/chasemusic/41ChaseMusic.ogg' = 1, \
		'local/code/modules/slashco13/sound/slasher/bababooey/chasemusic/42ChaseMusic.ogg' = 1, \
		'local/code/modules/slashco13/sound/slasher/bababooey/chasemusic/43ChaseMusic.ogg' = 1, \
		'local/code/modules/slashco13/sound/slasher/bababooey/chasemusic/44ChaseMusic.ogg' = 1, \
		'local/code/modules/slashco13/sound/slasher/bababooey/chasemusic/45ChaseMusic.ogg' = 1, \
		'local/code/modules/slashco13/sound/slasher/bababooey/chasemusic/46ChaseMusic.ogg' = 1, \
		'local/code/modules/slashco13/sound/slasher/bababooey/chasemusic/47ChaseMusic.ogg' = 1, \
		'local/code/modules/slashco13/sound/slasher/bababooey/chasemusic/48ChaseMusic.ogg' = 1, \
		'local/code/modules/slashco13/sound/slasher/bababooey/chasemusic/49ChaseMusic.ogg' = 1, \
		'local/code/modules/slashco13/sound/slasher/bababooey/chasemusic/50ChaseMusic.ogg' = 1, \
		'local/code/modules/slashco13/sound/slasher/bababooey/chasemusic/51ChaseMusic.ogg' = 1, \
		'local/code/modules/slashco13/sound/slasher/bababooey/chasemusic/52ChaseMusic.ogg' = 1, \
		'local/code/modules/slashco13/sound/slasher/bababooey/chasemusic/53ChaseMusic.ogg' = 1, \
		'local/code/modules/slashco13/sound/slasher/bababooey/chasemusic/54ChaseMusic.ogg' = 1, \
		'local/code/modules/slashco13/sound/slasher/bababooey/chasemusic/55ChaseMusic.ogg' = 1, \
		)
	our_chase_music.mid_length = 1 SECONDS
	our_chase_music.end_sound = null
