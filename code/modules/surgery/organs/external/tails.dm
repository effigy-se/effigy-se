///Tail parent, it doesn't do very much.
/obj/item/organ/external/tail
	name = "tail"
	desc = "A severed tail. What did you cut this off of?"
	icon_state = "severedtail"

	zone = BODY_ZONE_PRECISE_GROIN
	slot = ORGAN_SLOT_EXTERNAL_TAIL

	//dna_block = DNA_TAIL_BLOCK // EffigyEdit Remove - Customization - We have our own system to handle DNA.
	restyle_flags = EXTERNAL_RESTYLE_FLESH

	// defaults to cat, but the parent type shouldn't be created regardless
	bodypart_overlay = /datum/bodypart_overlay/mutant/tail/cat

	///Does this tail have a wagging sprite, and is it currently wagging?
	var/wag_flags = NONE
	///The original owner of this tail
	var/original_owner //Yay, snowflake code!

/obj/item/organ/external/tail/Insert(mob/living/carbon/receiver, special, movement_flags)
	. = ..()
	if(.)
		original_owner ||= WEAKREF(receiver)

		receiver.clear_mood_event("tail_lost")
		receiver.clear_mood_event("tail_balance_lost")

		if(IS_WEAKREF_OF(receiver, original_owner))
			receiver.clear_mood_event("wrong_tail_regained")
		else if(type in receiver.dna.species.external_organs)
			receiver.add_mood_event("wrong_tail_regained", /datum/mood_event/tail_regained_wrong)

/obj/item/organ/external/tail/on_mob_remove(mob/living/carbon/organ_owner, special)
	. = ..()

	if(wag_flags & WAG_WAGGING)
		stop_wag(organ_owner)

	if(type in organ_owner.dna.species.external_organs)
		organ_owner.add_mood_event("tail_lost", /datum/mood_event/tail_lost)
		organ_owner.add_mood_event("tail_balance_lost", /datum/mood_event/tail_balance_lost)

///We need some special behaviour for accessories, wrapped here so we can easily add more interactions later
///Accepts an optional timeout after which we remove the tail wagging
///Returns false if the wag worked, true otherwise
/obj/item/organ/external/tail/proc/start_wag(mob/living/carbon/organ_owner, stop_after = INFINITY)
	if(wag_flags & WAG_WAGGING || !(wag_flags & WAG_ABLE)) // we are already wagging
		return FALSE
	if(organ_owner.stat == DEAD || organ_owner != owner) // no wagging when owner is dead or tail has been disembodied
		return FALSE

	if(stop_after != INFINITY)
		addtimer(CALLBACK(src, PROC_REF(stop_wag), organ_owner), stop_after, TIMER_STOPPABLE|TIMER_DELETE_ME)

	var/datum/bodypart_overlay/mutant/tail/accessory = bodypart_overlay
	wag_flags |= WAG_WAGGING
	accessory.wagging = TRUE
	organ_owner.update_body_parts()
	RegisterSignal(organ_owner, COMSIG_LIVING_DEATH, PROC_REF(owner_died))
	return TRUE

/obj/item/organ/external/tail/proc/owner_died(mob/living/carbon/organ_owner) // Resisting the urge to replace owner with daddy
	SIGNAL_HANDLER
	stop_wag(organ_owner)

///We need some special behaviour for accessories, wrapped here so we can easily add more interactions later
///Returns false if the wag stopping worked, true otherwise
/obj/item/organ/external/tail/proc/stop_wag(mob/living/carbon/organ_owner)
	if(!(wag_flags & WAG_ABLE))
		return FALSE

	var/succeeded = FALSE
	if(wag_flags & WAG_WAGGING)
		wag_flags &= ~WAG_WAGGING
		succeeded = TRUE

	var/datum/bodypart_overlay/mutant/tail/tail_overlay = bodypart_overlay
	tail_overlay.wagging = FALSE
	// EffigyEdit TODO: https://github.com/effigy-se/effigy-se/issues/638
	//if(tail_spines_overlay) //if there are spines, they should stop wagging with the tail
	//	tail_spines_overlay.wagging = FALSE
	if(isnull(organ_owner))
		return succeeded

	organ_owner.update_body_parts()
	UnregisterSignal(organ_owner, COMSIG_LIVING_DEATH)
	return succeeded

/obj/item/organ/external/tail/proc/get_butt_sprite()
	return null

