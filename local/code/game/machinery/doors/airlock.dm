/obj/machinery/door/airlock
	/// For those airlocks you might want to have varying "fillings" for, without having to
	/// have an icon file per door with a different filling.
	var/fill_state_suffix = null
	/// For the airlocks that use greyscale lights, set this to the color you want your lights to be.
	var/greyscale_lights_color = null
	doorOpen = 'local/sound/machines/airlockopen.ogg'
	doorClose = 'local/sound/machines/airlockclose.ogg'
	boltUp = 'local/sound/machines/bolts_up.ogg'
	boltDown = 'local/sound/machines/bolts_down.ogg'
	light_dir = NONE
	/// Use legacy airlock animation timings
	var/use_legacy_animations = FALSE
	/// Does this airlock emit a light?
	var/has_environment_lights = TRUE
	var/light_color_poweron = COLOR_STARLIGHT
	var/light_color_bolts = LIGHT_COLOR_INTENSE_RED
	var/light_color_emergency = LIGHT_COLOR_DIM_YELLOW
	var/light_color_engineering = LIGHT_COLOR_PINK
	var/light_color_permit = LIGHT_COLOR_ELECTRIC_CYAN
	var/light_color_deny = LIGHT_COLOR_INTENSE_RED
	var/light_color_warn = LIGHT_COLOR_PINK
	var/door_light_range = AIRLOCK_LIGHT_RANGE
	var/door_light_power = AIRLOCK_LIGHT_POWER
	///Is this door external? E.g. does it lead to space? Shuttle docking systems bolt doors with this flag.
	var/external = FALSE

/obj/machinery/door/airlock/external
	external = TRUE

/obj/machinery/door/airlock/shuttle
	external = TRUE

/obj/machinery/door/airlock/multi_tile
	has_environment_lights = FALSE

/obj/machinery/door/airlock/power_change()
	..()
	update_icon()

/obj/machinery/door/airlock/animation_length(animation)
	if(use_legacy_animations)
		return legacy_animation_length(animation)

	switch(animation)
		if(DOOR_OPENING_ANIMATION)
			return 1.3 SECONDS
		if(DOOR_CLOSING_ANIMATION)
			return 2.1 SECONDS

/obj/machinery/door/airlock/animation_segment_delay(animation)
	if(use_legacy_animations)
		return legacy_animation_segment_delay(animation)

	switch(animation)
		if(AIRLOCK_OPENING_TRANSPARENT)
			return 0.7 SECONDS
		if(AIRLOCK_OPENING_PASSABLE)
			return 0.7 SECONDS
		if(AIRLOCK_OPENING_FINISHED)
			return 1.3 SECONDS
		if(AIRLOCK_CLOSING_UNPASSABLE)
			return 1.2 SECONDS
		if(AIRLOCK_CLOSING_OPAQUE)
			return 1.5 SECONDS
		if(AIRLOCK_CLOSING_FINISHED)
			return 2.1 SECONDS

/obj/machinery/door/airlock/proc/legacy_animation_length(animation)
	switch(animation)
		if(DOOR_OPENING_ANIMATION)
			return 0.6 SECONDS
		if(DOOR_CLOSING_ANIMATION)
			return 2.0 SECONDS

/obj/machinery/door/airlock/proc/legacy_animation_segment_delay(animation)
	switch(animation)
		if(AIRLOCK_OPENING_TRANSPARENT)
			return 0.1 SECONDS
		if(AIRLOCK_OPENING_PASSABLE)
			return 0.4 SECONDS
		if(AIRLOCK_OPENING_FINISHED)
			return 0.6 SECONDS
		if(AIRLOCK_CLOSING_UNPASSABLE)
			return 0.2 SECONDS
		if(AIRLOCK_CLOSING_OPAQUE)
			return 0.6 SECONDS
		if(AIRLOCK_CLOSING_FINISHED)
			return 2.0 SECONDS

