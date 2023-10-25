/obj/item/clothing/head/blastwave
	name = "blastwave helmet"
	desc = "A plastic helmet with paint applied. Protects as much as cardboard box named 'Bomb Shelter'."
	icon = 'local/icons/obj/clothing/hats.dmi'
	worn_icon = 'local/icons/mob/clothing/head.dmi'
	icon_state = "blastwave_helmet"
	flags_inv = HIDEHAIR
	uses_advanced_reskins = TRUE
	unique_reskin = list(
		"Default (Purple)" = list(
			RESKIN_ICON = 'local/icons/obj/clothing/hats.dmi',
			RESKIN_ICON_STATE = "blastwave_suit",
			RESKIN_WORN_ICON = 'local/icons/mob/clothing/head.dmi',
			RESKIN_WORN_ICON_STATE = "blastwave_suit"
		),
		"Red" = list(
			RESKIN_ICON = 'local/icons/obj/clothing/hats.dmi',
			RESKIN_ICON_STATE = "blastwave_suit_r",
			RESKIN_WORN_ICON = 'local/icons/mob/clothing/head.dmi',
			RESKIN_WORN_ICON_STATE = "blastwave_suit_r"
		),
		"Green" = list(
			RESKIN_ICON = 'local/icons/obj/clothing/hats.dmi',
			RESKIN_ICON_STATE = "blastwave_suit_g",
			RESKIN_WORN_ICON = 'local/icons/mob/clothing/head.dmi',
			RESKIN_WORN_ICON_STATE = "blastwave_suit_g"
		),
		"Blue" = list(
			RESKIN_ICON = 'local/icons/obj/clothing/hats.dmi',
			RESKIN_ICON_STATE = "blastwave_suit_b",
			RESKIN_WORN_ICON = 'local/icons/mob/clothing/head.dmi',
			RESKIN_WORN_ICON_STATE = "blastwave_suit_b"
		),
		"Yellow" = list(
			RESKIN_ICON = 'local/icons/obj/clothing/hats.dmi',
			RESKIN_ICON_STATE = "blastwave_suit_y",
			RESKIN_WORN_ICON = 'local/icons/mob/clothing/head.dmi',
			RESKIN_WORN_ICON_STATE = "blastwave_suit_y"
		)
	)

/obj/item/clothing/head/blastwave/officer
	name = "blastwave peaked cap"
	desc = "A simple, militaristic cap."
	icon_state = "blastwave_offcap"
	flags_inv = 0
	unique_reskin = list(
		"Default (Purple)" = list(
			RESKIN_ICON = 'local/icons/obj/clothing/hats.dmi',
			RESKIN_ICON_STATE = "blastwave_offcap",
			RESKIN_WORN_ICON = 'local/icons/mob/clothing/head.dmi',
			RESKIN_WORN_ICON_STATE = "blastwave_offcap"
		),
		"Red" = list(
			RESKIN_ICON = 'local/icons/obj/clothing/hats.dmi',
			RESKIN_ICON_STATE = "blastwave_offcap_r",
			RESKIN_WORN_ICON = 'local/icons/mob/clothing/head.dmi',
			RESKIN_WORN_ICON_STATE = "blastwave_offcap_r"
		),
		"Green" = list(
			RESKIN_ICON = 'local/icons/obj/clothing/hats.dmi',
			RESKIN_ICON_STATE = "blastwave_offcap_g",
			RESKIN_WORN_ICON = 'local/icons/mob/clothing/head.dmi',
			RESKIN_WORN_ICON_STATE = "blastwave_offcap_g"
		),
		"Blue" = list(
			RESKIN_ICON = 'local/icons/obj/clothing/hats.dmi',
			RESKIN_ICON_STATE = "blastwave_offcap_b",
			RESKIN_WORN_ICON = 'local/icons/mob/clothing/head.dmi',
			RESKIN_WORN_ICON_STATE = "blastwave_offcap_b"
		),
		"Yellow" = list(
			RESKIN_ICON = 'local/icons/obj/clothing/hats.dmi',
			RESKIN_ICON_STATE = "blastwave_offcap_y",
			RESKIN_WORN_ICON = 'local/icons/mob/clothing/head.dmi',
			RESKIN_WORN_ICON_STATE = "blastwave_offcap_y"
		)
	)

/obj/item/clothing/mask/gas/full
	name = "full gas mask"
	desc = "A close-fitting mask. Equipment beloved by many trenchers, mooks and romantically apocalyptic people."
	icon = 'local/icons/obj/clothing/masks.dmi'
	worn_icon = 'local/icons/mob/clothing/mask.dmi'
	worn_icon_muzzled = 'local/icons/mob/clothing/mask_muzzled.dmi'
	icon_state = "gas_full"
	flags_inv = HIDEEARS | HIDEEYES | HIDEFACE | HIDEHAIR | HIDEFACIALHAIR | HIDESNOUT