///Tail parent type, with wagging functionality
/datum/bodypart_overlay/mutant/tail
	layers = EXTERNAL_FRONT|EXTERNAL_BEHIND
	feature_key = "tail" // EffigyEdit Change Customization ORIGINAL: feature_key = "tail_monkey"
	var/wagging = FALSE

/datum/bodypart_overlay/mutant/tail/get_base_icon_state()
	return (wagging ? "wagging_" : "") + sprite_datum.icon_state //add the wagging tag if we be wagging

// EffigyEdit Add - Customization
/datum/bodypart_overlay/mutant/tail/get_global_feature_list()
	return GLOB.sprite_accessories["tail"] // EffigyEdit Change - Customization - Original: return GLOB.tails_list

/datum/bodypart_overlay/mutant/tail/can_draw_on_bodypart(mob/living/carbon/human/human)
	if(human.wear_suit && (human.wear_suit.flags_inv & HIDEJUMPSUIT))
		return FALSE
	return TRUE

/obj/item/organ/external/tail/cat
	name = "tail"
	preference = "feature_human_tail"

	bodypart_overlay = /datum/bodypart_overlay/mutant/tail/cat

	wag_flags = WAG_ABLE

/obj/item/organ/external/tail/cat/get_butt_sprite()
	return BUTT_SPRITE_CAT

///Cat tail bodypart overlay
/datum/bodypart_overlay/mutant/tail/cat
	feature_key = "tail" // EffigyEdit Change Customization ORIGINAL: feature_key = "tail_cat"
	// color_source = ORGAN_COLOR_HAIR // EffigyEdit Remove Customization

/datum/bodypart_overlay/mutant/tail/cat/get_global_feature_list()
	return GLOB.sprite_accessories["tail"] // EffigyEdit Change Customization ORIGINAL: return GLOB.tails_list_human

/obj/item/organ/external/tail/monkey
	bodypart_overlay = /datum/bodypart_overlay/mutant/tail/monkey

///Monkey tail bodypart overlay
/datum/bodypart_overlay/mutant/tail/monkey
	color_source = NONE
	feature_key = "tail" // EffigyEdit Change - Customization - Original: feature_key = "tail_monkey"

/datum/bodypart_overlay/mutant/tail/monkey/get_global_feature_list()
	return GLOB.sprite_accessories["tail"] // EffigyEdit Change - Customization - Original: return GLOB.tails_list_monkey

/obj/item/organ/external/tail/lizard
	name = "lizard tail"
	desc = "A severed lizard tail. Somewhere, no doubt, a lizard hater is very pleased with themselves."
	preference = "feature_lizard_tail"

	bodypart_overlay = /datum/bodypart_overlay/mutant/tail/lizard

	wag_flags = WAG_ABLE
	///A reference to the paired_spines, since for some fucking reason tail spines are tied to the spines themselves.
	var/obj/item/organ/external/spines/paired_spines

/obj/item/organ/external/tail/lizard/Insert(mob/living/carbon/receiver, special, movement_flags)
	. = ..()
	if(.)
		paired_spines = bodypart_owner.owner.get_organ_slot(ORGAN_SLOT_EXTERNAL_SPINES)
		paired_spines?.paired_tail = src

/obj/item/organ/external/tail/lizard/Remove(mob/living/carbon/organ_owner, special, movement_flags)
	. = ..()
	if(paired_spines)
		paired_spines.paired_tail = null
		paired_spines = null

/obj/item/organ/external/tail/lizard/start_wag()
	if(paired_spines)
		var/datum/bodypart_overlay/mutant/spines/accessory = paired_spines.bodypart_overlay
		accessory.wagging = TRUE
	return ..()

/obj/item/organ/external/tail/lizard/stop_wag()
	if(paired_spines)
		var/datum/bodypart_overlay/mutant/spines/accessory = paired_spines.bodypart_overlay
		accessory.wagging = FALSE
	return ..()

///Lizard tail bodypart overlay datum
/datum/bodypart_overlay/mutant/tail/lizard
	feature_key = "tail" // EffigyEdit Change - Customization - ORIGINAL: feature_key = "tail_lizard"

/datum/bodypart_overlay/mutant/tail/lizard/get_global_feature_list()
	return GLOB.sprite_accessories["tail"] // EffigyEdit Change Customization ORIGINAL: return GLOB.tails_list_lizard

/obj/item/organ/external/tail/lizard/fake
	name = "fabricated lizard tail"
	desc = "A fabricated severed lizard tail. This one's made of synthflesh. Probably not usable for lizard wine."
