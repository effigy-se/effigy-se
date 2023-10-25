// Makes the next item purchased from the LustWish vendor free.

/obj/item/lustwish_discount
	name = "LustWish elite card"
	desc = "A strange card with a blue lamia on the back." //yes, this is card with my character on the back. Cameo.
	icon_state = "lustwish_discount"
	inhand_icon_state = null
	icon = 'local/icons/lewd/obj/lewd_items/lewd_items.dmi'
	w_class = WEIGHT_CLASS_TINY

//code for showing that we have something IlLeGaL
/obj/item/lustwish_discount/attack_self(mob/user, modifiers)
	. = ..()
	to_chat(loc, span_notice("[user] shows a lustwish elite card!"))
