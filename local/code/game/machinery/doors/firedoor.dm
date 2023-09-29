/obj/machinery/door/firedoor
	name = "emergency shutter"
	desc = "Emergency air-tight shutter, capable of sealing off breached areas. This one has a glass panel. It has a mechanism to open it with just your hands."
	icon = 'local/icons/obj/doors/firedoor_glass.dmi'
	light_power = AIRLOCK_LIGHT_POWER
	light_range = AIRLOCK_LIGHT_RANGE
	var/light_color_idle = COLOR_STARLIGHT
	var/light_color_hot = LIGHT_COLOR_FLARE
	var/light_color_cold = LIGHT_COLOR_BLUE
	var/light_color_generic = LIGHT_COLOR_GLOWSTICK_YELLOW
	var/light_color_emag = LIGHT_COLOR_FAINT_BLUE
	var/light_color_operating = LIGHT_COLOR_FAINT_BLUE

/obj/machinery/door/firedoor/update_overlays()
	. = ..()
	if(istype(src, /obj/machinery/door/firedoor/border_only))
		return
	if(!density)
		set_light(l_color = light_color_idle, l_on = TRUE)
		return
	if(operating)
		set_light(l_color = light_color_operating, l_on = TRUE)
		return
	if(powered() && !ignore_alarms) // if the door is closed, add the bottom blinking overlay -- and only if it's closed
		if(obj_flags & EMAGGED)
			. += mutable_appearance(icon, "firelock_alarm_type_emag")
			. += emissive_appearance(icon, "firelock_alarm_type_emag", src, alpha = src.alpha)
			set_light(l_color = light_color_emag, l_on = TRUE)
		else if(isnull(alarm_type))
			. += mutable_appearance(icon, "firelock_no_alarm")
			. += emissive_appearance(icon, "firelock_no_alarm", src, alpha = src.alpha)
			set_light(l_color = light_color_generic, l_on = TRUE)
		else
			. += mutable_appearance(icon, alarm_type)
			. += emissive_appearance(icon, alarm_type, src, alpha = src.alpha)
			switch(alarm_type)
				if(FIRELOCK_ALARM_TYPE_HOT)
					set_light(l_color = light_color_hot, l_on = TRUE)
				if(FIRELOCK_ALARM_TYPE_COLD)
					set_light(l_color = light_color_cold, l_on = TRUE)
				if(FIRELOCK_ALARM_TYPE_GENERIC)
					set_light(l_color = light_color_generic, l_on = TRUE)
	else
		. += mutable_appearance(icon, "firelock_no_power")
		. += emissive_appearance(icon, "firelock_no_power", src, alpha = src.alpha)
		set_light(l_color = light_color_generic, l_on = TRUE)

/obj/machinery/door/firedoor/heavy
	name = "heavy emergency shutter"
	desc = "Emergency air-tight shutter, capable of sealing off breached areas. It has a mechanism to open it with just your hands."
	icon = 'local/icons/obj/doors/firedoor_glass.dmi'

/obj/effect/spawner/structure/window/reinforced/no_firelock
	spawn_list = list(/obj/structure/grille, /obj/structure/window/reinforced/fulltile)

/obj/machinery/door/firedoor/closed
	alarm_type = FIRELOCK_ALARM_TYPE_GENERIC
