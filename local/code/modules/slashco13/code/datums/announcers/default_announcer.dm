/datum/centcom_announcer/default
	welcome_sounds = list(
		'local/code/modules/slashco13/sound/helipilot/shuttle/intro1.ogg'
		'local/code/modules/slashco13/sound/helipilot/shuttle/intro2.ogg'
		'local/code/modules/slashco13/sound/helipilot/shuttle/intro3.ogg'
		'local/code/modules/slashco13/sound/helipilot/shuttle/intro4.ogg'
		'local/code/modules/slashco13/sound/helipilot/shuttle/intro5.ogg'
		'local/code/modules/slashco13/sound/helipilot/shuttle/intro6.ogg'
		'local/code/modules/slashco13/sound/helipilot/shuttle/intro7.ogg'
		'local/code/modules/slashco13/sound/helipilot/shuttle/intro8.ogg'
	)

/datum/centcom_announcer/medbot
	welcome_sounds = /datum/centcom_announcer/default::welcome_sounds

/datum/centcom_announcer/intern
	welcome_sounds = /datum/centcom_announcer/default::welcome_sounds