/obj/machinery/door/airlock/update_overlays()
	. = ..()
	var/frame_state
	var/light_state = AIRLOCK_LIGHT_POWERON
	var/pre_light_color
	switch(airlock_state)
		if(AIRLOCK_CLOSED)
			frame_state = AIRLOCK_FRAME_CLOSED
			if(locked)
				light_state = AIRLOCK_LIGHT_BOLTS
				pre_light_color = LIGHT_COLOR_INTENSE_RED
			else if(!normalspeed)
				light_state = AIRLOCK_LIGHT_ENGINEERING
				pre_light_color = LIGHT_COLOR_PINK
			else if(emergency)
				light_state = AIRLOCK_LIGHT_EMERGENCY
				pre_light_color = LIGHT_COLOR_ELECTRIC_CYAN
			else if(fire_active)
				light_state = AIRLOCK_LIGHT_FIRE
				pre_light_color = LIGHT_COLOR_DEFAULT
			else if(engineering_override)
				light_state = AIRLOCK_LIGHT_ENGINEERING
				pre_light_color = LIGHT_COLOR_PINK
			else
				pre_light_color = COLOR_STARLIGHT
		if(AIRLOCK_DENY)
			frame_state = AIRLOCK_FRAME_CLOSED
			light_state = AIRLOCK_LIGHT_DENIED
			pre_light_color = LIGHT_COLOR_INTENSE_RED
		if(AIRLOCK_EMAG)
			frame_state = AIRLOCK_FRAME_CLOSED
		if(AIRLOCK_CLOSING)
			frame_state = AIRLOCK_FRAME_CLOSING
			light_state = AIRLOCK_LIGHT_CLOSING
			pre_light_color = LIGHT_COLOR_PINK
		if(AIRLOCK_OPEN)
			frame_state = AIRLOCK_FRAME_OPEN
			if(locked)
				light_state = AIRLOCK_LIGHT_BOLTS
				pre_light_color = LIGHT_COLOR_INTENSE_RED
			else if(emergency)
				light_state = AIRLOCK_LIGHT_EMERGENCY
				pre_light_color = LIGHT_COLOR_ELECTRIC_CYAN
			else if(fire_active)
				light_state = AIRLOCK_LIGHT_FIRE
				pre_light_color = LIGHT_COLOR_DEFAULT
			else if(engineering_override)
				light_state = AIRLOCK_LIGHT_ENGINEERING
				pre_light_color = LIGHT_COLOR_PINK
			else
				pre_light_color = COLOR_STARLIGHT
			light_state += "_open"
		if(AIRLOCK_OPENING)
			frame_state = AIRLOCK_FRAME_OPENING
			light_state = AIRLOCK_LIGHT_OPENING
			pre_light_color = COLOR_CYAN_STARLIGHT

	. += get_airlock_overlay(frame_state, icon, src, em_block = TRUE)
	if(airlock_material)
		. += get_airlock_overlay("[airlock_material]_[frame_state]", overlays_file, src, em_block = TRUE)
	else
		. += get_airlock_overlay("fill_[frame_state + fill_state_suffix]", icon, src, em_block = TRUE)

	if(lights && hasPower() && has_environment_lights)
		. += get_airlock_overlay("lights_[light_state]", overlays_file, src, em_block = FALSE)
		. += emissive_appearance(overlays_file, "lights_[light_state]", src, alpha = src.alpha)

		if(multi_tile && filler)
			filler.set_light(l_range = AIRLOCK_LIGHT_RANGE, l_power = AIRLOCK_LIGHT_POWER, l_color = pre_light_color, l_on = TRUE)

		set_light(l_range = AIRLOCK_LIGHT_RANGE, l_power = AIRLOCK_LIGHT_POWER, l_color = pre_light_color, l_on = TRUE)
	else
		set_light(l_on = FALSE)

	if(panel_open)
		. += get_airlock_overlay("panel_[frame_state][security_level ? "_protected" : null]", overlays_file, src, em_block = TRUE)
	if(frame_state == AIRLOCK_FRAME_CLOSED && welded)
		. += get_airlock_overlay("welded", overlays_file, src, em_block = TRUE)

	if(airlock_state == AIRLOCK_EMAG)
		. += get_airlock_overlay("sparks", overlays_file, src, em_block = FALSE)

	if(hasPower())
		if(frame_state == AIRLOCK_FRAME_CLOSED)
			if(atom_integrity < integrity_failure * max_integrity)
				. += get_airlock_overlay("sparks_broken", overlays_file, src, em_block = FALSE)
			else if(atom_integrity < (0.75 * max_integrity))
				. += get_airlock_overlay("sparks_damaged", overlays_file, src, em_block = FALSE)
		else if(frame_state == AIRLOCK_FRAME_OPEN)
			if(atom_integrity < (0.75 * max_integrity))
				. += get_airlock_overlay("sparks_open", overlays_file, src, em_block = FALSE)

	if(note)
		. += get_airlock_overlay(get_note_state(frame_state), note_overlay_file, src, em_block = TRUE)

	if(frame_state == AIRLOCK_FRAME_CLOSED && seal)
		. += get_airlock_overlay("sealed", overlays_file, src, em_block = TRUE)

	if(hasPower() && unres_sides && frame_state == AIRLOCK_FRAME_CLOSED && light_state == AIRLOCK_LIGHT_POWERON)
		for(var/heading in list(NORTH,SOUTH,EAST,WEST))
			if(!(unres_sides & heading))
				continue
			. += mutable_appearance(overlays_file, "unres_[heading]")
			. += emissive_appearance(overlays_file, "unres_[heading]", src, alpha = src.alpha)

