// Lets cyborgs drag pulled objects
/atom/proc/attack_robot_se(src, mob/user)
	if((isturf(src) || istype(src, /obj/structure/table) || istype(src, /obj/machinery/conveyor)) && get_dist(user, src) <= 1)
		user.Move_Pulled(src)
		return TRUE
	attack_ai(user)
	return TRUE
