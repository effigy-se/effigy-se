/// I can't figure out day and night cycles so oopsies
/obj/machinery/solarlight
	name = "solarlight"
	desc = "A solar-charged piece of machinery for lighting roadways. Generates electricity when in contact with even the most distant sunlight."
	icon = 'local/icons/obj/lighting.dmi'
	icon_state = "solarlamp"
	density = TRUE
	use_power = NO_POWER_USE
	idle_power_usage = 0
	active_power_usage = 0
	max_integrity = 150
	integrity_failure = 0.33
	light_power = 1.75

/obj/machinery/solarlight/Initialize(mapload)
	. = ..()
	RegisterSignal(src, COMSIG_OBJ_PAINTED, TYPE_PROC_REF(/obj/machinery/power/floodlight, on_color_change))  //update light color when color changes
	update_light_state()

/obj/machinery/solarlight/proc/on_color_change(obj/machinery/power/flood_light, mob/user, obj/item/toy/crayon/spraycan/spraycan, is_dark_color)
	SIGNAL_HANDLER
	if(!spraycan.actually_paints)
		return

	update_light_state()

/obj/machinery/solarlight/Destroy()
	UnregisterSignal(src, COMSIG_OBJ_PAINTED)
	. = ..()

/// change light color during operation
/obj/machinery/solarlight/proc/update_light_state()
	var/light_color =  NONSENSICAL_VALUE
	if(!isnull(color))
		light_color = color
	set_light(15, light_power, light_color)
