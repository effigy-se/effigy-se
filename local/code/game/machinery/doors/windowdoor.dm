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
