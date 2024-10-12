/obj/machinery/door/window
	icon = 'local/icons/obj/doors/windoor.dmi'

/obj/machinery/door/window/animation_length(animation)
	switch(animation)
		if(DOOR_OPENING_ANIMATION)
			return 1.9 SECONDS
		if(DOOR_CLOSING_ANIMATION)
			return 2.0 SECONDS

/obj/machinery/door/window/animation_segment_delay(animation)
	switch(animation)
		if(DOOR_OPENING_PASSABLE)
			return 1.1 SECONDS
		if(DOOR_OPENING_FINISHED)
			return 1.9 SECONDS
		if(DOOR_CLOSING_UNPASSABLE)
			return 1.1 SECONDS
		if(DOOR_CLOSING_FINISHED)
			return 2.0 SECONDS

/obj/machinery/door/window/brigdoor/indestructible
	resistance_flags = INDESTRUCTIBLE | LAVA_PROOF | FIRE_PROOF | UNACIDABLE | ACID_PROOF
	move_resist = INFINITY

/obj/machinery/door/window/brigdoor/indestructible/crowbar_act(mob/living/user, obj/item/tool)
	return

/obj/machinery/door/window/brigdoor/indestructible/right
	icon_state = /obj/machinery/door/window/brigdoor/right::icon_state
	base_state = /obj/machinery/door/window/brigdoor/right::base_state

MAPPING_DIRECTIONAL_HELPERS(/obj/machinery/door/window/brigdoor/indestructible/left, 0)
MAPPING_DIRECTIONAL_HELPERS(/obj/machinery/door/window/brigdoor/indestructible/right, 0)
