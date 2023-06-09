/obj/item/clothing/head/hats/flakhelm	//Actually the M1 Helmet
	icon = 'packages/clothing/assets/obj/hats.dmi'
	worn_icon = 'packages/clothing/assets/mob/head.dmi'
	name = "flak helmet"
	icon_state = "m1helm"
	inhand_icon_state = "helmet"
	armor_type = /datum/armor/hats_flakhelm
	desc = "A dilapidated helmet used in ancient wars. This one is brittle and essentially useless. An ace of spades is tucked into the band around the outer shell."
	supports_variations_flags = CLOTHING_SNOUTED_VARIATION_NO_NEW_ICON

/datum/armor/hats_flakhelm
	bomb = 0.1
	fire = -10
	acid = -15
	wound = 1

/obj/item/clothing/head/hats/flakhelm/Initialize(mapload)
	. = ..()

	create_storage(storage_type = /datum/storage/pockets/tiny/spacenam)

/datum/storage/pockets/tiny/spacenam
	attack_hand_interact = TRUE		//So you can actually see what you stuff in there

//Cyberpunk PI Costume - Sprites from Eris
/obj/item/clothing/head/fedora/det_hat/cybergoggles //Subset of detective fedora so that detectives dont have to sacrifice candycorns for style
	name = "type-34C semi-enclosed headwear"
	desc = "Civilian model of a popular helmet used by certain law enforcement agencies. It does not have any armor plating, but has a neo-laminated fiber lining."
	icon = 'packages/clothing/assets/obj/hats.dmi'
	worn_icon = 'packages/clothing/assets/mob/head.dmi'
	icon_state = "cyberpunkgoggle"
	supports_variations_flags = CLOTHING_SNOUTED_VARIATION_NO_NEW_ICON

/obj/item/clothing/head/hats/intern/developer
	name = "intern beancap"

/obj/item/clothing/head/beret/sec/navywarden/syndicate
	name = "master at arms' beret"
	desc = "Surprisingly stylish, if you lived in a silent impressionist film."
	greyscale_config = /datum/greyscale_config/beret_badge
	greyscale_config_worn = /datum/greyscale_config/beret_badge/worn
	greyscale_colors = "#353535#AAAAAA"
	icon_state = "beret_badge"
	armor_type = /datum/armor/navywarden_syndicate
	strip_delay = 60
	supports_variations_flags = CLOTHING_SNOUTED_VARIATION_NO_NEW_ICON

/datum/armor/navywarden_syndicate
	melee = 40
	bullet = 30
	laser = 30
	energy = 40
	bomb = 25
	fire = 30
	acid = 50
	wound = 6

/obj/item/clothing/head/soft/enclave
	name = "neo american cap"
	desc = "If worn in the battlefield or at a baseball game, it's still a rather scary hat."
	icon = 'packages/clothing/assets/obj/hats.dmi'
	worn_icon = 'packages/clothing/assets/mob/head.dmi'
	icon_state = "enclavesoft"
	soft_type = "enclave"
	dog_fashion = null

/obj/item/clothing/head/soft/enclaveo
	name = "neo american officer cap"
	desc = "It blocks out the sun and laser bolts from executions."
	icon = 'packages/clothing/assets/obj/hats.dmi'
	worn_icon = 'packages/clothing/assets/mob/head.dmi'
	icon_state = "enclaveosoft"
	soft_type = "enclaveo"
	dog_fashion = null

/obj/item/clothing/head/hats/sec/peacekeeper/sol
	name = "sol police cap"
	desc = "Be a proper boy in blue with this cap, comes with a black visor to block out inconvenient truths."
	icon = 'packages/clothing/assets/obj/hats.dmi'
	worn_icon = 'packages/clothing/assets/mob/head.dmi'
	icon_state = "policeofficercap"
	supports_variations_flags = CLOTHING_SNOUTED_VARIATION_NO_NEW_ICON

/obj/item/clothing/head/hats/hos/peacekeeper/sol
	name = "sol police chief cap"
	desc = "A blue hat adorned with gold, rumoured to be used to distract Agents with its swag."
	icon = 'packages/clothing/assets/obj/hats.dmi'
	worn_icon = 'packages/clothing/assets/mob/head.dmi'
	icon_state = "policechiefcap"
	supports_variations_flags = CLOTHING_SNOUTED_VARIATION_NO_NEW_ICON

/obj/item/clothing/head/hats/sec/peacekeeper/sol/traffic
	name = "sol traffic cop cap"
	desc = "You think that's Shitcurrity? That's just Civil Shitsputes, I'll show you REAL Shitcurrity."
	icon = 'packages/clothing/assets/obj/hats.dmi'
	worn_icon = 'packages/clothing/assets/mob/head.dmi'
	icon_state = "policetrafficcap"
	supports_variations_flags = CLOTHING_SNOUTED_VARIATION_NO_NEW_ICON

