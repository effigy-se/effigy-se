/// State check for grab maneuver - because you can't logically suplex a man if you've stopped grappling them.
/datum/species/proc/grab_maneuver_state_check(mob/living/carbon/human/user, mob/living/carbon/human/target)
	return (target.pulledby && target.pulledby == user && user.grab_state > GRAB_PASSIVE)

/// Tries a grab maneuver - suplex, limb dislocation, or headslam depending on targeted limb.
/datum/species/proc/try_grab_maneuver(mob/living/carbon/human/user, mob/living/carbon/human/target)
	if(!grab_maneuver_state_check(user, target))
		return FALSE
	// psst, future coder - if you're adding more precise interactions, e.g. eye gouging/strangling, you're gonna need to make this less precise!
	// just remove the deprecise_zone() call. account for the specifics after!
	var/obj/item/bodypart/affecting = target.get_bodypart(deprecise_zone(user.zone_selected))
	if(!affecting)
		return FALSE
	. = FALSE
	if(HAS_TRAIT(user, TRAIT_PACIFISM)) //They're all violent acts. Even the suplex, which doesn't apply brute. (Yet. Maybe.)
		return
	switch(deprecise_zone(user.zone_selected))
		if(BODY_ZONE_HEAD)
			if(!(target.body_position == LYING_DOWN))
				target.balloon_alert(user, "not floored!")
				return FALSE
			. = TRUE
			try_headslam(user, target, affecting)
		if(BODY_ZONE_CHEST)
			if(istype(user.mind.martial_art, /datum/martial_art/cqc))
			// If you know CQC, You can't suplex and instead have the ability to use the chokehold, Sorry.
			// Sleeping people on demand is stronger anyway.
				return FALSE
			// Suplex!
			. = TRUE
			try_suplex(user, target)
		else // Assuming we're going for a limb...
			var/datum/wound/blunt/blute_wound = affecting.get_wound_type(/datum/wound/blunt)
			if(blute_wound && blute_wound.severity >= WOUND_SEVERITY_MODERATE)
				blute_wound.try_handling(user) // handle it like any other dislocation (if you're still in combat mode, you will attempt to make it worse)
				return TRUE
			// Dislocate!
			. = TRUE
			try_dislocate(user, target, affecting)

	if(.)
		user.changeNext_move(CLICK_CD_MELEE)
	return

/// Attempts to perform a suplex after SUPLEX_TIMER, causing both to be stunned. (Why spacemen are able to do such a thing on reflex, nobody knows.)
/datum/species/proc/try_suplex(mob/living/carbon/human/user, mob/living/carbon/human/target)
	target.visible_message(span_danger("[user.name] holds [target.name] tight and starts lifting [target.p_them()] up!"), \
			span_userdanger("[user.name] holds you tight and lifts you up!"), ignored_mobs=user)
	to_chat(user, span_danger("You hold [target.name] tight and lift [target.p_them()] up..."))
	user.changeNext_move(SUPLEX_TIMER)
	if(!do_after(user, SUPLEX_TIMER, target) || !grab_maneuver_state_check(user, target))
		return FALSE
	var/move_dir = get_dir(target, user)
	var/turf/moved_turf = get_turf(target)
	for(var/i in 1 to 2)
		var/turf/next_turf = get_step(moved_turf, move_dir)
		if(IS_OPAQUE_TURF(next_turf))
			break
		moved_turf = next_turf
	target.visible_message(span_danger("[user.name] suplexes [target.name] down to the ground!"), \
		span_userdanger("[user.name] suplexes you!"), ignored_mobs=user)
	to_chat(user, span_danger("You suplex [target.name]!"))
	user.StaminaKnockdown(30, TRUE, TRUE)
	user.SpinAnimation(7,1)
	target.SpinAnimation(7,1)
	target.throw_at(moved_turf, 1, 1)
	target.StaminaKnockdown(80)
	target.Paralyze(2 SECONDS)
	// feels like there should be some funny brute here but iunno
	log_combat(user, target, "suplexes", "down on the ground (knocking down both)")

/// Attempts to perform a headslam, with the user slamming target's head into the floor. (Does not account for the potential nonexistence of aforementioned floor, e.g. space.)
/datum/species/proc/try_headslam(mob/living/carbon/human/user, mob/living/carbon/human/target, obj/item/bodypart/affecting)
	var/time_doing = 4 SECONDS
	if(target.stat != CONSCIOUS)
		time_doing = 2 SECONDS
		target.visible_message(span_danger("[user] holds [target]'s head tightly..."), ignored_mobs = user)
		to_chat(user, span_danger("You grasp [target]'s head to prepare to slam it down..."))
	else
		target.visible_message(span_danger("[user] holds [target]'s head and tries to overpower [target.p_them()]!"), \
			span_userdanger("You struggle as [user] holds your head and tries to overpower you!"), ignored_mobs = user)
		to_chat(user, span_danger("You grasp [target]'s head and try to overpower [target.p_them()]..."))
	user.changeNext_move(time_doing)
	if(!do_after(user, time_doing, target) || !grab_maneuver_state_check(user, target))
		return
	var/armor_block = target.run_armor_check(affecting, MELEE)
	var/head_knock = FALSE
	// Check to see if our head is protected by at least HEADSMASH_BLOCK_ARMOR (20 melee armor)
	if(armor_block < HEADSMASH_BLOCK_ARMOR)
		head_knock = TRUE

	target.visible_message(span_danger("[user.name] violently slams [target.name]'s head into the floor!"), \
		span_userdanger("[user.name] slams your head against the floor!"), ignored_mobs = user)
	to_chat(user, span_danger("You slam [target.name]'s head against the floor!"))

	// wound bonus because if you're doing this you probably really don't like the other guy so you're looking forward to inconveniencing them (with a fracture)
	var/fun_times_at_the_headbash_factory = (head_knock ? 8 : 3)
	if(head_knock)
		target.adjustOrganLoss(ORGAN_SLOT_BRAIN, 15)
	target.apply_damage(15, BRUTE, affecting, armor_block, wound_bonus = fun_times_at_the_headbash_factory, bare_wound_bonus = fun_times_at_the_headbash_factory)
	playsound(target, 'sound/effects/hit_kick.ogg', 70)
	log_combat(user, target, "headsmashes", "against the floor")

/// Attempts to perform a limb dislocation, with the user violently twisting one of target's limbs (as passed in). Only useful for extremities, because only extremities can eat dislocations.
/datum/species/proc/try_dislocate(mob/living/carbon/human/user, mob/living/carbon/human/target, obj/item/bodypart/affecting)
	user.changeNext_move(4 SECONDS)
	target.visible_message(span_danger("[user.name] twists [target.name]'s [affecting.name] violently!"), \
			span_userdanger("[user.name] twists your [affecting.name] violently!"), ignored_mobs=user)
	to_chat(user, span_danger("You start twisting [target.name]'s [affecting.name] violently!"))
	if(!do_after(user, 4 SECONDS, target) || !grab_maneuver_state_check(user, target))
		return FALSE
	target.visible_message(span_danger("[user.name] dislocates [target.name]'s [affecting.name]!"), \
		span_userdanger("[user.name] dislocates your [affecting.name]!"), ignored_mobs=user)
	to_chat(user, span_danger("You dislocate [target.name]'s [affecting.name]!"))
	affecting.force_wound_upwards(/datum/wound/blunt/bone/moderate)
	log_combat(user, target, "dislocates", "the [affecting.name]")
	return TRUE
