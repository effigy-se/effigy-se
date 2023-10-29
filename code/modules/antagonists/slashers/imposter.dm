/datum/antagonist/slasher/imposter
	name = "The Impostor"
	mob_type = /mob/living/basic/slasher/imposter
	var/datum/action/cooldown/spell/shapeshift/imposter/shapeshift_human

/datum/antagonist/slasher/imposter/give_slasher_abilities()
	shapeshift_human = new
	shapeshift_human.Grant(owner.current)
	. = ..()

/// Imposter Spells ///
/datum/action/cooldown/spell/shapeshift/imposter
	name = "Human Disguise"
	desc = "Assume the form of a hapless human."
	cooldown_time = 5 SECONDS

	invocation_type = INVOCATION_NONE
	spell_requirements = NONE

	possible_shapes = list(/mob/living/carbon/human)

/datum/action/cooldown/spell/shapeshift/imposter/do_unshapeshift(mob/living/caster)
	. = ..()
	caster.Paralyze(3 SECONDS)
	playsound(get_turf(caster), 'sound/slashco/slasher/imposter/undisguise.ogg', 75)

/datum/action/cooldown/spell/shapeshift/imposter/do_shapeshift(mob/living/caster)
	. = ..()
	caster.Paralyze(3 SECONDS)
	playsound(get_turf(caster), 'sound/slashco/slasher/imposter/disguise.ogg', 75)
	addtimer(CALLBACK(playsound(get_turf(caster), 'sound/slashco/slasher/imposter/amogus.ogg', 75)), 5 SECONDS)
