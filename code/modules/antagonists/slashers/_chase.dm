/datum/action/cooldown/spell/chase
	name = "Chase"
	desc = "Sprint towards visibile survivors with bravado. Sprint charge \
	rapidly depletes when survivors aren't visible. "
	background_icon_state = "bg_heretic"
	overlay_icon_state = "bg_heretic_border"
	button_icon = 'icons/mob/actions/actions_mecha.dmi'
	button_icon_state = "mech_overload_off"
	sound = 'sound/effects/curse2.ogg'

	school = SCHOOL_FORBIDDEN
	cooldown_time = 20 SECONDS

	invocation_type = INVOCATION_NONE
	spell_requirements = NONE

/datum/action/cooldown/spell/chase/cast(mob/living/cast_on)
	return // TODO. fuck. help
