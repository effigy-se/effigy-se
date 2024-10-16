/obj/machinery/button
	icon = 'local/icons/obj/buttons.dmi'

/obj/machinery/status_display
	icon = 'local/icons/obj/status_display.dmi'

/obj/machinery/status_display/post_machine_initialize()
	. = ..()
	set_picture("ai_off")

/obj/machinery/status_display/syndie
	name = "syndicate status display"
	text_color = COLOR_DISPLAY_RED
	header_text_color = COLOR_DISPLAY_RED

/obj/machinery/status_display/syndie/post_machine_initialize()
	. = ..()
	set_picture("synd")

MAPPING_DIRECTIONAL_HELPERS(/obj/machinery/status_display/syndie, 32)

/obj/machinery/power/emitter
	icon = 'local/icons/obj/engine/emitter.dmi'

/obj/machinery/field/containment
	icon = 'local/icons/obj/engine/emitter.dmi'

/obj/machinery/power/rad_collector
	icon = 'local/icons/obj/engine/emitter.dmi'

/*
#ifndef UNIT_TESTS
/obj/machinery/light_switch/post_machine_initialize()
	. = ..()
	if(prob(70) && area.lightswitch) //70% chance for area to start with lights off.
		turn_off()
#endif
*/

/obj/machinery/light_switch/proc/turn_off()
	if(!area.lightswitch)
		return
	area.lightswitch = FALSE
	area.update_icon()

	for(var/obj/machinery/light_switch/light_switch in area)
		light_switch.update_icon()

	area.power_change()

/obj/machinery/door/poddoor
	icon = 'local/icons/obj/doors/blast_door.dmi'
	var/door_sound = 'local/icons/obj/doors/blast_door.ogg'

/obj/machinery/door/poddoor/shutters
	icon = 'local/icons/obj/doors/shutters.dmi'
	var/door_open_sound = 'local/icons/obj/doors/shutters_open.ogg'
	var/door_close_sound = 'local/icons/obj/doors/shutters_close.ogg'

/obj/machinery/firealarm
	icon = 'local/icons/obj/firealarm.dmi'
