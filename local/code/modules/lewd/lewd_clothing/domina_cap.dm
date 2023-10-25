/obj/item/clothing/head/domina_cap
	name = "dominant cap"
	desc = "For special types of inspections."
	icon_state = "dominacap"
	icon = 'local/icons/lewd/obj/lewd_clothing/lewd_hats.dmi'
	worn_icon = 'local/icons/lewd/mob/lewd_clothing/lewd_hats.dmi'
	supports_variations_flags = NONE

//message when equipping that thing
/obj/item/clothing/head/domina_cap/equipped(mob/living/carbon/user, slot)
	. = ..()
	if(src == user.head)
		to_chat(user, span_purple("You feel much more determined."))

//message when unequipping that thing
/obj/item/clothing/head/domina_cap/dropped(mob/living/carbon/user)
	. = ..()
	if(src == user.head)
		to_chat(user, span_purple("BDSM session ended, huh?"))
