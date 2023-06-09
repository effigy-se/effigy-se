/obj/item/ammo_casing/foam_dart
	name = "foam dart"
	desc = "It's Donk or Don't! Ages 8 and up."
	projectile_type = /obj/projectile/bullet/foam_dart
	caliber = CALIBER_FOAM
	icon = 'icons/obj/weapons/guns/toy.dmi'
	icon_state = "foamdart"
	base_icon_state = "foamdart"
	custom_materials = list(/datum/material/iron = SMALL_MATERIAL_AMOUNT * 0.1125)
	harmful = FALSE
	var/modified = FALSE

/obj/item/ammo_casing/foam_dart/Initialize(mapload)
	. = ..()
	AddElement(/datum/element/caseless, TRUE)

/obj/item/ammo_casing/foam_dart/update_icon_state()
	. = ..()
	if(modified)
		icon_state = "[base_icon_state]_empty"
		loaded_projectile?.icon_state = "[base_icon_state]_empty"
		return
	icon_state = "[base_icon_state]"
	loaded_projectile?.icon_state = "[loaded_projectile.base_icon_state]"

/obj/item/ammo_casing/foam_dart/update_desc()
	. = ..()
	desc = "It's Donk or Don't! [modified ? "... Although, this one doesn't look too safe." : "Ages 8 and up."]"

/obj/item/ammo_casing/foam_dart/attackby(obj/item/A, mob/user, params)
	var/obj/projectile/bullet/foam_dart/FD = loaded_projectile
	if (A.tool_behaviour == TOOL_SCREWDRIVER && !modified)
		modified = TRUE
		FD.modified = TRUE
		FD.damage_type = BRUTE
		to_chat(user, span_notice("You pop the safety cap off [src]."))
		update_appearance()
	else if (istype(A, /obj/item/pen))
		if(modified)
			if(!FD.pen)
				harmful = TRUE
				if(!user.transferItemToLoc(A, FD))
					return
				FD.pen = A
				FD.damage = 5
				to_chat(user, span_notice("You insert [A] into [src]."))
			else
				to_chat(user, span_warning("There's already something in [src]."))
		else
			to_chat(user, span_warning("The safety cap prevents you from inserting [A] into [src]."))
	else
		return ..()

/obj/item/ammo_casing/foam_dart/attack_self(mob/living/user)
	var/obj/projectile/bullet/foam_dart/FD = loaded_projectile
	if(FD.pen)
		FD.damage = initial(FD.damage)
		user.put_in_hands(FD.pen)
		to_chat(user, span_notice("You remove [FD.pen] from [src]."))
		FD.pen = null

/obj/item/ammo_casing/foam_dart/riot
	name = "riot foam dart"
	desc = "Whose smart idea was it to use toys as crowd control? Ages 18 and up."
	projectile_type = /obj/projectile/bullet/foam_dart/riot
	icon_state = "foamdart_riot"
	base_icon_state = "foamdart_riot"
	custom_materials = list(/datum/material/iron = HALF_SHEET_MATERIAL_AMOUNT* 1.125)
