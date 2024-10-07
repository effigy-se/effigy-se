/mob/living/basic/slasher/borgmire
	name = "Borgmire"
	desc = "The Brute Slasher who can overpower survivors with overwhelming strength."
	icon = 'local/code/modules/slashco13/icons/mob/slasherstall.dmi'
	icon_state = "borgmire"
	melee_damage_lower = 25
	melee_damage_upper = 30
	attack_verb_simple = "punch"
	attack_verb_continuous = "punches"
	attack_sound = 'sound/weapons/resonator_blast.ogg'
	can_jumpscare = FALSE // borgmire prefers to get PERSONAL

/mob/living/basic/slasher/borgmire/Initialize(mapload)
	. = ..()
	add_traits(list(TRAIT_ADVANCEDTOOLUSER, TRAIT_CAN_STRIP), ROUNDSTART_TRAIT)
	AddElement(/datum/element/dextrous)
	AddElement(/datum/element/footstep, FOOTSTEP_BORGMIRE)
	AddComponent(/datum/component/basic_inhands, y_offset = 2)
	AddComponent(/datum/component/personal_crafting) // i'd wheeze if a borgmire made a homemade cannon and got a kill with it honestly. a+ for effort
	var/datum/martial_art/cqc/our_cqc = new
	our_cqc.teach(src) // this is the only way i could think of to translate borgmire's gimmick. honestly? i'm horrified too

/mob/living/basic/slasher/borgmire/melee_attack(atom/target, list/modifiers, ignore_cooldown)
	. = ..()
	if (!. || !isliving(target))
		return
	var/mob/living/send_help = target
	send_help.throw_at(get_edge_target_turf(target, dir), range = rand(1, 2), speed = 7, thrower = src)