/obj/item/clothing/suit/blastwave
	name = "blastwave trenchcoat"
	desc = "A generic trenchcoat of the boring wars."
	icon = 'local/icons/obj/clothing/suits.dmi'
	worn_icon = 'local/icons/mob/clothing/suit.dmi'
	worn_icon_digi = 'local/icons/mob/clothing/suit_digi.dmi'
	icon_state = "blastwave_suit"
	body_parts_covered = CHEST|GROIN|LEGS|ARMS
	uses_advanced_reskins = TRUE
	unique_reskin = list(
		"Default (Purple)" = list(
			RESKIN_ICON = 'local/icons/obj/clothing/suits.dmi',
			RESKIN_ICON_STATE = "blastwave_suit",
			RESKIN_WORN_ICON = 'local/icons/mob/clothing/suit.dmi',
			RESKIN_WORN_ICON_STATE = "blastwave_suit"
		),
		"Red" = list(
			RESKIN_ICON = 'local/icons/obj/clothing/suits.dmi',
			RESKIN_ICON_STATE = "blastwave_suit_r",
			RESKIN_WORN_ICON = 'local/icons/mob/clothing/suit.dmi',
			RESKIN_WORN_ICON_STATE = "blastwave_suit_r"
		),
		"Green" = list(
			RESKIN_ICON = 'local/icons/obj/clothing/suits.dmi',
			RESKIN_ICON_STATE = "blastwave_suit_g",
			RESKIN_WORN_ICON = 'local/icons/mob/clothing/suit.dmi',
			RESKIN_WORN_ICON_STATE = "blastwave_suit_g"
		),
		"Blue" = list(
			RESKIN_ICON = 'local/icons/obj/clothing/suits.dmi',
			RESKIN_ICON_STATE = "blastwave_suit_b",
			RESKIN_WORN_ICON = 'local/icons/mob/clothing/suit.dmi',
			RESKIN_WORN_ICON_STATE = "blastwave_suit_b"
		),
		"Yellow" = list(
			RESKIN_ICON = 'local/icons/obj/clothing/suits.dmi',
			RESKIN_ICON_STATE = "blastwave_suit_y",
			RESKIN_WORN_ICON = 'local/icons/mob/clothing/suit.dmi',
			RESKIN_WORN_ICON_STATE = "blastwave_suit_y"
		)
	)

/obj/item/clothing/under/blastwave
	name = "blastwave uniform"
	desc = "An utilitarian uniform of rugged warfare."
	icon = 'local/icons/obj/clothing/uniforms.dmi'
	worn_icon = 'local/icons/mob/clothing/uniform.dmi'
	worn_icon_digi = 'local/icons/mob/clothing/uniform_digi.dmi'
	icon_state = "blastwave_uniform"
	can_adjust = FALSE
	uses_advanced_reskins = TRUE
	unique_reskin = list(
		"Default (Purple)" = list(
			RESKIN_ICON = 'local/icons/obj/clothing/uniforms.dmi',
			RESKIN_ICON_STATE = "blastwave_uniform",
			RESKIN_WORN_ICON = 'local/icons/mob/clothing/uniform.dmi',
			RESKIN_WORN_ICON_STATE = "blastwave_uniform"
		),
		"Red" = list(
			RESKIN_ICON = 'local/icons/obj/clothing/uniforms.dmi',
			RESKIN_ICON_STATE = "blastwave_uniform_r",
			RESKIN_WORN_ICON = 'local/icons/mob/clothing/uniform.dmi',
			RESKIN_WORN_ICON_STATE = "blastwave_uniform_r"
		),
		"Green" = list(
			RESKIN_ICON = 'local/icons/obj/clothing/uniforms.dmi',
			RESKIN_ICON_STATE = "blastwave_uniform_g",
			RESKIN_WORN_ICON = 'local/icons/mob/clothing/uniform.dmi',
			RESKIN_WORN_ICON_STATE = "blastwave_uniform_g"
		),
		"Blue" = list(
			RESKIN_ICON = 'local/icons/obj/clothing/uniforms.dmi',
			RESKIN_ICON_STATE = "blastwave_uniform_b",
			RESKIN_WORN_ICON = 'local/icons/mob/clothing/uniform.dmi',
			RESKIN_WORN_ICON_STATE = "blastwave_uniform_b"
		),
		"Yellow" = list(
			RESKIN_ICON = 'local/icons/obj/clothing/uniforms.dmi',
			RESKIN_ICON_STATE = "blastwave_uniform_y",
			RESKIN_WORN_ICON = 'local/icons/mob/clothing/uniform.dmi',
			RESKIN_WORN_ICON_STATE = "blastwave_uniform_y"
		)
	)