/obj/machinery/door/airlock/proc/on_entered(datum/source, atom/movable/crossed_atom)
	SIGNAL_HANDLER
	if(HAS_TRAIT(crossed_atom, TRAIT_OVERSIZED) && ishuman(crossed_atom))
		var/mob/living/carbon/human/crossing_human = crossed_atom
		if(crossing_human.move_intent != MOVE_INTENT_WALK && crossing_human.body_position == STANDING_UP)
			//We gonna bamf you, you tall fucker
			var/affecting = crossing_human.get_bodypart(BODY_ZONE_HEAD)
			crossing_human.apply_damage(15, BRUTE, affecting)
			crossing_human.Knockdown(20)
			crossing_human.visible_message(span_warning("[crossing_human] slams their head into the frame of [src] with a sickening thud!"), \
				span_userdanger("You slam your head against [src]!")
			)
			playsound(crossed_atom, 'sound/effects/bang.ogg', 50, TRUE)

/obj/machinery/door/airlock
	icon = 'local/icons/obj/doors/airlocks/effigy/effigy.dmi'
	overlays_file = 'local/icons/obj/doors/airlocks/effigy/overlays.dmi'
	greyscale_config = /datum/greyscale_config/airlock_effigy
	greyscale_colors = "#757278#757278"

/obj/machinery/door/airlock/atmos
	icon = 'local/icons/obj/doors/airlocks/effigy/effigy.dmi'
	overlays_file = 'local/icons/obj/doors/airlocks/effigy/overlays.dmi'
	greyscale_config = /datum/greyscale_config/airlock_effigy/atmos
	greyscale_colors = "#52b4e9#757278#7cb8dd"

/obj/machinery/door/airlock/command
	icon = 'local/icons/obj/doors/airlocks/effigy/effigy.dmi'
	overlays_file = 'local/icons/obj/doors/airlocks/effigy/overlays.dmi'
	greyscale_config = /datum/greyscale_config/airlock_effigy/command
	greyscale_colors = "#1987c2#4d4d4d#ffd66e"

/obj/machinery/door/airlock/engineering
	icon = 'local/icons/obj/doors/airlocks/effigy/effigy.dmi'
	overlays_file = 'local/icons/obj/doors/airlocks/effigy/overlays.dmi'
	greyscale_config = /datum/greyscale_config/airlock_effigy/engineering
	greyscale_colors = "#efb341#757278#e39825"

