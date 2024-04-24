/obj/item/clothing/sextoy/erp_leash
	name = "Leash"
	desc = "A guiding hand's best friend; in a sleek, semi-elastic package. Can either clip to a collar or be affixed to the neck on it's own."
	icon = 'local/icons/lewd/obj/lewd_clothing/lewd_belts.dmi'
	worn_icon = 'local/icons/lewd/mob/lewd_clothing/lewd_belts.dmi'
	icon_state = "neckleash_pink"
	equip_sound = 'sound/items/equip/toolbelt_equip.ogg'
	drop_sound = 'sound/items/handling/toolbelt_drop.ogg'
	slot_flags = ITEM_SLOT_BELT
	/// The sprites used in the radial menu when selecting a toy color
	var/static/list/leash_designs
	/// Bool of if the color's been changed or not before
	var/color_changed = FALSE
	/// The current color of the toy, affects sprite
	var/current_color = "pink"
	/// Leash visual for the beam
	var/datum/beam/leash/leash_beam

	/// Who's this attached to?
	var/mob/living/currently_leashed

/obj/item/clothing/sextoy/erp_leash/proc/populate_leash_designs()
	leash_designs = list(
		"pink" = image(icon = src.icon, icon_state = "neckleash_pink"),
		"teal" = image(icon = src.icon, icon_state = "neckleash_teal"),
		)

/obj/item/clothing/sextoy/erp_leash/AltClick(mob/user)
	if(!color_changed)
		var/choice = show_radial_menu(user, src, leash_designs, custom_check = CALLBACK(src, PROC_REF(check_menu), user), radius = 36, require_near = TRUE)
		if(!choice)
			return FALSE
		current_color = choice
		update_icon()
		color_changed = TRUE

/obj/item/clothing/sextoy/erp_leash/update_icon_state()
	. = ..()
	icon_state = "neckleash_[current_color]"
	inhand_icon_state = "neckleash_[current_color]"

/// HERE BE DRAGONS ///

/// Checks; leashing start
/obj/item/clothing/sextoy/erp_leash/attack(mob/living/carbon/human/to_be_leashed, mob/living/user, params)
	/// Are they already leashed by another leash? If so; don't go further.
	for(var/datum/component/leash/leash_component in to_be_leashed.GetComponents(/datum/component/leash))
		if(leash_component.owner != src)
			to_chat(user, span_danger("There's a leash attached to [to_be_leashed] already!"))
			return
	/// Do we have the target already leashed? If so; proceed to remove the leash.
	if(currently_leashed == to_be_leashed)
		remove_leash(currently_leashed)
	/// Check if we even CAN leash someone / if we already have someone leashed / if someone is leashing themselves. If so; prevent it.
	if(!istype(to_be_leashed) || currently_leashed != null || user == to_be_leashed)
		return
	/// Check their ERP prefs; if they don't allow sextoys: BTFO
	/*
	if(!to_be_leashed.check_erp_prefs(/datum/preference/toggle/erp/sex_toy, user, src))
		to_chat(user, span_danger("[to_be_leashed] doesn't want you to do that."))
		return
	*/ // SHOG DEBUG temp removal so I can test
	/// Actually start the leashing part here
	to_be_leashed.visible_message(span_warning("[user] raises the [src] to [to_be_leashed]'s neck!"),\
				span_userdanger("[user] starts to bring the [src] to your neck!"),\
				span_hear("You hear a light click as pressure builds in the air around your neck."))
	if(!do_after(user, 2 SECONDS, to_be_leashed))
		return
	currently_leashed = to_be_leashed
	create_leash(currently_leashed)
	currently_leashed.balloon_alert(user, "leashed")

/// Leash Initialization
/obj/item/clothing/sextoy/erp_leash/proc/create_leash(mob/ouppy)
	if(!istype(ouppy))
		return
	ouppy.AddComponent(/datum/component/leash, src, 1)
	/// Drawing it for the first time
	leash_beam = new(src.loc, ouppy, icon_state = "leash", icon = 'local/icons/lewd/effects/beam.dmi', emissive = FALSE)
	leash_beam.Start()

/// Leash Removal
/obj/item/clothing/sextoy/erp_leash/proc/remove_leash(mob/free_bird)
	if(!istype(free_bird))
		return
	for(var/datum/component/leash/leash_component in free_bird.GetComponents(/datum/component/leash))
		if(leash_component.owner == src) // We don't want to remove any other possible leash components.
			qdel(leash_component)
			QDEL_NULL(leash_beam)
		currently_leashed = null

