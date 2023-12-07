/obj/machinery/power/supermatter_crystal/Initialize(mapload)
	. = ..()
	if(!isnull(check_holidays(FESTIVE_SEASON)) && istype(src, /obj/machinery/power/supermatter_crystal/engine))
		christmasify()

/obj/machinery/power/supermatter_crystal/proc/christmasify()
	name = "Xmasmatter crystal"
	desc += "\nApparently the safety guys signed off on this for some reason?"
	add_overlay(image('local/icons/obj/supermatter.dmi', "sm-overlay-christmas-lights"))
	RegisterSignal(src, COMSIG_ATOM_ATTACKBY, PROC_REF(christmasify_attackby))

/obj/machinery/power/supermatter_crystal/proc/christmasify_attackby(datum/source, obj/item/item, mob/living/user)
	SIGNAL_HANDLER
	if(istype(item, /obj/item/clothing/head/costume/santa) || istype(item, /obj/item/clothing/head/costume/skyrat/christmas))
		balloon_alert(user, "Placed hat.")
		QDEL_NULL(item)
		add_overlay(image('local/icons/obj/supermatter.dmi', "sm-overlay-christmas-hat"))
		desc += "\n\nThere's a Christmas hat placed atop it. How it got there and why it didn't dust yet is a mystery"
		update_overlays()
		return COMPONENT_CANCEL_ATTACK_CHAIN
	return FALSE
