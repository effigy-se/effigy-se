/datum/antagonist/slasher/imposter
	name = "\improper Imposter"
	slasher_outfit = /datum/outfit/job/power_recovery/imposter
	start_with_chase = FALSE
	ui_name = "AntagInfoImposter"
	fluff = "You're the one amongst them."
	jumpscare_volume = 50
	var/datum/action/cooldown/spell/shapeshift/imposter/shapeshift_human
	var/datum/action/cooldown/fuel_disguise/fuel_shapeshift
	var/datum/action/cooldown/mob_cooldown/jumpscare/disguised_jumpscare

/datum/antagonist/slasher/imposter/setup_chase_music()
	our_chase_music.volume = 50 // I don't want this to be default; even if the rest of the chase music vars inherit from amogus

/datum/antagonist/slasher/imposter/give_slasher_abilities()
	. = ..()
	shapeshift_human = new
	shapeshift_human.Grant(owner.current)
	fuel_shapeshift = new
	fuel_shapeshift.Grant(owner.current)

/datum/antagonist/slasher/imposter/slasher_specific_jumpscare_effects(image/jumpscare, mob/living/target, mob/living/user)
	animate(jumpscare, jumpscare_time, color = COLOR_RED)
	return

/// Outfit ///
/datum/outfit/job/power_recovery/imposter
	name = "Power Recovery Technician (Imposter)"

/datum/outfit/job/power_recovery/imposter/post_equip(mob/living/carbon/human/equipped, visualsOnly)
	. = ..()
	var/list/traits_to_apply = list(
		TRAIT_PACIFISM,
		TRAIT_CHUNKYFINGERS,
		TRAIT_NODEATH,
		TRAIT_NOSOFTCRIT,
		TRAIT_NOHARDCRIT,
		TRAIT_NOLIMBDISABLE,
		TRAIT_NEVER_WOUNDED,
		TRAIT_NODISMEMBER,
	)
	for(var/a_trait in traits_to_apply)
		ADD_TRAIT(equipped, a_trait, src)
	equipped.apply_status_effect(/datum/status_effect/speech/imposter, INFINITY)
	equipped.blooper = null // prevents overlap with the imposter's custom speech sfx
	equipped.blooper_list = null
	equipped.blooper_id = null
	for(var/datum/antagonist/slasher/imposter/our_slasher in equipped?.mind?.antag_datums)
		our_slasher.disguised_jumpscare = new
		our_slasher.disguised_jumpscare.Grant(equipped)

/// Imposter Spells ///
/datum/action/cooldown/spell/shapeshift/imposter
	name = "Break Disguise"
	desc = "Break your hapless human-adjacent disguise and assume your true form - or vice versa."
	background_icon = 'local/icons/mob/actions/backgrounds.dmi'
	background_icon_state = "bg_slasher"
	button_icon = 'local/icons/mob/actions/actions_slashers.dmi'
	button_icon_state = "disguise"
	overlay_icon = 'local/icons/mob/actions/backgrounds.dmi'
	overlay_icon_state = "bg_slasher_border"
	cooldown_time = 5 SECONDS
	convert_damage = FALSE
	die_with_shapeshifted_form = FALSE

	spell_requirements = NONE

	possible_shapes = list(/mob/living/basic/slasher/imposter)
	sound = 'local/code/modules/slashco13/sound/slasher/imposter/undisguise.ogg'

/// turn into human
/datum/action/cooldown/spell/shapeshift/imposter/do_unshapeshift(mob/living/caster)
	. = ..()
	sound = 'local/code/modules/slashco13/sound/slasher/imposter/undisguise.ogg'
	playsound(get_turf(caster), 'local/code/modules/slashco13/sound/slasher/imposter/amogus.ogg', 75) // This should be delayed by 5 seconds (but I can't get that to work)
	for(var/datum/antagonist/slasher/imposter/our_slasher in owner?.mind?.antag_datums)
		our_slasher.disguised_jumpscare = new
		our_slasher.disguised_jumpscare.Grant(owner)
		our_slasher.jumpscare_sound = 'local/code/modules/slashco13/sound/slasher/imposter/stealthkill.ogg'
		our_slasher.fuel_shapeshift.Grant(owner)
		our_slasher.carpspawn_spell.Grant(owner)
		our_slasher.knock_spell.Grant(owner)
		our_slasher.our_chase_attack.Remove(owner)
	caster.apply_status_effect(/datum/status_effect/speech/imposter, INFINITY)
	caster.Paralyze(3 SECONDS, TRUE)

/// turn into basic mob
/datum/action/cooldown/spell/shapeshift/imposter/do_shapeshift(mob/living/caster)
	. = ..()
	if(!.)
		return
	if(!isliving(owner))
		return
	var/mob/living/our_caster = owner // caster does NOT equal the shapeshifted mob. fuckery
	our_caster.Paralyze(3 SECONDS, TRUE)
	sound = 'local/code/modules/slashco13/sound/slasher/imposter/disguise.ogg'
	for(var/datum/antagonist/slasher/imposter/our_slasher in owner?.mind?.antag_datums)
		QDEL_NULL(our_slasher.disguised_jumpscare)
		our_slasher.jumpscare_sound = 'local/code/modules/slashco13/sound/slasher/imposter/kill.ogg'
		our_slasher.fuel_shapeshift.Grant(our_caster)
		our_slasher.carpspawn_spell.Grant(our_caster)
		our_slasher.knock_spell.Grant(our_caster)
		our_slasher.our_chase_attack.Grant(our_caster)
	our_caster.apply_status_effect(/datum/status_effect/speech/imposter, INFINITY)

/datum/action/cooldown/fuel_disguise
	name = "Fuel Disguise"
	desc = "Assume the form of the precious generator fuel."
	background_icon = 'local/icons/mob/actions/backgrounds.dmi'
	background_icon_state = "bg_slasher"
	button_icon = 'local/icons/mob/actions/actions_slashers.dmi'
	button_icon_state = "fuel_disguise"
	overlay_icon = 'local/icons/mob/actions/backgrounds.dmi'
	overlay_icon_state = "bg_slasher_border"
	cooldown_time = 5 SECONDS
	var/obj/item/chameleon/imposter/internal_projector

/datum/action/cooldown/fuel_disguise/Grant(mapload)
	. = ..()
	internal_projector = new
	internal_projector.forceMove(owner)

/datum/action/cooldown/fuel_disguise/Remove(mapload)
	. = ..()
	qdel(internal_projector)

/datum/action/cooldown/fuel_disguise/Activate(atom/target_atom)
	. = ..()
	internal_projector.attack_self(owner)
	if(internal_projector.active_dummy)
		SET_PLANE(internal_projector.active_dummy, GAME_PLANE, owner)

/obj/item/chameleon/imposter/Initialize(mapload)
	. = ..()
	var/obj/item/stack/fuel/fuel = /obj/item/stack/fuel
	saved_appearance = initial(fuel.appearance)
