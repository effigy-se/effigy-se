/datum/antagonist/slasher/impostor
	name = "The Impostor"
	var/datum/action/cooldown/spell/shapeshift/impostor/shapeshift_true_form

/datum/antagonist/slasher/impostor/proc/give_slasher_abilities()
	shapeshift_true_form = new
	shapeshift_true_form.Grant(owner.current)

/// Impostor Spells ///
/datum/action/cooldown/spell/shapeshift/impostor
	name = "Assume True Form"
	desc = "Exit our disguise and return to our natural form."
	cooldown_time = 0 SECONDS

	invocation_type = INVOCATION_NONE
	spell_requirements = NONE

	possible_shapes = list(/mob/living/simple_animal/slime/transformed_slime) // TEMP

/datum/action/cooldown/spell/shapeshift/imposter/do_unshapeshift(mob/living/caster)
	. = ..()
	caster.sleep(3 SECONDS)
	playsound(caster, 'sound/slashco/slasher/imposter/disguise.ogg')

/datum/action/cooldown/spell/shapeshift/imposter/do_shapeshift(mob/living/caster)
	. = ..()
	caster.sleep(3 SECONDS)
	playsound(caster, 'sound/slashco/slasher/imposter/undisguise.ogg')
