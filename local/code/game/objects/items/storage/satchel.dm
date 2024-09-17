
// Midrange bag for paramedics, hypospray and more flexible item wise than surgical, but restricted to small items only
/obj/item/storage/backpack/duffelbag/deforest_paramedic
	name = "medical technician kit"
	desc = "Compared to its sibling the first responder surgical kit, this variant is equipped with a hypospray hit for roving paramedics. Featuring rapid access pockets that are lightweight, it can however only hold smaller items."
	icon = 'local/icons/obj/medical/storage.dmi'
	icon_state = "technician"
	lefthand_file = 'local/icons/mob/inhands/medical/cases_lefthand.dmi'
	righthand_file = 'local/icons/mob/inhands/medical/cases_righthand.dmi'
	inhand_icon_state = "technician"
	worn_icon = 'local/icons/mob/medical/worn.dmi'
	worn_icon_teshari = 'local/icons/mob/medical/worn_teshari.dmi'
	equip_sound = 'sound/items/equip/jumpsuit_equip.ogg'
	pickup_sound = 'sound/items/handling/cloth_pickup.ogg'
	drop_sound = 'sound/items/handling/cloth_drop.ogg'
	slot_flags = ITEM_SLOT_BACK | ITEM_SLOT_BELT
	storage_type = /datum/storage/duffel/deforest_paramedic
	zip_slowdown = 0.3 // Midrange between the other two bags
	unzip_duration = 1.2 SECONDS

/obj/item/storage/backpack/duffelbag/deforest_paramedic/stocked

	// EffigyEdit TODO - TEMPORARY ONLY, Replace with mini saw
/obj/item/circular_saw
	w_class = WEIGHT_CLASS_SMALL

/obj/item/storage/backpack/duffelbag/deforest_paramedic/stocked/PopulateContents()
	var/static/items_inside = list(
		/obj/item/scalpel = 1,
		/obj/item/hemostat = 1,
		/obj/item/retractor = 1,
		/obj/item/circular_saw = 1,
		/obj/item/bonesetter = 1,
		/obj/item/cautery = 1,
		/obj/item/surgical_drapes = 1,
		/obj/item/stack/medical/bone_gel = 1,
		/obj/item/stack/medical/mesh/advanced = 2,
		/obj/item/stack/medical/suture/medicated = 2,
		/obj/item/stack/medical/gauze = 1,
		/obj/item/hypospray/mkii/piercing/atropine = 1,
		/obj/item/reagent_containers/cup/hypovial/small/libital = 1,
		/obj/item/reagent_containers/cup/hypovial/small/lenturi = 1,
		/obj/item/reagent_containers/cup/hypovial/small/seiver = 1,
		/obj/item/healthanalyzer = 1,
	)
	generate_items_inside(items_inside,src)

/datum/storage/duffel/deforest_paramedic
	max_specific_storage = WEIGHT_CLASS_SMALL
	max_total_storage = 21 * WEIGHT_CLASS_SMALL
	max_slots = 21

/datum/storage/duffel/deforest_paramedic/New()
	. = ..()

	can_hold = typecacheof(list(
		/obj/item/bonesetter,
		/obj/item/cautery,
		/obj/item/circular_saw,
		/obj/item/clothing/neck/stethoscope,
		/obj/item/clothing/mask/breath,
		/obj/item/clothing/mask/muzzle,
		/obj/item/clothing/mask/surgical,
		/obj/item/dnainjector,
		/obj/item/extinguisher/mini,
		/obj/item/flashlight/pen,
		/obj/item/geiger_counter,
		/obj/item/healthanalyzer,
		/obj/item/hemostat,
		/obj/item/holosign_creator/medical,
		/obj/item/hypospray,
		/obj/item/implant,
		/obj/item/implantcase,
		/obj/item/implanter,
		/obj/item/lazarus_injector,
		/obj/item/lighter,
		/obj/item/pinpointer/crew,
		/obj/item/reagent_containers/blood,
		/obj/item/reagent_containers/dropper,
		/obj/item/reagent_containers/cup/beaker,
		/obj/item/reagent_containers/cup/bottle,
		/obj/item/reagent_containers/cup/hypovial,
		/obj/item/reagent_containers/cup/tube,
		/obj/item/reagent_containers/hypospray,
		/obj/item/reagent_containers/medigel,
		/obj/item/reagent_containers/pill,
		/obj/item/reagent_containers/spray,
		/obj/item/reagent_containers/syringe,
		/obj/item/retractor,
		/obj/item/scalpel,
		/obj/item/surgical_drapes,
		/obj/item/stack/medical,
		/obj/item/stack/sticky_tape,
		/obj/item/sensor_device,
		/obj/item/storage/fancy/cigarettes,
		/obj/item/storage/pill_bottle,
		/obj/item/tank/internals/emergency_oxygen,
		/obj/item/storage/box/bandages,
		/obj/item/bodybag,
	))