/// Dropped it
/obj/item/clothing/sextoy/erp_leash/dropped(mob/user, silent)
	. = ..()
	remove_leash(currently_leashed)

/// Clean up when destroyed
/obj/item/clothing/sextoy/erp_leash/Destroy()
	remove_leash(currently_leashed)
	. = ..()


/*
* BEAM HANDLING
*/

/datum/beam/leash
	/// Is the leash held in left side hand?
	var/origin_lefthand = FALSE

	/// Origin Offsets
	var/origin_righthand_s_px = 13
	var/origin_righthand_s_py = 16

	var/origin_righthand_e_px = 18
	var/origin_righthand_e_py = 16

	var/origin_righthand_w_px = -20
	var/origin_righthand_w_py = 18

	var/origin_righthand_n_px = -14
	var/origin_righthand_n_py = 16

	var/origin_lefthand_s_px = -13
	var/origin_lefthand_s_py = 15

	var/origin_lefthand_e_px = 24
	var/origin_lefthand_e_py = 18

	var/origin_lefthand_w_px = -17
	var/origin_lefthand_w_py = 16

	var/origin_lefthand_n_px = 13
	var/origin_lefthand_n_py = 15

	/// Target Offsets
	var/target_s_px = 16
	var/target_s_py = 23

	var/target_e_px = 19
	var/target_e_py = 22

	var/target_w_px = 14
	var/target_w_py = 22

	var/target_n_px = 16
	var/target_n_py = 23

/datum/beam/leash/Start()
	update_origin_offsets(origin.dir)
	update_target_offsets(target.dir)
	. = ..()
	RegisterSignal(origin, COMSIG_ATOM_DIR_CHANGE, PROC_REF(handle_origin_dir_change))
	RegisterSignal(origin, COMSIG_ATOM_DIR_CHANGE, PROC_REF(handle_target_dir_change))

/datum/beam/leash/Destroy()
	UnregisterSignal(origin, COMSIG_ATOM_DIR_CHANGE)
	. = ..()

/datum/beam/leash/proc/handle_origin_dir_change(atom/movable/source, olddir, newdir)
	SIGNAL_HANDLER
	update_origin_offsets(newdir)
	INVOKE_ASYNC(src, TYPE_PROC_REF(/datum/beam/, redrawing))

/datum/beam/leash/proc/update_origin_offsets(user_dir)
	switch(user_dir)
		if(SOUTH)
			override_origin_pixel_x = origin_lefthand ? origin_lefthand_s_px : origin_righthand_s_px
			override_origin_pixel_y = origin_lefthand ? origin_lefthand_s_py : origin_righthand_s_py
		if(EAST)
			override_origin_pixel_x = origin_lefthand ? origin_lefthand_e_px : origin_righthand_e_px
			override_origin_pixel_y = origin_lefthand ? origin_lefthand_e_py : origin_righthand_e_py
		if(WEST)
			override_origin_pixel_x = origin_lefthand ? origin_lefthand_w_px : origin_righthand_w_px
			override_origin_pixel_y = origin_lefthand ? origin_lefthand_w_py : origin_righthand_w_py
		if(NORTH)
			override_origin_pixel_x = origin_lefthand ? origin_lefthand_n_px : origin_righthand_n_px
			override_origin_pixel_y = origin_lefthand ? origin_lefthand_n_py : origin_righthand_n_py

/datum/beam/leash/proc/handle_target_dir_change(atom/movable/source, olddir, newdir)
	SIGNAL_HANDLER
	update_target_offsets(newdir)
	INVOKE_ASYNC(src, TYPE_PROC_REF(/datum/beam/, redrawing))

/datum/beam/leash/proc/update_target_offsets(user_dir)
	switch(user_dir)
		if(SOUTH)
			override_target_pixel_x = target_s_px
			override_target_pixel_y = target_s_py
		if(EAST)
			override_target_pixel_x = target_e_px
			override_target_pixel_y = target_e_py
		if(WEST)
			override_target_pixel_x = target_w_px
			override_target_pixel_y = target_w_py
		if(NORTH)
			override_target_pixel_x = target_n_px
			override_target_pixel_y = target_n_py
