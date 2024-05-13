/datum/asset/spritesheet/decals
	preview_floor_icon = EFFIGY_TURFS_ICON_FILE

/obj/item/airlock_painter/decal/cyborg
	name = "cyborg decal painter"
	desc = "A mechnically installed painter with molecular printer to supply any and all of a painter's needs!"
	desc_controls = ""

/obj/item/airlock_painter/decal/cyborg/use_paint(mob/user)
	if(can_use(user))
		playsound(src.loc, 'sound/effects/spray2.ogg', 50, TRUE)
		return TRUE
	else
		return FALSE

/obj/item/airlock_painter/decal/cyborg/click_alt(mob/user)
	return
