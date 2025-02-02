/obj/item/scrap/toilet_paper
	icon_state = "toilet_paper"
	name = "toilet paper"
	desc = "Straight from the office! This is worthless."
	var/remaining_uses = 3

/obj/item/scrap/toilet_paper/randomize_credit_cost()
	return rand(60, 80)


/obj/item/scrap/toilet_paper/Initialize(mapload)
	. = ..()
	AddComponent(/datum/component/cleaner, 3 SECONDS, pre_clean_callback=CALLBACK(src, PROC_REF(should_clean)), on_cleaned_callback =CALLBACK(src, PROC_REF(post_clean)))

/obj/item/scrap/toilet_paper/proc/should_clean(datum/cleaning_source, atom/atom_to_clean, mob/living/cleaner)
	if(cleaner.combat_mode && ismob(atom_to_clean))
		return CLEAN_BLOCKED|CLEAN_DONT_BLOCK_INTERACTION
	if(loc == cleaner)
		return CLEAN_ALLOWED
	return CLEAN_BLOCKED|CLEAN_DONT_BLOCK_INTERACTION

/obj/item/scrap/toilet_paper/proc/post_clean(datum/source, atom/target, mob/living/user, clean_succeeded)
	if(!clean_succeeded)
		return
	if(remaining_uses <= 0)
		balloon_alert(user, "out of uses!")
		qdel(src)
