/obj/item/scrap/whoopie_cushion
	icon_state = "whoopie_cushion"
	name = "whoopie cushion"
	desc = "For an upstanding; gentlemanly humor."

/obj/item/scrap/whoopie_cushion/randomize_credit_cost()
	return rand(6, 36)

/obj/item/scrap/whoopie_cushion/proc/on_entered(datum/source, AM as mob|obj)
	SIGNAL_HANDLER
	if(isliving(AM))
		if(prob(1))
			playsound(src, 'sound/misc/scary_horn.ogg', 50)
		else
			playsound(src, 'sound/items/bikehorn.ogg', 50, TRUE)
