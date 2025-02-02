/obj/item/scrap/gacha_ball
	icon_state = "gacha_ball"
	name = "gacha ball"
	desc = "No refunds."

/// the lack of a custom value range is delibrate; i think it adds to the item's joke

/obj/item/scrap/gacha_ball/attack_self(mob/user, modifiers)
	. = ..()
	moveToNullspace()
	var/obj/item/toy/plush/effigy/chosen_plush = pick(subtypesof(/obj/item/toy/plush/effigy))
	var/obj/item/thing = new chosen_plush(get_turf(user))
	user.visible_message(span_notice("[user] pops open \the [src], finding \a [thing] inside!"))
	user.put_in_hands(thing)
	thing.add_fingerprint(user)

	qdel(src)
