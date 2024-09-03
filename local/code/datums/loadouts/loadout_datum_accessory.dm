/*
  *	LOADOUT ITEM DATUMS FOR THE ACCESSORY SLOT
*/

/// Accessory Items (Moves overrided items to backpack)
GLOBAL_LIST_INIT(loadout_accessory, generate_loadout_items(/datum/loadout_item/accessory))

/datum/loadout_item/accessory
	category = LOADOUT_ITEM_ACCESSORY

/datum/loadout_item/accessory/pre_equip_item(datum/outfit/outfit, datum/outfit/outfit_important_for_life, visuals_only = FALSE)
	if(initial(outfit_important_for_life.accessory))
		.. ()
		return TRUE

/datum/loadout_item/accessory/insert_path_into_outfit(datum/outfit/outfit, mob/living/carbon/human/equipper, visuals_only = FALSE, override_items = LOADOUT_OVERRIDE_BACKPACK)
	if(override_items == LOADOUT_OVERRIDE_BACKPACK && !visuals_only)
		if(outfit.accessory)
			LAZYADD(outfit.backpack_contents, outfit.accessory)
		outfit.accessory = item_path
	else
		outfit.accessory = item_path

/*
 *	MISCELLANEOUS
 */

/datum/loadout_item/accessory/full_pocket_protector
	name = "Pocket Protector (Filled)"
	item_path = /obj/item/clothing/accessory/pocketprotector/full
	additional_tooltip_contents = list("CONTAINS PENS - This item contains multiple pens on spawn.")

/datum/loadout_item/accessory/pocket_protector
	name = "Pocket Protector (Empty)"
	item_path = /obj/item/clothing/accessory/pocketprotector

/datum/loadout_item/accessory/ribbon
	name = "Ribbon"
	item_path = /obj/item/clothing/accessory/medal/ribbon

/datum/loadout_item/accessory/pride
	name = "Pride Pin"
	item_path = /obj/item/clothing/accessory/pride

/datum/loadout_item/accessory/maid_apron
	name = "Maid Apron"
	item_path = /obj/item/clothing/accessory/maidapron

/datum/loadout_item/accessory/maid_corset
	name = "Maid Corset"
	item_path = /obj/item/clothing/accessory/maidcorset

/datum/loadout_item/accessory/waistcoat
	name = "Waistcoat"
	item_path = /obj/item/clothing/accessory/waistcoat

/datum/loadout_item/accessory/waistcoat/sheriff
	name = "Sheriff Vest"
	item_path = /obj/item/clothing/accessory/vest_sheriff

/*
 *	ARMBANDS
 */

 /datum/loadout_item/accessory/armband
	name = "Armband (red)" //need to make this recolorable at some point, locking it to one color is laaaame
	item_path = /obj/item/clothing/accessory/armband

/datum/loadout_item/accessory/armband_deputy
	name = "Security Deputy Armband"
	item_path = /obj/item/clothing/accessory/armband/deputy
	restricted_roles = list(JOB_HEAD_OF_SECURITY, JOB_SECURITY_OFFICER, JOB_WARDEN, JOB_DETECTIVE)

/datum/loadout_item/accessory/armband_cargo
	name = "Cargo Armband"
	item_path = /obj/item/clothing/accessory/armband/cargo
	restricted_roles = list(JOB_QUARTERMASTER, JOB_CARGO_TECHNICIAN, JOB_SHAFT_MINER, JOB_BITRUNNER, JOB_SECURITY_OFFICER)

/datum/loadout_item/accessory/armband_engineering
	name = "Engineering Armband"
	item_path = /obj/item/clothing/accessory/armband/engine
	restricted_roles = list(JOB_CHIEF_ENGINEER, JOB_STATION_ENGINEER, JOB_ATMOSPHERIC_TECHNICIAN, JOB_SECURITY_OFFICER)

/datum/loadout_item/accessory/armband_science
	name = "Science Armband"
	item_path = /obj/item/clothing/accessory/armband/science
	restricted_roles = list(JOB_RESEARCH_DIRECTOR, JOB_SCIENTIST, JOB_ROBOTICIST, JOB_GENETICIST, JOB_SECURITY_OFFICER)

/datum/loadout_item/accessory/armband_hydro
	name = "Hydroponicss Armband"
	item_path = /obj/item/clothing/accessory/armband/hydro
	restricted_roles = list(JOB_BOTANIST, JOB_CHEF, JOB_COOK, JOB_BARTENDER, JOB_PSYCHOLOGIST, JOB_SECURITY_OFFICER) //psychs are service, so..

