/obj/item/reagent_containers/cup/bucket/attackby(obj/O, mob/living/user, params)
	if(istype(O, /obj/item/mop))
		var/is_right_clicking = LAZYACCESS(params2list(params), RIGHT_CLICK)
		if(is_right_clicking)
			if(O.reagents.total_volume == 0)
				to_chat(user, "<span class='warning'>[O] is dry, you can't squeeze anything out!</span>")
				return
			if(reagents.total_volume == reagents.maximum_volume)
				to_chat(user, "<span class='warning'>[src] is full!</span>")
				return
			O.reagents.remove_any(O.reagents.total_volume * SQUEEZING_DISPERSAL_RATIO)
			O.reagents.trans_to(src, O.reagents.total_volume, transferred_by = user)
			to_chat(user, "<span class='notice'>You squeeze the liquids from [O] to [src].</span>")
		else
			if(reagents.total_volume < 1)
				to_chat(user, "<span class='warning'>[src] is out of water!</span>")
			else
				reagents.trans_to(O, 5, transferred_by = user)
				to_chat(user, "<span class='notice'>You wet [O] in [src].</span>")
				playsound(loc, 'sound/effects/slosh.ogg', 25, TRUE)
	else if(isprox(O)) //This works with wooden buckets for now. Somewhat unintended, but maybe someone will add sprites for it soon(TM)
		to_chat(user, span_notice("You add [O] to [src]."))
		qdel(O)
		var/obj/item/bot_assembly/cleanbot/new_cleanbot_ass = new(null, src)
		user.put_in_hands(new_cleanbot_ass)
		return
