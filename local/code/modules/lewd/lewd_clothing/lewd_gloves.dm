//normal ball mittens
/obj/item/clothing/gloves/ball_mittens
	name = "ball mittens"
	desc = "A nice, comfortable pair of inflatable ball gloves."
	icon_state = "ballmittens"
	inhand_icon_state = null
	icon = 'local/icons/lewd/obj/lewd_clothing/lewd_gloves.dmi'
	worn_icon = 'local/icons/lewd/mob/lewd_clothing/lewd_gloves.dmi'
	breakouttime = 1 SECONDS
	resist_cooldown = CLICK_CD_SLOW

//That part allows reinforcing this item with handcuffs
/obj/item/clothing/gloves/ball_mittens/attackby(obj/item/attacking_item, mob/user, params)
	. = ..()
	if(.)
		return
	if(!istype(attacking_item, /obj/item/restraints/handcuffs) || !initial(breakouttime))
		return
	to_chat(user, span_notice("You reinforced the belts on [src] with [attacking_item]."))
	name = "reinforced [initial(name)]"
	clothing_flags = DANGEROUS_OBJECT
	breakouttime = 100 SECONDS //do not touch this, i beg you.
	qdel(attacking_item)
	return TRUE

/obj/item/clothing/gloves/ball_mittens/examine(mob/user)
	. = ..()
	if(breakouttime == initial(breakouttime))
		. += span_notice("You could probably reinforce it with a pair of [span_bold("handcuffs")]...")

/// Paw mittens; which vary only in looks from ball mittens
/obj/item/clothing/gloves/ball_mittens/paw_mittens
	name = "paw mittens"
	desc = "Mittens that compress the hand into a tight space, and restrict fine motor control."
	icon_state = "pawmittens"

//latex gloves
/obj/item/clothing/gloves/latex_gloves
	name = "latex gloves"
	desc = "Awesome looking gloves that are satisfying to the touch."
	icon_state = "latexgloves"
	inhand_icon_state = "latex_gloves"
	w_class = WEIGHT_CLASS_SMALL
	icon = 'local/icons/lewd/obj/lewd_clothing/lewd_gloves.dmi'
	worn_icon = 'local/icons/lewd/mob/lewd_clothing/lewd_gloves.dmi'
