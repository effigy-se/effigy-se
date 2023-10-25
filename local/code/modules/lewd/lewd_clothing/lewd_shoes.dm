//heels item
/obj/item/clothing/shoes/latex_heels
	name = "latex heels"
	desc = "Lace up before use. It's pretty difficult to walk in these."
	icon_state = "latexheels"
	inhand_icon_state = null
	// We really need to find a way to condense there.
	icon = 'local/icons/lewd/obj/lewd_clothing/lewd_shoes.dmi'
	worn_icon = 'local/icons/lewd/mob/lewd_clothing/lewd_shoes.dmi'
	worn_icon_digi = 'local/icons/lewd/mob/lewd_clothing/lewd_shoes_digi.dmi'
	worn_icon_taur_hoof = 'local/icons/lewd/obj/lewd_clothing/lewd_shoes.dmi'
	worn_icon_taur_paw = 'local/icons/lewd/obj/lewd_clothing/lewd_shoes.dmi'
	worn_icon_taur_snake = 'local/icons/lewd/obj/lewd_clothing/lewd_shoes.dmi'
	supports_variations_flags = CLOTHING_DIGITIGRADE_VARIATION|STYLE_TAUR_ALL

/obj/item/clothing/shoes/latex_heels/Initialize(mapload)
	. = ..()
	AddComponent(/datum/component/squeak, list('local/sound/effects/lewd/highheel1.ogg' = 1, 'local/sound/effects/lewd/highheel2.ogg' = 1), 70)

/obj/item/clothing/shoes/latex_heels/domina_heels
	name = "dominant heels"
	desc = "A pair of aesthetically pleasing heels."
	icon_state = "dominaheels"

/*
*	LATEX SOCKS
*/

/obj/item/clothing/shoes/latex_socks
	name = "latex socks"
	desc = "A pair of shiny, split-toe socks made of some strange material."
	icon_state = "latexsocks"
	inhand_icon_state = null
	w_class = WEIGHT_CLASS_SMALL
	icon = 'local/icons/lewd/obj/lewd_clothing/lewd_shoes.dmi'
	worn_icon = 'local/icons/lewd/mob/lewd_clothing/lewd_shoes.dmi'
	worn_icon_digi = 'local/icons/lewd/mob/lewd_clothing/lewd_shoes_digi.dmi'
