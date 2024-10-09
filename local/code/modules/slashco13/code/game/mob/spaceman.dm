/mob/living/basic/slasher/spaceman
	name = "Spaceman"
	desc = "The Balance Slasher who controls the progress of the round. His ID says \"Tyler\", Security Assistant." // cute lil reference to what he actually is; mechanically speaking
	icon = /mob/living/basic/spaceman::icon
	icon_state = /mob/living/basic/spaceman::icon_state
	gender = MALE
	can_jumpscare = FALSE // not by default; for code sanity
	/// Bunch of stuff related to the gimmick here:
	invisibility = INVISIBILITY_OBSERVER
	see_invisible = SEE_INVISIBLE_LIVING
	pass_flags = PASSBLOB
	alpha = 127.5
	density = FALSE
