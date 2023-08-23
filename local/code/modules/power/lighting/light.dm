/obj/machinery/light/update_overlays()
	. = ..()

	if(low_power_mode)
		. += mutable_appearance(overlay_icon, "[base_state]_lowpower")
		. += emissive_appearance(overlay_icon, "[base_state]_lowpower", src, alpha = src.alpha)
		return

	if(!on || status != LIGHT_OK)
		. += mutable_appearance(overlay_icon, "[base_state]_off")
		. += emissive_appearance(overlay_icon, "[base_state]_off", src, alpha = src.alpha)
		return

	var/area/local_area = get_room_area(src)

	if(major_emergency || (local_area?.fire))
		. += mutable_appearance(overlay_icon, "[base_state]_emergency")
		. += emissive_appearance(overlay_icon, "[base_state]_emergency", src, alpha = src.alpha)
		return
	if(nightshift_enabled)
		. += mutable_appearance(overlay_icon, "[base_state]_nightshift")
		. += emissive_appearance(overlay_icon, "[base_state]_nightshift", src, alpha = src.alpha)
		return
	. += mutable_appearance(overlay_icon, "[base_state]")
	. += emissive_appearance(overlay_icon, "[base_state]", src, alpha = src.alpha)
