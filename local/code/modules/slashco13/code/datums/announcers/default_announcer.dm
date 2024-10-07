/datum/centcom_announcer/default
	welcome_sounds = list(
		'local/code/modules/slashco13/sound/shuttle/intro1.ogg', \
		'local/code/modules/slashco13/sound/shuttle/intro2.ogg', \
		'local/code/modules/slashco13/sound/shuttle/intro3.ogg', \
		'local/code/modules/slashco13/sound/shuttle/intro4.ogg', \
		'local/code/modules/slashco13/sound/shuttle/intro5.ogg', \
		'local/code/modules/slashco13/sound/shuttle/intro6.ogg', \
		'local/code/modules/slashco13/sound/shuttle/intro7.ogg', \
		'local/code/modules/slashco13/sound/shuttle/intro8.ogg', \
	)

/datum/centcom_announcer/medbot
	welcome_sounds = /datum/centcom_announcer/default::welcome_sounds

/datum/centcom_announcer/intern
	welcome_sounds = /datum/centcom_announcer/default::welcome_sounds
