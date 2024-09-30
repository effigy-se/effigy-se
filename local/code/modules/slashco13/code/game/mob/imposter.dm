/mob/living/basic/slasher/imposter
	name = "The Imposter"
	desc = "The Imposter Slasher who is the master of deception and hiding in plain sight."
	icon_state = "amogus"

/mob/living/basic/slasher/imposter/Initialize(mapload)
	. = ..()
	AddElement(/datum/element/footstep, FOOTSTEP_IMPOSTER)