/obj/machinery/door/airlock/hydroponics
	icon = 'local/icons/obj/doors/airlocks/effigy/effigy.dmi'
	overlays_file = 'local/icons/obj/doors/airlocks/effigy/overlays.dmi'
	greyscale_config = /datum/greyscale_config/airlock_effigy
	greyscale_colors = "#46c26d#52b4e9"

/obj/machinery/door/airlock/maintenance
	icon = 'local/icons/obj/doors/airlocks/effigy/effigy.dmi'
	overlays_file = 'local/icons/obj/doors/airlocks/effigy/overlays.dmi'
	greyscale_config = /datum/greyscale_config/airlock_effigy
	greyscale_colors = "#D1D0D2#757278"

/obj/machinery/door/airlock/maintenance/external
	greyscale_colors = "#d65e2f#757278"

/obj/machinery/door/airlock/medical
	icon = 'local/icons/obj/doors/airlocks/effigy/effigy.dmi'
	overlays_file = 'local/icons/obj/doors/airlocks/effigy/overlays.dmi'
	greyscale_config = /datum/greyscale_config/airlock_effigy/medical
	greyscale_colors = "#52b4e9#eeeeff#eeeeff"

/obj/machinery/door/airlock/mining
	icon = 'local/icons/obj/doors/airlocks/effigy/effigy.dmi'
	overlays_file = 'local/icons/obj/doors/airlocks/effigy/overlays.dmi'
	greyscale_config = /datum/greyscale_config/airlock_effigy/cargo
	greyscale_colors = "#915416#757278#915416"

/obj/machinery/door/airlock/research
	icon = 'local/icons/obj/doors/airlocks/effigy/effigy.dmi'
	overlays_file = 'local/icons/obj/doors/airlocks/effigy/overlays.dmi'
	greyscale_config = /datum/greyscale_config/airlock_effigy/science
	greyscale_colors = "#be64ad#eeeeff#eeeeff"

/obj/machinery/door/airlock/science
	icon = 'local/icons/obj/doors/airlocks/effigy/effigy.dmi'
	overlays_file = 'local/icons/obj/doors/airlocks/effigy/overlays.dmi'
	greyscale_config = /datum/greyscale_config/airlock_effigy/science
	greyscale_colors = "#aa3ec3#eeeeff#eeeeff"

/obj/machinery/door/airlock/security
	icon = 'local/icons/obj/doors/airlocks/effigy/effigy.dmi'
	overlays_file = 'local/icons/obj/doors/airlocks/effigy/overlays.dmi'
	greyscale_config = /datum/greyscale_config/airlock_effigy/security
	greyscale_colors = "#cf3249#4d4d4d#ab293c"

/obj/machinery/door/airlock/virology
	icon = 'local/icons/obj/doors/airlocks/effigy/effigy.dmi'
	overlays_file = 'local/icons/obj/doors/airlocks/effigy/overlays.dmi'
	greyscale_config = /datum/greyscale_config/airlock_effigy/viro
	greyscale_colors = "#46c26d#eeeeff#eeeeff"

/obj/machinery/door/airlock/silver
	icon = 'local/icons/obj/doors/airlocks/effigy/effigy.dmi'
	overlays_file = 'local/icons/obj/doors/airlocks/effigy/overlays.dmi'
	greyscale_config = /datum/greyscale_config/airlock_effigy
	greyscale_colors = "#D1D0D2#D1D0D2"

/obj/machinery/door/airlock/public
	icon = 'local/icons/obj/doors/airlocks/effigy/effigy.dmi'
	overlays_file = 'local/icons/obj/doors/airlocks/effigy/overlays.dmi'
	greyscale_config = /datum/greyscale_config/airlock_effigy
	greyscale_colors = "#D1D0D2#D1D0D2"

/**
 * External
 */
/obj/machinery/door/airlock/external
	icon = 'local/icons/obj/doors/airlocks/external/external.dmi'
	overlays_file = 'local/icons/obj/doors/airlocks/external/overlays.dmi'
	greyscale_config = null
	greyscale_colors = null

