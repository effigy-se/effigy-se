/// i do not consider the MAA part of command anyways
/// that WAS the CMAA before they were taken out back when DS-1 became DS-2
/// just like the chief engine technician.. and the cmo... and the research officer...
/// remember them so i don't have to or something
/obj/structure/closet/secure_closet/event_code_syndicate/maa_locker
	icon_door = "warden"
	icon_state = "warden"
	name = "master at arms' locker"
	req_access = list("syndicate")

/obj/item/clothing/accessory/medal/silver/maa_medal
	name = "military excellence medal"
	desc = "The Victus-Gyravi Syndicate's dictionary defines excellence as \"the quality of being outstanding or extremely good\". \
		They are reknowned for keeping this up-to-date with more resilience than other, competing loosely-conglomerated terrorist organizations."

/obj/item/storage/bag/garment/master_arms
	name = "master at arms' garment bag"
	desc = "A bag for storing extra clothes and shoes. This one belongs to the master at arms; and's surely extra-corporate contraband."

/obj/item/storage/bag/garment/master_arms/PopulateContents()
	new /obj/item/clothing/accessory/medal/silver/maa_medal(src)
	new /obj/item/clothing/suit/armor/vest/warden/syndicate(src)
	new /obj/item/clothing/under/rank/security/skyrat/utility/redsec/syndicate(src)
	new /obj/item/clothing/under/suit/skyrat/helltaker(src)
	new /obj/item/clothing/head/beret/sec/navywarden/syndicate(src)
	new /obj/item/clothing/head/hats/hos/beret/syndicate(src)

/obj/structure/closet/secure_closet/event_code_syndicate/maa_locker/PopulateContents()
	..()

	new /obj/item/storage/belt/security/full(src)
	new /obj/item/watertank/pepperspray(src)
	new /obj/item/storage/bag/garment/master_arms(src)

/obj/structure/closet/secure_closet/event_code_syndicate/maa_locker/populate_contents_immediate()
	. = ..()

	new /obj/item/gun/energy/disabler(src)
