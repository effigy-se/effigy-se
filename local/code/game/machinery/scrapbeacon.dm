#define SCRAPBEACON_DEBRIS_DAMAGE 25

/obj/machinery/scrap_beacon
	name = "scrap beacon"
	desc = "Electromagnetically pulls scrap and debris towards itself. Manually activated via a button inside the landing zone - dodging is half the fun!"
	icon = 'local/icons/obj/machines/scrap_beacon.dmi'
	icon_state = "beacon"
	anchored = TRUE
	density = TRUE
	layer = ABOVE_ALL_MOB_LAYER
	circuit = /obj/item/circuitboard/machine/scrap_beacon
	active_power_usage = BASE_MACHINE_ACTIVE_CONSUMPTION * 10 // 10kw
	// Are we currently pulling scrap in?
	var/active = FALSE
	// Our cooldown length - seperate from the actual cooldown
	var/preset_cooldown_length = 20 MINUTES
	// How likely is any given turf going to get scrap? In percentage
	var/impact_probability = 10
	// Our range
	var/impact_range = 3
	// What are we pulling in from space?
	var/scrap_path = /obj/structure/scrap

	COOLDOWN_DECLARE(active_cd)

/obj/machinery/scrap_beacon/examine(mob/user)
	. = ..()
	to_chat(user, span_warning("It has a [impact_range] tile range, and a [impact_probability]% chance of pulling in debris to any given tile."))

/obj/machinery/scrap_beacon/attackby(obj/item/weapon, mob/user, params)
	if(!active && default_deconstruction_screwdriver(user, icon_state, icon_state, weapon))
		return
	if(!active && default_deconstruction_crowbar(weapon))
		return
	return ..()

/obj/machinery/scrap_beacon/attack_ai(mob/user)
	return attack_hand(user)

/obj/machinery/scrap_beacon/attack_hand(mob/living/user, list/modifiers)
	. = ..()
	if(!COOLDOWN_FINISHED(src, active_cd))
		to_chat(user, span_notice("The [src]'s heat sinks are still dissipating the heat from its last use... It'll take around [DisplayTimeText(preset_cooldown_length)] to cool off fully."))
		return
	if(active)
		to_chat(user, span_warning("The [src] is already active!"))
		return
	playsound(loc, 'sound/machines/click.ogg', 15, TRUE, -3)
	log_game("[key_name(user)] has activated the [src].")
	start_scrap_summon()

/obj/machinery/scrap_beacon/proc/start_scrap_summon(mob/living/user)
	active = TRUE
	icon_state = "[initial(icon_state)]-on"
	audible_message(span_boldwarning("An alarm blares as the [src] turns on and begins pulling debris in!"))
	playsound(loc, "sound/misc/bloblarm.ogg", 100, 1)
	COOLDOWN_START(src, active_cd, preset_cooldown_length)
	var/list/flooring_near_beacon = list()
	for(var/turf/T in RANGE_TURFS(impact_range, src))
		if(locate(/obj/structure/scrap) in T || !prob(impact_probability))
			continue
		flooring_near_beacon += T
	flooring_near_beacon -= loc
	for(var/turf/newloc in flooring_near_beacon)
		podspawn(list( \
			"target" = get_turf(newloc), \
			"style" = STYLE_SEETHROUGH, \
			"spawn" = scrap_path, \
			"damage" = SCRAPBEACON_DEBRIS_DAMAGE, \
			"explosionSize" = list(0, 0, 0, 0), \
			"effectStun" = TRUE, \
			"effectStealth" = TRUE, \
			"effectLimb" = pick(TRUE, FALSE), \
			"effectMissile" = TRUE \
		))
		flooring_near_beacon -= newloc
	active = FALSE
	icon_state = initial(icon_state)

#undef SCRAPBEACON_DEBRIS_DAMAGE
