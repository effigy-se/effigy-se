#define SUPERMATTER_ICON_FILE 'local/icons/obj/machine/engine/supermatter.dmi'

/obj/machinery/power/supermatter_crystal
	/// If the SM is decorated with holiday lights
	var/holiday_lights = FALSE

/obj/machinery/power/supermatter_crystal/Initialize(mapload)
	. = ..()
	if(!isnull(check_holidays(FESTIVE_SEASON)))
		holiday_lights()

/obj/machinery/power/supermatter_crystal/update_overlays()
	. = ..()
	if(holiday_lights)
		. += mutable_appearance(SUPERMATTER_ICON_FILE, "holiday_lights")
		. += emissive_appearance(SUPERMATTER_ICON_FILE, "holiday_lights_e", src, alpha = src.alpha)
	return .

/obj/machinery/power/supermatter_crystal/proc/holiday_lights()
	holiday_lights = TRUE
	RegisterSignal(src, COMSIG_ATOM_ATTACKBY, PROC_REF(holiday_attackby))
	update_appearance()

/obj/machinery/power/supermatter_crystal/shard/holiday_lights()
	return

/// Consume the santa hat and add it as an overlay
/obj/machinery/power/supermatter_crystal/proc/holiday_attackby(datum/source, obj/item/item, mob/living/user)
	SIGNAL_HANDLER
	if(istype(item, /obj/item/clothing/head/costume/santa))
		QDEL_NULL(item)
		RegisterSignal(src, COMSIG_ATOM_EXAMINE, PROC_REF(holiday_hat_examine))
		add_overlay(mutable_appearance(icon, "santa_hat"))
		return COMPONENT_CANCEL_ATTACK_CHAIN
	return FALSE

/// Adds the hat flavor text when examined
/obj/machinery/power/supermatter_crystal/proc/holiday_hat_examine(atom/source, mob/user, list/examine_list)
	SIGNAL_HANDLER
	examine_list += span_info("There's a santa hat placed atop it. How it got there without being dusted is a mystery.")

#undef SUPERMATTER_ICON_FILE
