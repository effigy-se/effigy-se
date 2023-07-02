// Hairbrushes

/obj/item/hairbrush
	name = "hairbrush"
	desc = "A small, circular brush with an ergonomic grip for efficient brush application."
	icon = 'local/icons//obj/hairbrush.dmi'
	icon_state = "brush"
	lefthand_file = 'local/icons//mob/inhands/hairbrush_left.dmi'
	righthand_file = 'local/icons//mob/inhands/hairbrush_right.dmi'
	w_class = WEIGHT_CLASS_TINY
	var/brush_speed = 3 SECONDS

/obj/item/hairbrush/attack(mob/target, mob/user)
	if(target.stat == DEAD)
		to_chat(usr, span_warning("There isn't much point brushing someone who can't appreciate it!"))
		return
	brush(target, user)
	return COMPONENT_CANCEL_ATTACK_CHAIN

/// Brushes someone, giving them a small mood boost
/obj/item/hairbrush/proc/brush(mob/living/target, mob/user)
	if(ishuman(target))
		var/mob/living/carbon/human/human_target = target
		var/obj/item/bodypart/head = human_target.get_bodypart(BODY_ZONE_HEAD)

		// Don't brush if you can't reach their head or cancel the action
		if(!head)
			to_chat(user, span_warning("[human_target] has no head!"))
			return
		if(human_target.is_mouth_covered(ITEM_SLOT_HEAD))
			to_chat(user, span_warning("You can't brush [human_target]'s hair while [human_target.p_their()] head is covered!"))
			return
		if(!do_after(user, brush_speed, human_target))
			return

		// Do 1 brute to their head if they're bald. Should've been more careful.
		if(human_target.hairstyle == "Bald" || human_target.hairstyle == "Skinhead" && is_species(human_target, /datum/species/human)) //It can be assumed most anthros have hair on them!
			human_target.visible_message(span_warning("[usr] scrapes the bristles uncomfortably over [human_target]'s scalp."), span_warning("You scrape the bristles uncomfortably over [human_target]'s scalp."))
			head.receive_damage(1)
			return

		// Brush their hair
		if(human_target == user)
			human_target.visible_message(span_notice("[usr] brushes [usr.p_their()] hair!"), span_notice("You brush your hair."))
			human_target.add_mood_event("brushed", /datum/mood_event/brushed/self)
		else
			user.visible_message(span_notice("[usr] brushes [human_target]'s hair!"), span_notice("You brush [human_target]'s hair."), ignored_mobs=list(human_target))
			human_target.show_message(span_notice("[usr] brushes your hair!"), MSG_VISUAL)
			human_target.add_mood_event("brushed", /datum/mood_event/brushed, user)

	else if(istype(target, /mob/living/simple_animal/pet))
		if(!do_after(usr, brush_speed, target))
			return
		to_chat(user, span_notice("[target] closes [target.p_their()] eyes as you brush [target.p_them()]!"))
		var/mob/living/living_user = user
		if(istype(living_user))
			living_user.add_mood_event("brushed", /datum/mood_event/brushed/pet, target)

/datum/mood_event/brushed
	description = span_nicegreen("Someone brushed my hair recently, that felt great!\n")
	mood_change = 4
	timeout = 4 MINUTES

/datum/mood_event/brushed/add_effects(mob/brusher)
	description = span_nicegreen("[brusher? brusher.name : "I"] brushed my hair recently, that felt great!\n")

/datum/mood_event/brushed/self
	description = span_nicegreen("I brushed my hair recently!\n")
	mood_change = 2		// You can't hit all the right spots yourself, or something

/datum/mood_event/brushed/pet/add_effects(mob/brushed_pet)
	description = span_nicegreen("I brushed [brushed_pet] recently, they're so cute!\n")
