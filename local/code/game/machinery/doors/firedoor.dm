/obj/machinery/door/firedoor
	name = "emergency shutter"
	desc = "Emergency air-tight shutter, capable of sealing off breached areas. It has a mechanism to open it with just your hands."
	icon = 'local/icons/obj/doors/firedoor_glass.dmi'
	light_power = 1
	light_range = 1.7
	var/light_color_idle = COLOR_STARLIGHT
	var/light_color_hot = LIGHT_COLOR_FLARE
	var/light_color_cold = LIGHT_COLOR_BLUE
	var/light_color_generic = LIGHT_COLOR_GLOWSTICK_YELLOW
	var/light_color_emag = LIGHT_COLOR_FAINT_BLUE
	var/light_color_operating = LIGHT_COLOR_FAINT_BLUE
	var/water_sensor = FALSE

/obj/machinery/door/firedoor/update_overlays()
	. = ..()
	if(welded)
		. += density ? "welded" : "welded_open"
	if(istype(src, /obj/machinery/door/firedoor/border_only))
		return
	if(operating)
		set_light(l_color = light_color_operating, l_on = TRUE)
		. += mutable_appearance(icon, "firelock_[icon_state]")
		. += emissive_appearance(icon, "firelock_[icon_state]", src, alpha = src.alpha)
		return
	if(!density)
		set_light(l_color = light_color_idle, l_on = TRUE)
		return
	if(powered() && !ignore_alarms)
		. += mutable_appearance(icon, "firelock_alarm_solid")
		. += emissive_appearance(icon, "firelock_alarm_solid", src, alpha = src.alpha)
		if(obj_flags & EMAGGED)
			. += mutable_appearance(icon, "em_firelock_alarm_type_emag")
			. += emissive_appearance(icon, "em_firelock_alarm_type_emag", src, alpha = src.alpha)
			set_light(l_color = light_color_emag, l_on = TRUE)
		else if(isnull(alarm_type))
			. += mutable_appearance(icon, "em_firelock_no_alarm")
			. += emissive_appearance(icon, "em_firelock_no_alarm", src, alpha = src.alpha)
			set_light(l_color = light_color_generic, l_on = TRUE)
		else
			. += mutable_appearance(icon, "em_[alarm_type]")
			. += emissive_appearance(icon, "em_[alarm_type]", src, alpha = src.alpha)
			switch(alarm_type)
				if(FIRELOCK_ALARM_TYPE_HOT)
					set_light(l_color = light_color_hot, l_on = TRUE)
				if(FIRELOCK_ALARM_TYPE_COLD)
					set_light(l_color = light_color_cold, l_on = TRUE)
				if(FIRELOCK_ALARM_TYPE_GENERIC)
					set_light(l_color = light_color_generic, l_on = TRUE)
	else
		. += mutable_appearance(icon, "em_firelock_no_power")
		. += emissive_appearance(icon, "em_firelock_no_power", src, alpha = src.alpha)
		set_light(l_color = light_color_generic, l_on = FALSE)

/obj/machinery/door/firedoor/proc/check_liquids(turf/checked_turf)
	var/obj/effect/abstract/liquid_turf/liquids = checked_turf.liquids
	if(isnull(liquids))
		return

	if(liquids.height > 1)
		return FIRELOCK_ALARM_TYPE_COLD

/obj/machinery/door/firedoor/heavy
	name = "heavy emergency shutter"
	desc = "Emergency air-tight shutter, capable of sealing off breached areas. It has a mechanism to open it with just your hands."
	icon = 'local/icons/obj/doors/firedoor.dmi'

/obj/effect/spawner/structure/window/reinforced/no_firelock
	spawn_list = list(/obj/structure/grille, /obj/structure/window/reinforced/fulltile)

/obj/machinery/door/firedoor/closed
	alarm_type = FIRELOCK_ALARM_TYPE_GENERIC

/obj/machinery/door/firedoor/water_sensor
	name = "environmental shutter"
	water_sensor = TRUE

/obj/machinery/door/firedoor/water_sensor/heavy
	name = "heavy environmental shutter"
	desc = /obj/machinery/door/firedoor/heavy::desc
	icon = /obj/machinery/door/firedoor/heavy::icon
	glass = /obj/machinery/door/firedoor/heavy::glass
	explosion_block = /obj/machinery/door/firedoor/heavy::explosion_block
	assemblytype = /obj/machinery/door/firedoor/heavy::assemblytype // This should probably be changed for this and parent; but it's not a big enough issue atm.
	max_integrity = /obj/machinery/door/firedoor/heavy::max_integrity