/obj/machinery/door/airlock/external/animation_length(animation)
	switch(animation)
		if(DOOR_OPENING_ANIMATION)
			return 1.1 SECONDS
		if(DOOR_CLOSING_ANIMATION)
			return 2.0 SECONDS

/obj/machinery/door/airlock/external/animation_segment_delay(animation)
	switch(animation)
		if(AIRLOCK_OPENING_TRANSPARENT)
			return 0.7 SECONDS
		if(AIRLOCK_OPENING_PASSABLE)
			return 0.8 SECONDS
		if(AIRLOCK_OPENING_FINISHED)
			return 1.1 SECONDS
		if(AIRLOCK_CLOSING_UNPASSABLE)
			return 1.4 SECONDS
		if(AIRLOCK_CLOSING_OPAQUE)
			return 1.8 SECONDS
		if(AIRLOCK_CLOSING_FINISHED)
			return 2.0 SECONDS

/obj/machinery/door/airlock/vault
	icon = 'icons/obj/doors/airlocks/vault/vault.dmi'
	overlays_file = 'local/icons/obj/doors/airlocks/vault/overlays.dmi'
	greyscale_config = null
	greyscale_colors = null
	use_legacy_animations = TRUE

/obj/machinery/door/airlock/survival_pod
	icon = 'local/icons/obj/doors/airlocks/external/external.dmi'
	overlays_file = 'local/icons/obj/doors/airlocks/external/overlays.dmi'
	greyscale_config = null
	greyscale_colors = null

/obj/machinery/door/airlock/survival_pod/animation_length(animation)
	switch(animation)
		if(DOOR_OPENING_ANIMATION)
			return 1.1 SECONDS
		if(DOOR_CLOSING_ANIMATION)
			return 2.0 SECONDS

/obj/machinery/door/airlock/survival_pod/animation_segment_delay(animation)
	switch(animation)
		if(AIRLOCK_OPENING_TRANSPARENT)
			return 0.7 SECONDS
		if(AIRLOCK_OPENING_PASSABLE)
			return 0.8 SECONDS
		if(AIRLOCK_OPENING_FINISHED)
			return 1.1 SECONDS
		if(AIRLOCK_CLOSING_UNPASSABLE)
			return 1.4 SECONDS
		if(AIRLOCK_CLOSING_OPAQUE)
			return 1.8 SECONDS
		if(AIRLOCK_CLOSING_FINISHED)
			return 2.0 SECONDS

/**
 * Misc
 */

/obj/machinery/door/airlock/hatch
	icon = 'icons/obj/doors/airlocks/hatch/centcom.dmi'
	overlays_file = 'local/icons/obj/doors/airlocks/hatch/overlays.dmi'
	note_overlay_file = 'icons/obj/doors/airlocks/hatch/overlays.dmi'
	greyscale_config = null
	greyscale_colors = null
	use_legacy_animations = TRUE

/obj/machinery/door/airlock/maintenance_hatch
	icon = 'icons/obj/doors/airlocks/hatch/maintenance.dmi'
	overlays_file = 'local/icons/obj/doors/airlocks/hatch/overlays.dmi'
	greyscale_config = null
	greyscale_colors = null
	use_legacy_animations = TRUE

/obj/machinery/door/airlock/highsecurity
	icon = 'icons/obj/doors/airlocks/highsec/highsec.dmi'
	overlays_file = 'local/icons/obj/doors/airlocks/highsec/overlays.dmi'
	greyscale_config = null
	greyscale_colors = null
	use_legacy_animations = TRUE

/obj/machinery/door/airlock/shuttle
	icon = 'icons/obj/doors/airlocks/shuttle/shuttle.dmi'
	overlays_file = 'local/icons/obj/doors/airlocks/shuttle/overlays.dmi'
	greyscale_config = null
	greyscale_colors = null
	use_legacy_animations = TRUE

/obj/machinery/door/airlock/abductor
	icon = 'icons/obj/doors/airlocks/abductor/abductor_airlock.dmi'
	overlays_file = 'local/icons/obj/doors/airlocks/abductor/overlays.dmi'
	note_overlay_file = 'icons/obj/doors/airlocks/external/overlays.dmi'
	greyscale_config = null
	greyscale_colors = null
	use_legacy_animations = TRUE

