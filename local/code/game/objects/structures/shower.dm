/obj/machinery/shower/plunger_act(obj/item/plunger/P, mob/living/user, reinforced)
	if(do_after(user, 3 SECONDS, src))
		reagents.remove_any(reagents.total_volume)
		balloon_alert(user, "reservoir emptied")
