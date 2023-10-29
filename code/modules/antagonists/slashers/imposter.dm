/datum/antagonist/slasher/imposter
	name = "The Imposter"
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
	convert_damage = FALSE
	die_with_shapeshifted_form = FALSE

	invocation_type = INVOCATION_NONE
	spell_requirements = NONE

	possible_shapes = list(/mob/living/carbon/human)
	sound = 'sound/slashco/slasher/imposter/disguise.ogg'

/datum/action/cooldown/spell/shapeshift/imposter/do_unshapeshift(mob/living/caster)
	. = ..()
	if(!.)
		return
	sound = 'sound/slashco/slasher/imposter/disguise.ogg'

/datum/action/cooldown/spell/shapeshift/imposter/do_shapeshift(mob/living/caster)
	. = ..()
	if(!.)
		return
	caster.Paralyze(3 SECONDS)
	playsound(get_turf(caster), 'sound/slashco/slasher/imposter/amogus.ogg', 75) // This should be delayed by 5 seconds (but I can't get that to work)
	var/mob/living/carbon/human/our_disguise = .
	var/list/traits_to_apply = list(
		TRAIT_PACIFISM,
		TRAIT_CHUNKYFINGERS,
		TRAIT_MUTE,
	)
	for(var/a_trait in traits_to_apply)
		ADD_TRAIT(our_disguise, a_trait, src)
	our_disguise.equipOutfit(/datum/outfit/job/slashco_employee)
	playsound(get_turf(caster), 'sound/slashco/slasher/imposter/amogus.ogg', 75)
	sound = 'sound/slashco/slasher/imposter/undisguise.ogg'
