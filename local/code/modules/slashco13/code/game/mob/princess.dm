/mob/living/basic/slasher/princess
	name = "Princess"
	desc = "Found near your newborn baby."
	icon_state = "princess"
	gender = FEMALE

/mob/living/basic/slasher/princess/UnarmedAttack(atom/attack_target, proximity_flag, list/modifiers)
	. = ..()
	if(istype(attack_target, /obj/item/toy/faustian_doll))
		for(var/datum/antagonist/slasher/princess/our_slasher in owner?.mind?.antag_datums)
			our_slasher.aggression_prestige += 1
			qdel(attack_target)
			break