/obj/machinery/door/airlock/cult
	name = "cult airlock"
	icon = 'icons/obj/doors/airlocks/cult/runed/cult.dmi'
	overlays_file = 'local/icons/obj/doors/airlocks/cult/runed/overlays.dmi'
	greyscale_config = null
	greyscale_colors = null
	use_legacy_animations = TRUE

/obj/machinery/door/airlock/cult/unruned
	icon = 'icons/obj/doors/airlocks/cult/unruned/cult.dmi'
	overlays_file = 'local/icons/obj/doors/airlocks/cult/unruned/overlays.dmi'

/obj/machinery/door/airlock/centcom
	icon = 'icons/obj/doors/airlocks/centcom/centcom.dmi'
	overlays_file = 'local/icons/obj/doors/airlocks/centcom/overlays.dmi'
	greyscale_config = null
	greyscale_colors = null
	use_legacy_animations = TRUE

/obj/machinery/door/airlock/grunge
	icon = 'icons/obj/doors/airlocks/centcom/centcom.dmi'
	overlays_file = 'local/icons/obj/doors/airlocks/centcom/overlays.dmi'
	greyscale_config = null
	greyscale_colors = null
	use_legacy_animations = TRUE

/**
 * Multi-tile
 */

/obj/machinery/door/airlock/multi_tile
	overlays_file = 'local/icons/obj/doors/airlocks/multi_tile/public/overlays.dmi'
	greyscale_config = null
	greyscale_colors = null
	use_legacy_animations = TRUE

/**
 * Tram
 */

/obj/machinery/door/airlock/tram
	icon = 'icons/obj/doors/airlocks/tram/tram.dmi'
	overlays_file = 'local/icons/obj/doors/airlocks/tram/tram-overlays.dmi'
	greyscale_config = null
	greyscale_colors = null

/obj/machinery/door/airlock/tram/set_light(l_range, l_power, l_color = NONSENSICAL_VALUE, l_angle, l_dir, l_height, l_on)
	return

/**
 * Mineral/Material
 */

/obj/machinery/door/airlock/material
	greyscale_config = /datum/greyscale_config/airlock_effigy/material
	greyscale_colors = "#757278"
	assemblytype = /obj/structure/door_assembly/door_assembly_material

/obj/machinery/door/airlock/gold
	icon = 'icons/obj/doors/airlocks/station/gold.dmi'
	overlays_file = 'local/icons/obj/doors/airlocks/station/overlays.dmi'
	greyscale_config = null
	greyscale_colors = null
	use_legacy_animations = TRUE

/obj/machinery/door/airlock/diamond
	icon = 'icons/obj/doors/airlocks/station/diamond.dmi'
	overlays_file = 'local/icons/obj/doors/airlocks/station/overlays.dmi'
	greyscale_config = null
	greyscale_colors = null
	use_legacy_animations = TRUE

/obj/machinery/door/airlock/uranium
	icon = 'icons/obj/doors/airlocks/station/uranium.dmi'
	overlays_file = 'local/icons/obj/doors/airlocks/station/overlays.dmi'
	greyscale_config = null
	greyscale_colors = null
	use_legacy_animations = TRUE

/obj/machinery/door/airlock/plasma
	icon = 'icons/obj/doors/airlocks/station/plasma.dmi'
	overlays_file = 'local/icons/obj/doors/airlocks/station/overlays.dmi'
	greyscale_config = null
	greyscale_colors = null
	use_legacy_animations = TRUE

/obj/machinery/door/airlock/bananium
	icon = 'icons/obj/doors/airlocks/station/bananium.dmi'
	overlays_file = 'local/icons/obj/doors/airlocks/station/overlays.dmi'
	doorOpen = 'sound/items/bikehorn.ogg'
	greyscale_config = null
	greyscale_colors = null
	use_legacy_animations = TRUE