/datum/loadout_item/accessory/armband_med
	name = "Medical Armband (white)"
	item_path = /obj/item/clothing/accessory/armband/med
	restricted_roles = list(JOB_CHIEF_MEDICAL_OFFICER, JOB_MEDICAL_DOCTOR, JOB_PARAMEDIC, JOB_CHEMIST, JOB_CORONER, JOB_PSYCHOLOGIST, JOB_SECURITY_OFFICER)

/datum/loadout_item/accessory/armband_medblue
	name = "Medical Armband (blue stripe)"
	item_path = /obj/item/clothing/accessory/armband/medblue
	restricted_roles = list(JOB_CHIEF_MEDICAL_OFFICER, JOB_MEDICAL_DOCTOR, JOB_PARAMEDIC, JOB_CHEMIST, JOB_CORONER, JOB_PSYCHOLOGIST, JOB_SECURITY_OFFICER)

/*
 * BADGES
 */

/datum/loadout_item/accessory/badge
	name = "Security Badge"
	item_path = /obj/item/clothing/accessory/badge
	restricted_roles = list(JOB_HEAD_OF_SECURITY, JOB_SECURITY_OFFICER, JOB_WARDEN, JOB_DETECTIVE)

/datum/loadout_item/accessory/badge/old
	name = "Vintage Security Badge"
	item_path = /obj/item/clothing/accessory/badge/old
	restricted_roles = list(JOB_HEAD_OF_SECURITY, JOB_SECURITY_OFFICER, JOB_WARDEN, JOB_DETECTIVE)

/datum/loadout_item/accessory/badge/sheriff
	name = "Sheriff Badge"
	item_path = /obj/item/clothing/accessory/badge/sheriff
	restricted_roles = list(JOB_HEAD_OF_SECURITY, JOB_SECURITY_OFFICER, JOB_WARDEN, JOB_DETECTIVE)

/datum/loadout_item/accessory/badge/holo
	name = "Security HoloBadge"
	item_path = /obj/item/clothing/accessory/badge/holo
	restricted_roles = list(JOB_SECURITY_OFFICER)

/datum/loadout_item/accessory/badge/holo/cord
	name = "Corded Security HoloBadge"
	item_path = /obj/item/clothing/accessory/badge/holo/cord
	restricted_roles = list(JOB_HEAD_OF_SECURITY, JOB_SECURITY_OFFICER, JOB_WARDEN, JOB_DETECTIVE)

/datum/loadout_item/accessory/badge/holo/hos
	name = "Security Head HoloBadge"
	item_path = /obj/item/clothing/accessory/badge/holo/hos
	restricted_roles = list(JOB_HEAD_OF_SECURITY, JOB_SECURITY_OFFICER, JOB_WARDEN, JOB_DETECTIVE)

/datum/loadout_item/accessory/badge/holo/warden
	name = "Brig HoloBadge"
	item_path = /obj/item/clothing/accessory/badge/holo/warden
	restricted_roles = list(JOB_HEAD_OF_SECURITY, JOB_SECURITY_OFFICER, JOB_WARDEN, JOB_DETECTIVE)

/datum/loadout_item/accessory/badge/holo/detective
	name = "Investigative HoloBadge"
	item_path = /obj/item/clothing/accessory/badge/holo/detective
	restricted_roles = list(JOB_HEAD_OF_SECURITY, JOB_SECURITY_OFFICER, JOB_WARDEN, JOB_DETECTIVE)

/*
 *	ARMOURLESS
 */

/datum/loadout_item/accessory/bone_charm
	name = "Heirloom Bone Talisman"
	item_path = /obj/item/clothing/accessory/talisman/armourless
	additional_tooltip_contents = list(TOOLTIP_NO_ARMOR)

/datum/loadout_item/accessory/bone_codpiece
	name = "Heirloom Skull Codpiece"
	item_path = /obj/item/clothing/accessory/skullcodpiece/armourless
	additional_tooltip_contents = list(TOOLTIP_NO_ARMOR)

/datum/loadout_item/accessory/sinew_kilt
	name = "Heirloom Sinew Skirt"
	item_path = /obj/item/clothing/accessory/skilt/armourless
	additional_tooltip_contents = list(TOOLTIP_NO_ARMOR)
