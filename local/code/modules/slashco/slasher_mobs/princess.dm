#define MOVESPEED_ID_FRENZY "frenzied"

/atom/movable/screen/alert/status_effect/frenzy
	name = "Frenzied"
	desc = "You are in a frenzy!"
	icon_state = "lastresort"

/datum/status_effect/frenzy
	duration = 30 SECONDS
	alert_type = /atom/movable/screen/alert/status_effect/frenzy

/datum/status_effect/frenzy/on_apply()
	owner.add_movespeed_modifier(/datum/movespeed_modifier/frenzy)
	return ..()

/datum/status_effect/frenzy/be_replaced()
	owner.remove_movespeed_modifier(/datum/movespeed_modifier/frenzy)
	return ..()

/datum/status_effect/frenzy/on_remove()
	owner.remove_movespeed_modifier(/datum/movespeed_modifier/frenzy)
	return ..()

/datum/movespeed_modifier/frenzy
	movetypes = GROUND
	multiplicative_slowdown = -0.1
	id = MOVESPEED_ID_FRENZY

/mob/living/basic/slasher/princess
	name = "Princess"
	desc = "Found near your newborn baby."
	icon_state = "princess"
	gender = FEMALE

/mob/living/basic/slasher/princess/UnarmedAttack(atom/attack_target, proximity_flag, list/modifiers)
	. = ..()
	if(istype(attack_target, /obj/item/toy/faustian_doll))
		apply_status_effect(/datum/status_effect/frenzy)
		qdel(attack_target)

#undef MOVESPEED_ID_FRENZY