/obj/machinery/door/airlock/sandstone
	icon = 'icons/obj/doors/airlocks/station/sandstone.dmi'
	overlays_file = 'local/icons/obj/doors/airlocks/station/overlays.dmi'
	greyscale_config = null
	greyscale_colors = null
	use_legacy_animations = TRUE

/obj/machinery/door/airlock/wood
	icon = 'icons/obj/doors/airlocks/station/wood.dmi'
	overlays_file = 'local/icons/obj/doors/airlocks/station/overlays.dmi'
	greyscale_config = null
	greyscale_colors = null
	use_legacy_animations = TRUE

/obj/machinery/door/airlock/titanium
	icon = 'icons/obj/doors/airlocks/shuttle/shuttle.dmi'
	overlays_file = 'local/icons/obj/doors/airlocks/shuttle/overlays.dmi'
	greyscale_config = null
	greyscale_colors = null
	use_legacy_animations = TRUE

/obj/machinery/door/airlock/bronze
	icon = 'icons/obj/doors/airlocks/clockwork/pinion_airlock.dmi'
	overlays_file = 'local/icons/obj/doors/airlocks/clockwork/overlays.dmi'
	greyscale_config = null
	greyscale_colors = null
	use_legacy_animations = TRUE

/**
 * Effigy
 */

/obj/machinery/door/airlock/service
	icon = 'local/icons/obj/doors/airlocks/effigy/effigy.dmi'
	overlays_file = 'local/icons/obj/doors/airlocks/effigy/overlays.dmi'
	greyscale_config = /datum/greyscale_config/airlock_effigy/service
	greyscale_colors = "#46c26d#4d4d4d#369655"

/obj/machinery/door/airlock/service/glass
	opacity = FALSE
	glass = TRUE

/obj/structure/door_assembly/door_assembly_svc
	name = "service airlock assembly"
	icon =  /obj/machinery/door/airlock/service::icon
	base_name = "service airlock"
	glass_type = /obj/machinery/door/airlock/service/glass
	airlock_type = /obj/machinery/door/airlock/service

/obj/machinery/door/airlock/service/studio
	icon = 'local/icons/obj/doors/airlocks/effigy/effigy.dmi'
	overlays_file = 'local/icons/obj/doors/airlocks/effigy/overlays.dmi'
	greyscale_config = /datum/greyscale_config/airlock_effigy/studio
	greyscale_colors = "#4d4d4d#D1D0D2#ffd66e"

/obj/machinery/door/airlock/service/studio/glass
	opacity = FALSE
	glass = TRUE

/obj/structure/door_assembly/door_assembly_sto
	name = "studio airlock assembly"
	icon =  /obj/machinery/door/airlock/service/studio::icon
	base_name = "service airlock"
	glass_type = /obj/machinery/door/airlock/service/studio/glass
	airlock_type = /obj/machinery/door/airlock/service/studio

/// Syndicate
/obj/machinery/door/airlock/syndicate
	icon = 'local/icons/obj/doors/airlocks/effigy/effigy.dmi'
	overlays_file = 'local/icons/obj/doors/airlocks/effigy/overlays.dmi'
	greyscale_config = /datum/greyscale_config/airlock_effigy
	greyscale_colors = "#950404#4d4d4d"

/obj/machinery/door/airlock/syndicate/glass
	opacity = FALSE
	glass = TRUE

/obj/structure/door_assembly/door_assembly_syn
	name = "syndicate airlock assembly"
	icon = 'local/icons/obj/doors/airlocks/effigy/effigy.dmi'
	greyscale_config = /obj/machinery/door/airlock/syndicate::greyscale_config
	greyscale_colors = /obj/machinery/door/airlock/syndicate::greyscale_colors
	base_name = "syndicate airlock"
	glass_type = /obj/machinery/door/airlock/syndicate/glass
	airlock_type = /obj/machinery/door/airlock/syndicate

