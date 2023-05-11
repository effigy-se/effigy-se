// Midrange model of RCD, with Combat being the high end
/obj/item/construction/rcd/mkii
	name = "RCD Mk II"
	desc = "A device used to rapidly build and deconstruct. Upgraded from the standard model with improved material storage. Reload with iron, plasteel, glass or compressed matter cartridges."
	icon = 'packages/adv_engineering/assets/tools.dmi'
	icon_state = "ircd"
	inhand_icon_state = "ircd"
	max_matter = 320
	matter = 320
	delay_mod = 1.4
	upgrade = RCD_UPGRADE_FRAMES | RCD_UPGRADE_SIMPLE_CIRCUITS

/obj/item/rcd_ammo/mkii
	name = "RCD Mk II matter cartridge"
	desc = "A cartridge with one complete refill for an RCD Mk II."
	w_class = WEIGHT_CLASS_SMALL
	custom_materials = list(/datum/material/iron=80000, /datum/material/glass=64000)
	ammoamt = 300

/obj/item/storage/box/rcd_ammo/mkii
	name = "RCD Mk II matter box"
	desc = "A durable box with refill cartridges for an RCD Mk II."
	icon_state = "plasticbox"
	illustration = "swab"
	custom_materials = list(/datum/material/plastic = 1000)

/obj/item/storage/box/rcd_ammo/PopulateContents()
	for(var/i in 1 to 4)
		new/obj/item/rcd_ammo/mkii(src)

/obj/item/storage/belt/utility/full/powertools/rcd/mkii/PopulateContents()
	new /obj/item/screwdriver/power(src)
	new /obj/item/crowbar/power(src)
	new /obj/item/weldingtool/experimental(src)
	new /obj/item/construction/rcd/mkii(src)
	new /obj/item/pipe_dispenser(src)
	new /obj/item/wrench/bolter(src)
	new /obj/item/analyzer/ranged(src)
