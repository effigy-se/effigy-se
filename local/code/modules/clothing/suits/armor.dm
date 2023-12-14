/obj/item/clothing/suit/armor/hos
	uses_advanced_reskins = TRUE
	unique_reskin = list(
		"Greatcoat" = list(
			RESKIN_ICON = 'icons/obj/clothing/suits/armor.dmi',
			RESKIN_ICON_STATE = "hos",
			RESKIN_WORN_ICON = 'icons/mob/clothing/suits/armor.dmi',
			RESKIN_WORN_ICON_STATE = "hos"
		),
		"Trenchcoat" = list(
			RESKIN_ICON = 'icons/obj/clothing/suits/armor.dmi',
			RESKIN_ICON_STATE = "hostrench",
			RESKIN_WORN_ICON = 'icons/mob/clothing/suits/armor.dmi',
			RESKIN_WORN_ICON_STATE = "hostrench"
		),
		"Navy Blue Jacket" = list(
			RESKIN_ICON = 'local/icons/obj/clothing/suits.dmi',
			RESKIN_ICON_STATE = "hosbluejacket",
			RESKIN_WORN_ICON = 'local/icons/mob/clothing/suit.dmi',
			RESKIN_WORN_ICON_STATE = "hosbluejacket"
		),
		"Trenchcloak" = list(
			RESKIN_ICON = 'local/icons/obj/clothing/suits.dmi',
			RESKIN_ICON_STATE = "trenchcloak",
			RESKIN_WORN_ICON = 'local/icons/mob/clothing/suit.dmi',
			RESKIN_WORN_ICON_STATE = "trenchcloak"
		),
		"Black" = list(
			RESKIN_ICON = 'local/icons/obj/clothing/suits.dmi',
			RESKIN_ICON_STATE = "hos_black",
			RESKIN_WORN_ICON = 'local/icons/mob/clothing/suit.dmi',
			RESKIN_WORN_ICON_STATE = "hos_black",
			RESKIN_SUPPORTS_VARIATIONS_FLAGS = NONE
		)
	)

// MODULAR ARMOUR

// SECURITY OFFICER

/obj/item/clothing/suit/armor/navyblue
	icon = 'local/icons/obj/clothing/suits.dmi'
	worn_icon = 'local/icons/mob/clothing/suit.dmi'
	name = "security officer's jacket"
	desc = "This jacket is for those special occasions when a security officer isn't required to wear their armor."
	icon_state = "officerbluejacket"
	body_parts_covered = CHEST|ARMS
	supports_variations_flags = CLOTHING_DIGITIGRADE_VARIATION_NO_NEW_ICON

// HEAD OF SECURITY

/obj/item/clothing/suit/armor/hos/navyblue
	icon = 'local/icons/obj/clothing/suits.dmi'
	worn_icon = 'local/icons/mob/clothing/suit.dmi'
	name = "head of security's jacket"
	desc = "This piece of clothing was specifically designed for asserting superior authority."
	icon_state = "hosbluejacket"
	body_parts_covered = CHEST|ARMS
	cold_protection = CHEST|ARMS
	heat_protection = CHEST|ARMS

/obj/item/clothing/suit/armor/hos/trenchcoat/peacekeeper/cloak
	name = "armored trenchcloak"
	desc = "A trenchcoat enchanced with a special lightweight kevlar. This one appears to be designed to be draped over one's shoulders rather than worn normally.."
	icon = 'local/icons/obj/clothing/suits.dmi'
	worn_icon = 'local/icons/mob/clothing/suit.dmi'
	icon_state = "trenchcloak"
	supports_variations_flags = CLOTHING_DIGITIGRADE_VARIATION_NO_NEW_ICON
	body_parts_covered = CHEST|ARMS|LEGS

// WARDEN

/obj/item/clothing/suit/armor/vest/warden/navyblue
	icon = 'local/icons/obj/clothing/suits.dmi'
	worn_icon = 'local/icons/mob/clothing/suit.dmi'
	name = "warden's jacket"
	desc = "Perfectly suited for the warden that wants to leave an impression of style on those who visit the brig."
	icon_state = "wardenbluejacket"
	body_parts_covered = CHEST|ARMS

/obj/item/clothing/suit/armor/vest/warden/syndicate
	icon = 'local/icons/obj/clothing/suits.dmi'
	worn_icon = 'local/icons/mob/clothing/suit.dmi'
	name = "master at arms' vest"
	desc = "Stunning. Menacing. Perfect for the man who gets bullied for leaving the brig."
	icon_state = "warden_syndie"
	supports_variations_flags = CLOTHING_DIGITIGRADE_VARIATION

// HEAD OF PERSONNEL
/obj/item/clothing/suit/toggle/hop_parade
	name = "head of personnel's parade jacket"
	desc = "A luxurious deep blue jacket for the Head of Personnel, woven with a red trim. It smells of bureaucracy."
	icon = 'local/icons/obj/clothing/suits.dmi'
	worn_icon = 'local/icons/mob/clothing/suit.dmi'
	icon_state = "hopformal"
	inhand_icon_state = "coatcaptain"
	body_parts_covered = CHEST|GROIN|ARMS
	cold_protection = CHEST|GROIN|ARMS
	heat_protection = CHEST|GROIN|ARMS

// CAPTAIN
/obj/item/clothing/suit/armor/vest/capcarapace/jacket
	icon = 'local/icons/obj/clothing/suits.dmi'
	worn_icon = 'local/icons/mob/clothing/suit.dmi'
	name = "captain's jacket"
	desc = "A lightweight armored jacket in the Captain's colors. For when you want something sleeker."
	icon_state = "capjacket"
	body_parts_covered = CHEST|ARMS
