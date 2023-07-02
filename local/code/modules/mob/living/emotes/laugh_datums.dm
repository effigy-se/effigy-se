GLOBAL_LIST_EMPTY(laugh_types)

/datum/laugh_type
	var/name
	var/list/male_laughsounds
	var/list/female_laughsounds

/datum/laugh_type/none //Why would you want this?
	name = "No Laugh"
	male_laughsounds = null
	female_laughsounds = null

/datum/laugh_type/human
	name = "Human Laugh"
	male_laughsounds = list('sound/voice/human/manlaugh1.ogg',
						'sound/voice/human/manlaugh2.ogg')
	female_laughsounds = list('local/sound/emotes/generic/female/female_giggle_1.ogg',
					'local/sound/emotes/generic/female/female_giggle_2.ogg')

/datum/laugh_type/felinid
	name = "Felinid Laugh"
	male_laughsounds = list('local/sound/emotes/generic/nyahaha1.ogg',
			'local/sound/emotes/generic/nyahaha2.ogg',
			'local/sound/emotes/generic/nyaha.ogg',
			'local/sound/emotes/generic/nyahehe.ogg')
	female_laughsounds = null

/datum/laugh_type/moth
	name = "Moth Laugh"
	male_laughsounds = list('local/sound/emotes/generic/mothlaugh.ogg')
	female_laughsounds = null

/datum/laugh_type/insect
	name = "Insect Laugh"
	male_laughsounds = list('local/sound/emotes/generic/mothlaugh.ogg')
	female_laughsounds = null