/// Central Command
/obj/machinery/door/airlock/central_command
	icon = 'local/icons/obj/doors/airlocks/effigy/effigy.dmi'
	overlays_file = 'local/icons/obj/doors/airlocks/effigy/overlays.dmi'
	greyscale_config = /datum/greyscale_config/airlock_effigy
	greyscale_colors = "#449455#39393F"

/obj/machinery/door/airlock/central_command/glass
	opacity = FALSE
	glass = TRUE

/obj/structure/door_assembly/door_assembly_cce
	name = "central command airlock assembly"
	icon = 'local/icons/obj/doors/airlocks/effigy/effigy.dmi'
	greyscale_config = /obj/machinery/door/airlock/central_command::greyscale_config
	greyscale_colors = /obj/machinery/door/airlock/central_command::greyscale_colors
	base_name = "central command airlock"
	glass_type = /obj/machinery/door/airlock/central_command/glass
	airlock_type = /obj/machinery/door/airlock/central_command

// Variant that's indestructible and unhackable. Oorah.
/obj/machinery/door/airlock/central_command/indestructible_and_unhackable_not_fun_for_players_do_not_map_off_a_centcom_z_level // I'm sensing a pattern with this PR
	resistance_flags = INDESTRUCTIBLE | LAVA_PROOF | FIRE_PROOF | UNACIDABLE | ACID_PROOF
	damage_deflection = INFINITY
	integrity_failure = 0
	aiControlDisabled = AI_WIRE_DISABLED
	hackProof = TRUE
	normalspeed = FALSE
	move_resist = INFINITY

/obj/machinery/door/airlock/central_command/indestructible_and_unhackable_not_fun_for_players_do_not_map_off_a_centcom_z_level/screwdriver_act(mob/living/user, obj/item/tool)
	return ITEM_INTERACT_SKIP_TO_ATTACK // Prevents opening the panel. Admins can varedit panel_open to muck with the wires still; if they really want.

/**
 * Effigy Door Assemblies
 */

/obj/structure/door_assembly
	icon = 'local/icons/obj/doors/airlocks/station/generic.dmi'
	overlays_file = 'local/icons/obj/doors/airlocks/station/overlays.dmi'

/obj/structure/door_assembly/door_assembly_public
	icon = 'icons/obj/doors/airlocks/public/glass.dmi'
	overlays_file = 'local/icons/obj/doors/airlocks/station/overlays.dmi'

/obj/structure/door_assembly/door_assembly_com
	icon = 'local/icons/obj/doors/airlocks/station/com.dmi'

/obj/structure/door_assembly/door_assembly_sec
	icon = 'local/icons/obj/doors/airlocks/station/sec.dmi'

/obj/structure/door_assembly/door_assembly_eng
	icon = 'local/icons/obj/doors/airlocks/station/engi.dmi'

/obj/structure/door_assembly/door_assembly_min
	icon = 'local/icons/obj/doors/airlocks/station/cargo.dmi'

/obj/structure/door_assembly/door_assembly_atmo
	icon = 'local/icons/obj/doors/airlocks/station/atmos.dmi'

/obj/structure/door_assembly/door_assembly_research
	icon = 'local/icons/obj/doors/airlocks/station/rnd.dmi'

/obj/structure/door_assembly/door_assembly_science
	icon = 'local/icons/obj/doors/airlocks/station/sci.dmi'

/obj/structure/door_assembly/door_assembly_med
	icon = 'local/icons/obj/doors/airlocks/station/med.dmi'

/obj/structure/door_assembly/door_assembly_hydro
	icon = 'local/icons/obj/doors/airlocks/station/hydro.dmi'

/obj/structure/door_assembly/door_assembly_viro
	icon = 'local/icons/obj/doors/airlocks/station/viro.dmi'

/obj/structure/door_assembly/door_assembly_silver
	icon = 'local/icons/obj/doors/airlocks/station/silver.dmi'

/obj/structure/door_assembly/door_assembly_mai
	icon = 'local/icons/obj/doors/airlocks/station/maint-int.dmi'

/obj/structure/door_assembly/door_assembly_extmai
	icon = 'local/icons/obj/doors/airlocks/station/maint-ext.dmi'