/obj/item/clothing/head/colourable_flatcap
	name = "colourable flat cap"
	desc = "You in the computers son? You work the computers?"
	icon_state = "flatcap"
	greyscale_config = /datum/greyscale_config/flatcap
	greyscale_config_worn = /datum/greyscale_config/flatcap/worn
	greyscale_colors = "#79684c"
	flags_1 = IS_PLAYER_COLORABLE_1
	supports_variations_flags = CLOTHING_SNOUTED_VARIATION_NO_NEW_ICON

/obj/item/clothing/head/soft/yankee
	name = "fashionable baseball cap"
	desc = "Rimmed and brimmed."
	icon = 'packages/clothing/assets/obj/hats.dmi'
	worn_icon = 'packages/clothing/assets/mob/head.dmi'
	icon_state = "yankeesoft"
	soft_type = "yankee"
	supports_variations_flags = CLOTHING_SNOUTED_VARIATION_NO_NEW_ICON

/obj/item/clothing/head/soft/yankee/rimless
	name = "rimless fashionable baseball cap"
	desc = "Rimless for her pleasure."
	icon = 'packages/clothing/assets/obj/hats.dmi'
	worn_icon = 'packages/clothing/assets/mob/head.dmi'
	icon_state = "yankeenobrimsoft"
	soft_type = "yankeenobrim"

/obj/item/clothing/head/fedora/fedbrown
	name = "brown fedora"
	desc = "A noir-inspired fedora. Covers the eyes. Makes you look menacing, assuming you don't have a neckbeard."
	icon = 'packages/clothing/assets/obj/hats.dmi'
	worn_icon = 'packages/clothing/assets/mob/head.dmi'
	icon_state = "brfedora"
	supports_variations_flags = CLOTHING_SNOUTED_VARIATION_NO_NEW_ICON

/obj/item/clothing/head/fedora/fedblack
	name = "black fedora"
	desc = "A matte-black fedora. Looks solid enough. It'll only look good on you if you don't have a neckbeard."
	icon = 'packages/clothing/assets/obj/hats.dmi'
	worn_icon = 'packages/clothing/assets/mob/head.dmi'
	icon_state = "blfedora"
	supports_variations_flags = CLOTHING_SNOUTED_VARIATION_NO_NEW_ICON

/obj/item/clothing/head/standalone_hood
	name = "hood"
	desc = "A hood with a bit of support around the neck so it actually stays in place, for all those times you want a hood without the coat."
	icon = 'packages/greyscale/assets/head/head.dmi'
	worn_icon = 'packages/greyscale/assets/head/head.dmi'
	worn_icon_teshari = 'packages/greyscale/assets/head/head_teshari.dmi'
	icon_state = "hood"
	body_parts_covered = HEAD
	cold_protection = HEAD
	min_cold_protection_temperature = FIRE_SUIT_MIN_TEMP_PROTECT
	flags_inv = HIDEEARS|HIDEHAIR
	supports_variations_flags = CLOTHING_SNOUTED_VARIATION_NO_NEW_ICON
	flags_1 = IS_PLAYER_COLORABLE_1
	greyscale_colors = "#4e4a43#F1F1F1"
	greyscale_config = /datum/greyscale_config/standalone_hood
	greyscale_config_worn = /datum/greyscale_config/standalone_hood/worn
	greyscale_config_worn_teshari = /datum/greyscale_config/standalone_hood/worn/teshari
	greyscale_config_worn_better_vox = /datum/greyscale_config/standalone_hood/worn/newvox
	greyscale_config_worn_vox = /datum/greyscale_config/standalone_hood/worn/oldvox

/obj/item/clothing/head/beret/badge
	name = "badged beret"
	desc = "A beret. With a badge. What do you want, a dissertation? It's a hat."
	icon_state = "beret_badge"
	greyscale_config = /datum/greyscale_config/beret_badge
	greyscale_config_worn = /datum/greyscale_config/beret_badge/worn
	greyscale_colors = "#972A2A#EFEFEF"
	flags_1 = IS_PLAYER_COLORABLE_1

/obj/item/clothing/head/costume/cowboyhat_old
	icon = 'packages/clothing/assets/obj/hats.dmi'
	worn_icon = 'packages/clothing/assets/mob/head.dmi'
	name = "old cowboy hat"
	desc = "An older cowboy hat, perfect for any outlaw, though lacking fancy colour magic."
	icon_state = "cowboyhat_black"
	inhand_icon_state = "cowboy_hat_black"
	supports_variations_flags = CLOTHING_SNOUTED_VARIATION_NO_NEW_ICON
