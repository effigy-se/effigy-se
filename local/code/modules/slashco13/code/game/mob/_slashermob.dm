/mob/living/basic/slasher
	maxHealth = INFINITY
	health = INFINITY
	icon = 'local/code/modules/slashco13/icons/mob/slashers.dmi'
	lighting_cutoff_red = 50
	lighting_cutoff_green = 22
	lighting_cutoff_blue = 22
	melee_damage_lower = 0
	melee_damage_upper = 0
	obj_damage = 50 // do you know the motherfucking name of god.
	var/can_jumpscare = TRUE // would you beleive it? there's slashers that attack normally

/mob/living/basic/slasher/Initialize(mapload)
	ADD_TRAIT(src, TRAIT_FREE_HYPERSPACE_MOVEMENT, INNATE_TRAIT) // Prevents cheese with the emergency shuttle. Also is terrifying.
	ADD_TRAIT(src, TRAIT_FREE_FLOAT_MOVEMENT, INNATE_TRAIT) // Prevents cheese with space. Also is terrifying.
	. = ..()
	AddElement(/datum/element/wall_tearer, allow_reinforced = FALSE, tear_time = 8 SECONDS)
	ADD_TRAIT(src, TRAIT_SPACEWALK, INNATE_TRAIT)
	name = initial(name)

/mob/living/basic/slasher/melee_attack(atom/target, list/modifiers, ignore_cooldown)
	. = ..()
	if(isliving(target) && can_jumpscare)
		var/mob/living/our_target = target
		for(var/datum/antagonist/slasher/our_slasher in src.mind.antag_datums)
			if(!COOLDOWN_FINISHED(our_slasher, jumpscare_cooldown))
				balloon_alert(src, "on cooldown!")
				return TRUE
			if(our_target.stat != DEAD)
				our_slasher.jumpscare(our_target, src)
				COOLDOWN_START(our_slasher, jumpscare_cooldown, our_slasher.jumpscare_cooldown_length)
				return TRUE
		return FALSE
	return TRUE
