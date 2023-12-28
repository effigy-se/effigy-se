/obj/machinery/button
	icon = 'local/icons/obj/buttons.dmi'

/obj/machinery/status_display
	icon = 'local/icons/obj/status_display.dmi'

/obj/machinery/status_display/LateInitialize()
	. = ..()
	set_picture("ai_off")

/obj/machinery/status_display/syndie
	name = "syndicate status display"

/obj/machinery/status_display/syndie/LateInitialize()
	. = ..()
	set_picture("synd")

/obj/machinery/door/window
	icon = 'local/icons/obj/directwindow.dmi'

/obj/machinery/power/emitter
	icon = 'local/icons/obj/engine/emitter.dmi'

/obj/machinery/field/containment
	icon = 'local/icons/obj/engine/emitter.dmi'

/obj/machinery/power/rad_collector
	icon = 'local/icons/obj/engine/emitter.dmi'


#ifndef UNIT_TESTS
/obj/machinery/light_switch/LateInitialize()
	. = ..()
	if(prob(70) && area.lightswitch) //70% chance for area to start with lights off.
		turn_off()
#endif

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

/obj/machinery/door/poddoor/shutters/do_animate(animation)
	switch(animation)
		if("opening")
			flick("opening", src)
			playsound(src, door_open_sound, 30, TRUE)
		if("closing")
			flick("closing", src)
			playsound(src, door_close_sound, 30, TRUE)

/obj/machinery/firealarm
	icon = 'local/icons/obj/firealarm.dmi'
