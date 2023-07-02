GLOBAL_LIST_EMPTY(scream_types)

/datum/scream_type
	var/name
	var/list/male_screamsounds
	var/list/female_screamsounds

/datum/scream_type/none //Why would you want this?
	name = "No Scream"
	male_screamsounds = null
	female_screamsounds = null

/datum/scream_type/human
	name = "Human Scream"
	male_screamsounds = list('local/sound/emotes/voice/scream_m1.ogg', 'local/sound/emotes/voice/scream_m2.ogg')
	female_screamsounds = list('local/sound/emotes/voice/scream_f1.ogg', 'local/sound/emotes/voice/scream_f2.ogg')

/datum/scream_type/robotic
	name = "Robotic Scream"
	male_screamsounds = list('local/sound/emotes/voice/scream_silicon.ogg')
	female_screamsounds = null

/datum/scream_type/lizard
	name = "Lizard Scream"
	male_screamsounds = list('sound/voice/lizard/lizard_scream_1.ogg', 'sound/voice/lizard/lizard_scream_3.ogg')
	female_screamsounds = null

/datum/scream_type/lizard2
	name = "Lizard Scream 2"
	male_screamsounds = list('local/sound/emotes/voice/scream_lizard.ogg')
	female_screamsounds = null

/datum/scream_type/moth
	name = "Moth Scream"
	male_screamsounds = list('local/sound/emotes/voice/scream_moth.ogg')
	female_screamsounds = null

/datum/scream_type/jelly
	name = "Jelly Scream"
	male_screamsounds = list('local/sound/emotes/generic/jelly_scream.ogg')
	female_screamsounds = null

/datum/scream_type/vox
	name = "Vox Scream"
	male_screamsounds = list('local/sound/emotes/generic/voxscream.ogg')
	female_screamsounds = null

/datum/scream_type/tajaran
	name = "Cat Scream"
	male_screamsounds = list('local/sound/emotes/generic/cat_scream.ogg')
	female_screamsounds = null

/datum/scream_type/xeno
	name = "Xeno Scream"
	male_screamsounds = list('sound/voice/hiss6.ogg')
	female_screamsounds = null

/datum/scream_type/raptor //This is the Teshari scream ported from CitRP which was a cockatoo scream edited by BlackMajor.
	name = "Raptor Scream"
	male_screamsounds = list('local/sound/emotes/generic/raptorscream.ogg')
	female_screamsounds = null

/datum/scream_type/rodent //Ported from Polaris/Virgo.
	name = "Rodent Scream"
	male_screamsounds = list('local/sound/emotes/generic/rodentscream.ogg')
	female_screamsounds = null

/datum/scream_type/ethereal
	name = "Ethereal Scream"
	male_screamsounds = list('sound/voice/ethereal/ethereal_scream_1.ogg', 'sound/voice/ethereal/ethereal_scream_2.ogg', 'sound/voice/ethereal/ethereal_scream_3.ogg')
	female_screamsounds = null

//DONATOR SCREAMS
/datum/scream_type/zombie
	name = "Zombie Scream"
	male_screamsounds = list('local/sound/emotes/generic/zombie_scream.ogg')
	female_screamsounds = null

/datum/scream_type/monkey
	name = "Monkey Scream"
	male_screamsounds = list('local/sound/emotes/voice/scream_monkey.ogg')
	female_screamsounds = null

/datum/scream_type/gorilla
	name = "Gorilla Scream"
	male_screamsounds = list('sound/creatures/gorilla.ogg')
	female_screamsounds = null

/datum/scream_type/skeleton
	name = "Skeleton Scream"
	male_screamsounds = list('local/sound/emotes/voice/scream_skeleton.ogg')
	female_screamsounds = null
