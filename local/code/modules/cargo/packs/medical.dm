/datum/supply_pack/medical/anesthetics
	name = "Anesthetics Crate"
	desc = "Contains two of the following: Morphine bottles, syringes, breath masks, and anesthetic tanks. Requires Medical Access to open."
	access = ACCESS_MEDICAL
	cost = CARGO_CRATE_VALUE * 4
	contains = list(
		/obj/item/reagent_containers/cup/bottle/morphine,
		/obj/item/reagent_containers/cup/bottle/morphine,
		/obj/item/reagent_containers/syringe,
		/obj/item/reagent_containers/syringe,
		/obj/item/clothing/mask/breath,
		/obj/item/clothing/mask/breath,
		/obj/item/tank/internals/anesthetic,
		/obj/item/tank/internals/anesthetic,
	)
	crate_name = "anesthetics crate"

/datum/supply_pack/medical/firstaidmixed
	name = "Mixed Medical Kits"
	desc = "Contains one of each medical kits for dealing with a variety of injured crewmembers."
	cost = CARGO_CRATE_VALUE * 5
	contains = list(
		/obj/item/storage/medkit/toxin,
		/obj/item/storage/medkit/o2,
		/obj/item/storage/medkit/brute,
		/obj/item/storage/medkit/fire,
		/obj/item/storage/medkit/regular,
	)
	crate_name = "medical kit crate"

/datum/supply_pack/medical/modsuit_medical
	name = "Medical MODsuit Crate"
	desc = "Contains a single MODsuit, built to standard medical specifications."
	cost = CARGO_CRATE_VALUE * 13
	access = ACCESS_MEDICAL
	contains = list(/obj/item/mod/control/pre_equipped/medical)
	crate_name = "medical MODsuit crate"
	crate_type = /obj/structure/closet/crate/secure //No medical varient with security locks.

/datum/supply_pack/medical/compact_defib
	name = "Compact Defibrillator Crate"
	desc = "Contains a single compact defibrillator. Capable of being worn as a belt."
	cost = CARGO_CRATE_VALUE * 5
	access = ACCESS_MEDICAL
	contains = list(/obj/item/defibrillator/compact)
	crate_name = "compact defibrillator crate"
