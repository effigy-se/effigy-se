
/mob/living/proc/HasDisease(datum/disease/D)
	for(var/thing in diseases)
		var/datum/disease/DD = thing
		if(D.IsSame(DD))
			return TRUE
	return FALSE


/mob/living/proc/CanContractDisease(datum/disease/D)
	if(stat == DEAD && !D.process_dead)
		return FALSE

	if(D.GetDiseaseID() in disease_resistances)
		return FALSE

	if(HasDisease(D))
		return FALSE

	if(!(D.infectable_biotypes & mob_biotypes))
		return FALSE

	if(!D.is_viable_mobtype(type))
		return FALSE

	return TRUE


/mob/living/proc/ContactContractDisease(datum/disease/D)
	if(!CanContractDisease(D))
		return FALSE
	D.try_infect(src)


/mob/living/carbon/ContactContractDisease(datum/disease/disease, target_zone)
	if(!CanContractDisease(disease))
		return FALSE

	var/passed = TRUE

	var/head_chance = 80
	var/body_chance = 100
	var/hands_chance = 35/2
	var/feet_chance = 15/2

	var/random_chance = rand(0, 100)
	to_chat(world, span_yellowteamradio("DIS: [disease] Contact spread called on [src.name] with a chance of [clamp(7 + (disease.spreading_modifier * 7), 14, 35)]% at a spread modifier of [disease.spreading_modifier]"))
	if(random_chance > (clamp(7 + (disease.spreading_modifier * 7), 14, 35)))
		to_chat(world, span_redteamradio("DIS: [src.name] [disease] Contact spread init check FAILED on roll [random_chance]"))
		return
	to_chat(world, span_greenteamradio("DIS: [src.name] [disease] Contact spread init check PASSED on roll [random_chance]"))

	if(satiety>0 && prob(satiety/2)) // positive satiety makes it harder to contract the disease.
		return

	if(!target_zone)
		target_zone = pick_weight(list(
			BODY_ZONE_HEAD = head_chance,
			BODY_ZONE_CHEST = body_chance,
			BODY_ZONE_R_ARM = hands_chance,
			BODY_ZONE_L_ARM = hands_chance,
			BODY_ZONE_R_LEG = feet_chance,
			BODY_ZONE_L_LEG = feet_chance,
		))
	else
		target_zone = check_zone(target_zone)

	if(ishuman(src))
		var/mob/living/carbon/human/infecting_human = src

		if(HAS_TRAIT(infecting_human, TRAIT_VIRUS_RESISTANCE) && prob(75))
			return

		switch(target_zone)
			if(BODY_ZONE_HEAD)
				if(isobj(infecting_human.head))
					passed = prob(100-infecting_human.head.get_armor_rating(BIO))
				if(passed && isobj(infecting_human.wear_mask))
					passed = prob(100-infecting_human.wear_mask.get_armor_rating(BIO))
				if(passed && isobj(infecting_human.wear_neck))
					passed = prob(100-infecting_human.wear_neck.get_armor_rating(BIO))
			if(BODY_ZONE_CHEST)
				if(isobj(infecting_human.wear_suit))
					passed = prob(100-infecting_human.wear_suit.get_armor_rating(BIO))
				if(passed && isobj(infecting_human.w_uniform))
					passed = prob(100-infecting_human.w_uniform.get_armor_rating(BIO))
			if(BODY_ZONE_L_ARM, BODY_ZONE_R_ARM)
				if(isobj(infecting_human.wear_suit) && infecting_human.wear_suit.body_parts_covered&HANDS)
					passed = prob(100-infecting_human.wear_suit.get_armor_rating(BIO))
				if(passed && isobj(infecting_human.gloves))
					passed = prob(100-infecting_human.gloves.get_armor_rating(BIO))
			if(BODY_ZONE_L_LEG, BODY_ZONE_R_LEG)
				if(isobj(infecting_human.wear_suit) && infecting_human.wear_suit.body_parts_covered&FEET)
					passed = prob(100-infecting_human.wear_suit.get_armor_rating(BIO))
				if(passed && isobj(infecting_human.shoes))
					passed = prob(100-infecting_human.shoes.get_armor_rating(BIO))

	to_chat(world, span_yellowteamradio("DIS: Contact final spread check is [passed]"))

	if(passed)
		to_chat(world, span_yellowteamradio("DIS: Contact trying infection..."))
		disease.try_infect(src)

/**
 * Handle being contracted a disease via airborne transmission
 *
 * * disease - the disease datum that's infecting us
 */
