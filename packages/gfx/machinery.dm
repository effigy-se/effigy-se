/obj/machinery/button
	icon = 'packages/gfx/assets/obj/buttons.dmi'

/obj/machinery/status_display
	icon = 'packages/gfx/assets/obj/status_display.dmi'

/obj/machinery/status_display/LateInitialize()
	. = ..()
	set_picture("ai_off")

/obj/machinery/status_display/syndie
	name = "syndicate status display"

/obj/machinery/status_display/syndie/LateInitialize()
	. = ..()
	set_picture("synd")

/obj/machinery/door/window
	icon = 'packages/gfx/assets/obj/directwindow.dmi'

/obj/machinery/power/emitter
	icon = 'packages/gfx/assets/obj/engine/emitter.dmi'

/obj/machinery/field/containment
	icon = 'packages/gfx/assets/obj/engine/emitter.dmi'

/obj/machinery/power/rad_collector
	icon = 'packages/gfx/assets/obj/engine/emitter.dmi'

/obj/machinery/light_switch
	icon = 'packages/gfx/assets/obj/power.dmi'

/obj/machinery/light_switch/LateInitialize()
	. = ..()
	if(prob(70) && area.lightswitch) //70% chance for area to start with lights off.
		turn_off()

/obj/machinery/light_switch/proc/turn_off()
	if(!area.lightswitch)
		return
	area.lightswitch = FALSE
	area.update_icon()

	for(var/obj/machinery/light_switch/light_switch in area)
		light_switch.update_icon()

	area.power_change()

/obj/machinery/door/firedoor
	name = "emergency shutter"
	desc = "Emergency air-tight shutter, capable of sealing off breached areas. This one has a glass panel. It has a mechanism to open it with just your hands."
	icon = 'packages/gfx/assets/obj/door/firedoor_glass.dmi'

/obj/machinery/door/firedoor/update_overlays()
	. = ..()
	if(istype(src, /obj/machinery/door/firedoor/border_only))
		return
	if(density) // if the door is closed, add the bottom blinking overlay -- and only if it's closed
		. += "firelock_alarm_type_bottom"

/obj/machinery/door/firedoor/heavy
	name = "heavy emergency shutter"
	desc = "Emergency air-tight shutter, capable of sealing off breached areas. It has a mechanism to open it with just your hands."
	icon = 'packages/gfx/assets/obj/door/firedoor.dmi'

/obj/effect/spawner/structure/window/reinforced/no_firelock
	spawn_list = list(/obj/structure/grille, /obj/structure/window/reinforced/fulltile)

/obj/machinery/door/firedoor/closed
	alarm_type = FIRELOCK_ALARM_TYPE_GENERIC

/obj/machinery/door/poddoor
	icon = 'packages/gfx/assets/obj/door/blast_door.dmi'
	var/door_sound = 'packages/gfx/assets/obj/door/blast_door.ogg'

/obj/machinery/door/poddoor/shutters
	icon = 'packages/gfx/assets/obj/door/shutters.dmi'
	var/door_open_sound = 'packages/gfx/assets/obj/door/shutters_open.ogg'
	var/door_close_sound = 'packages/gfx/assets/obj/door/shutters_close.ogg'

/obj/machinery/door/poddoor/shutters/do_animate(animation)
	switch(animation)
		if("opening")
			flick("opening", src)
			playsound(src, door_open_sound, 30, TRUE)
		if("closing")
			flick("closing", src)
			playsound(src, door_close_sound, 30, TRUE)

/obj/machinery/firealarm
	icon = 'packages/gfx/assets/obj/firealarm.dmi'

/obj/machinery/camera
	icon = 'packages/gfx/assets/obj/machine/camera.dmi'
