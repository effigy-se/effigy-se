// Midrange model of RCD, with Combat being the high end
/obj/item/construction/rcd/mkii
	name = "RCD Mk II"
	desc = "A device used to rapidly build and deconstruct. Upgraded from the standard model with improved material storage. Reload with iron, plasteel, glass or compressed matter cartridges."
	icon = 'local/icons/obj/tools.dmi'
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

/obj/item/construction/plumbing/mining
	name = "mining plumbing constructor"
	desc = "A type of plumbing constructor designed to harvest from geysers and collect their fluids."
	icon = 'local/icons/obj/tools.dmi'
	icon_state = "plumberer_mining"
	var/static/list/mining_design_types = list(
		//category 1 Synthesizers i.e devices which creates , reacts & destroys chemicals
		"Synthesizers" = list(
			/obj/machinery/plumbing/grinder_chemical = 30,
			/obj/machinery/plumbing/liquid_pump = 35, //extracting chemicals from ground is one way of creation
			/obj/machinery/plumbing/disposer = 10,
			/obj/machinery/plumbing/buffer = 10, //creates chemicals as it waits for other buffers containing other chemicals and when mixed creates new chemicals
		),
		//category 2 distributors i.e devices which inject , move around , remove chemicals from the network
		"Distributors" = list(
			/obj/machinery/duct = 1,
			/obj/machinery/plumbing/layer_manifold = 5,
			/obj/machinery/plumbing/input = 5,
			/obj/machinery/plumbing/filter = 5,
			/obj/machinery/plumbing/splitter = 5,
			/obj/machinery/plumbing/sender = 20,
			/obj/machinery/plumbing/output = 5,
		),

		//category 3 Storage i.e devices which stores & makes the processed chemicals ready for consumption
		"Storage" = list(
			/obj/machinery/plumbing/tank = 20,
			/obj/machinery/plumbing/acclimator = 10,
			/obj/machinery/plumbing/bottler = 50,
			/obj/machinery/iv_drip/plumbing = 20
		),

		//category 4 liquids
		"Liquids" = list(
			/obj/structure/drain = 5,
		),
	)

/obj/item/construction/plumbing/mining/Initialize(mapload)
	. = ..()
	plumbing_design_types = mining_design_types