/mob/living/proc/contract_airborne_disease(datum/disease/disease)
	if(!can_be_spread_airborne_disease())
		return FALSE
	to_chat(world, span_yellowteamradio("DIS: Airborne spread called on [src] with a chance of [clamp(7 + (disease.spreading_modifier * 7), 14, 35)]% at a spread modifier of [disease.spreading_modifier]"))
	var/random_chance = rand(0, 100)
	if(random_chance > (clamp(7 + (disease.spreading_modifier * 7), 14, 35)))
		to_chat(world, span_redteamradio("DIS: [src.name] Airborne spread init check FAILED on roll [random_chance]"))
		return FALSE
	to_chat(world, span_greenteamradio("DIS: [src.name] Airborne spread init check PASSED on roll [random_chance]"))
	if(!disease.has_required_infectious_organ(src, ORGAN_SLOT_LUNGS))
		return FALSE
	return ForceContractDisease(disease)

//Proc to use when you 100% want to try to infect someone (ignoreing protective clothing and such), as long as they aren't immune
/mob/living/proc/ForceContractDisease(datum/disease/D, make_copy = TRUE, del_on_fail = FALSE)
	if(!CanContractDisease(D))
		if(del_on_fail)
			qdel(D)
		return FALSE
	if(!D.try_infect(src, make_copy))
		if(del_on_fail)
			qdel(D)
		return FALSE
	return TRUE


/mob/living/carbon/human/CanContractDisease(datum/disease/disease)
	if(dna)
		if(HAS_TRAIT(src, TRAIT_VIRUSIMMUNE) && !disease.bypasses_immunity)
			return FALSE
	if(disease.required_organ)
		if(!disease.has_required_infectious_organ(src, disease.required_organ))
			return FALSE

	return ..()

/// Checks if this mob can currently spread air based diseases.
/// Nondeterministic
/mob/living/proc/can_spread_airborne_diseases()
	SHOULD_CALL_PARENT(TRUE)
	if(HAS_TRAIT(src, TRAIT_NOBREATH))
		return FALSE
	if(losebreath >= 1)
		return FALSE
	// I don't know how you are spreading via air with no head but sure
	if(!get_bodypart(BODY_ZONE_HEAD))
		return TRUE
	// Check both hat and mask for bio protection
	// Anything above 50 individually is a shoe-in, and stacking two items at 25 is also a shoe-in
	var/obj/item/clothing/hat = is_mouth_covered(ITEM_SLOT_HEAD)
	var/obj/item/clothing/mask = is_mouth_covered(ITEM_SLOT_MASK)
	var/total_prot = 2 * (hat?.get_armor_rating(BIO) + mask?.get_armor_rating(BIO))
	if(prob(total_prot))
		return FALSE

	return TRUE

/mob/living/carbon/can_spread_airborne_diseases()
	if(internal || external)
		return FALSE

	return ..()

/// Checks if this mob can currently be infected by air based diseases
/// Nondeterministic
/mob/living/proc/can_be_spread_airborne_disease()
	if(HAS_TRAIT(src, TRAIT_NOBREATH))
		return FALSE
	if(losebreath >= 1)
		return FALSE
	// Spaceacillin for infection resistance
	if(HAS_TRAIT(src, TRAIT_VIRUS_RESISTANCE) && prob(75))
		return FALSE
	// Bio check for head AND mask
	// Meaning if we're masked up and wearing a dome, we are very likely never getting sick
	var/obj/item/clothing/hat = is_mouth_covered(ITEM_SLOT_HEAD)
	var/obj/item/clothing/mask = is_mouth_covered(ITEM_SLOT_MASK)
	var/total_prot = 0 + ((hat?.get_armor_rating(BIO) * 0.75) + mask?.get_armor_rating(BIO))
	if(mask)
		total_prot += 20
	to_chat(world, span_blueteamradio("DIS: [src.name] bio protection is [total_prot]. (hat [hat?.get_armor_rating(BIO)]) (mask [mask?.get_armor_rating(BIO)])"))
	if(prob(total_prot))
		to_chat(world, span_redteamradio("DIS: [src.name] bio protection check SAFE ([total_prot]% chance)"))
		return FALSE

	to_chat(world, span_greenteamradio("DIS: [src.name] bio protection check UNSAFE ([total_prot]% chance)"))
	return TRUE

/mob/living/carbon/can_be_spread_airborne_disease()
	// Using an isolated air supply is also effective
	if((internal || external) && prob(75))
		return FALSE

	return ..()
