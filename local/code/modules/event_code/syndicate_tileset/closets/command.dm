/// mostly copied from ds-2 on the ruined wasteland that is now skyrat; since that's easy to reference and mostly my fault
/// if you stumbled in here: hi how's the weather

// STATION ADMIRAL
/obj/structure/closet/secure_closet/event_code_syndicate/sa_locker
	icon_door = "syndicate"
	icon_state = "syndicate"
	name = "\proper station admiral's locker"

/obj/item/clothing/accessory/medal/gold/admiral
	name = "medal of admiralty"
	desc = "A golden medal awarded exclusively to those promoted to the rank of Admiral. \
		It signifies the codified responsibilities of an Admiral to the Victus-Gyravi Syndicate, and their undisputable authority over their crew."

/obj/item/clothing/accessory/medal/gold/admiral/examine(mob/user)
	. = ..()
	. += span_warning("Or, at least... it used to.")

/obj/item/storage/bag/garment/station_admiral
	name = "station admiral's garment bag"
	desc = "A bag for storing extra clothes and shoes. This one belongs to the station admiral. This is technically extra-corporate contraband; and you should \
		probably be busy looking for those generators, but..."

/obj/item/storage/bag/garment/station_admiral/PopulateContents()
	new /obj/item/clothing/head/hats/hos/cap/syndicate(src)
	new /obj/item/clothing/suit/armor/vest/capcarapace/syndicate(src)
	new /obj/item/clothing/under/rank/captain/skyrat/utility/syndicate(src)
	new /obj/item/clothing/glasses/sunglasses(src)
	new /obj/item/clothing/accessory/medal/gold/admiral(src)


/obj/structure/closet/secure_closet/event_code_syndicate/sa_locker/PopulateContents()
	..()

	new /obj/item/storage/bag/garment/station_admiral(src)

/// CORPORATE LIASION
/obj/structure/closet/secure_closet/event_code_syndicate/cl_locker
	icon_door = "hop"
	icon_state = "hop"
	name = "\proper corporate liaison's locker"
	req_access = list("syndicate_leader")

/obj/item/clothing/neck/chaplain/black/cl_cloak
	name = "corporate liaison's cloak"
	desc = "A \"unique\" cloak that shimmers with... hey; that's just a cross!"

/obj/item/clothing/neck/chaplain/black/cl_cloak/examine(mob/user)
	. = ..()
	. += span_warning("There's likely a specific syndicate subfaction this confirms the involvement of - but that's a bit over your payrange.")

/obj/item/storage/bag/garment/corprate_liaison
	name = "corprate liaison's garment bag"
	desc = "A bag for storing extra clothes and shoes. This one belongs to the corprate liaison."

/obj/item/storage/bag/garment/corprate_liaison/PopulateContents()
	new /obj/item/clothing/under/syndicate/skyrat/baseball(src)
	new /obj/item/clothing/under/rank/captain/skyrat/utility/syndicate(src)
	new /obj/item/clothing/under/suit/skyrat/helltaker(src)
	new /obj/item/clothing/neck/chaplain/black/cl_cloak(src)
	new /obj/item/clothing/head/hats/hos/beret/syndicate(src)
	new /obj/item/clothing/glasses/sunglasses(src)

/obj/structure/closet/secure_closet/event_code_syndicate/cl_locker/PopulateContents()
	..()

	new /obj/item/card/id/advanced/chameleon/black(src) // were these my doing? black chameleon ID cards are fucking cracked
	new /obj/item/card/id/advanced/chameleon/black(src) // literal free AA in current year
	new /obj/item/card/id/advanced/chameleon/black(src) // it's fine for this event but i'm curious
	new /obj/item/storage/bag/garment/corprate_liaison(src)

