//This is so we log all machinery interactions for drones
/obj/machinery/attack_drone(mob/living/basic/drone/user, list/modifiers)
	. = ..()
	user.log_message("[key_name(user)] interacted with [src] at [AREACOORD(src)]", LOG_GAME)
