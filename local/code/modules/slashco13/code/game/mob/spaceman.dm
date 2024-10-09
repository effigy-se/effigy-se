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
	sight = SEE_SELF
	pass_flags = PASSTABLE | PASSGLASS | PASSGRILLE | PASSMOB | PASSCLOSEDTURF | PASSMACHINE | PASSSTRUCTURE | PASSFLAPS | PASSDOORS | PASSVEHICLE | PASSITEM | PASSWINDOW
	alpha = 127.5
	density = FALSE

/mob/living/basic/slasher/spaceman/attack_hand(mob/living/carbon/human/user, list/modifiers)
	. = ..()
	for(var/datum/antagonist/slasher/spaceman/our_slasher in mind?.antag_datums)
		if(!our_slasher.active_phase)
			throw_at(get_edge_target_turf(src, dir), range = rand(1, 2), speed = 7, thrower = user)
