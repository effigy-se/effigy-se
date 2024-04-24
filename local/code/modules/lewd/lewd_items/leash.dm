/obj/item/clothing/erp_leash
	name = "leash"
	desc = "A guiding hand's best friend; in a sleek, semi-elastic package. Can either clip to a collar or be affixed to the neck on it's own."
	icon = 'local/icons/lewd/obj/lewd_clothing/lewd_belts.dmi'
	worn_icon = 'local/icons/lewd/mob/lewd_clothing/lewd_belts.dmi'
	icon_state = "neckleash_pink"
	equip_sound = 'sound/items/equip/toolbelt_equip.ogg'
	drop_sound = 'sound/items/handling/toolbelt_drop.ogg'
	slot_flags = ITEM_SLOT_BELT
	/// Leash visual for the beam
	var/datum/beam/leash/leash_beam
	/// Who's this attached to?
	var/mob/living/currently_leashed

	unique_reskin = list(
		"Pink" = "neckleash_pink",
		"Teal" = "neckleash_teal"
	)

	COOLDOWN_DECLARE(tug_cd)

/// HERE BE DRAGONS ///

/// Checks; leashing start
/obj/item/clothing/erp_leash/attack(mob/living/carbon/human/to_be_leashed, mob/living/user, params)
	/// Are they already leashed by another leash? If so; don't go further.
	for(var/datum/component/leash/leash_component in to_be_leashed.GetComponents(/datum/component/leash))
		if(leash_component.owner != src)
			to_chat(user, span_danger("There's a leash attached to [to_be_leashed] already!"))
			return
	/// Do we have the target already leashed? If so; proceed to remove the leash.
	if(to_be_leashed == currently_leashed)
		remove_leash(currently_leashed)
		balloon_alert(user, "unhooked")
		return
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

/obj/item/clothing/erp_leash/attack_self(mob/user, modifiers)
	. = ..()
	if(!COOLDOWN_FINISHED(src, tug_cd))
		return
	if(currently_leashed && istype(currently_leashed, /mob/living))
		var/mob/living/yoinked
		yoinked.Move(get_step_towards(yoinked,user))
		yoinked.adjustStaminaLoss(10)
		yoinked.visible_message(span_warning("[yoinked] is pulled in as [user] tugs the [src]!"),\
				span_userdanger("[user] suddenly tugs the [src], pulling you closer!"),\
				span_userdanger("A sudden tug against your neck pulls you ahead!"))
	COOLDOWN_START(src, tug_cd, 1 SECONDS)

/// Leash Initialization
/obj/item/clothing/erp_leash/proc/create_leash(mob/ouppy)
	if(!istype(ouppy))
		return
	ouppy.AddComponent(/datum/component/leash, src, 2)
	/// Drawing it for the first time
	leash_beam = new(src.loc, ouppy, icon_state = "leash", icon = 'local/icons/lewd/effects/beam.dmi', emissive = FALSE)
	if(istype(src.loc, /mob/living/carbon))
		var/mob/living/carbon/user = src.loc
		leash_beam.origin_lefthand = user.get_held_index_of_item(src) % 2 == 1
	leash_beam.Start()
	RegisterSignal(ouppy, COMSIG_MOVABLE_Z_CHANGED, PROC_REF(handle_leash_zlevel_change))
	RegisterSignal(src.loc, COMSIG_MOVABLE_Z_CHANGED, PROC_REF(handle_leash_zlevel_change))

/// Have we moved z-levels at any point? If so; remake the beam
/obj/item/clothing/erp_leash/proc/handle_leash_zlevel_change(mob/user, mob/target)
	SIGNAL_HANDLER

	if(!istype(user) || !istype(target))
		return
	if(user.z == target.z && leash_beam == null)
		leash_beam = new(user, target, icon_state = "leash", icon = 'local/icons/lewd/effects/beam.dmi', emissive = FALSE)
		leash_beam.origin_lefthand = user.get_held_index_of_item(src) % 2 == 1

/// Leash Removal
/obj/item/clothing/erp_leash/proc/remove_leash(mob/free_bird)
	if(!istype(free_bird))
		return
	for(var/datum/component/leash/leash_component in free_bird.GetComponents(/datum/component/leash))
		if(leash_component.owner == src) // We don't want to remove any other possible leash components.
			qdel(leash_component)
			QDEL_NULL(leash_beam)
		currently_leashed = null

/// Dropped it
/obj/item/clothing/erp_leash/dropped(mob/user, silent)
	. = ..()
	UnregisterSignal(currently_leashed, COMSIG_MOVABLE_Z_CHANGED)
	UnregisterSignal(user, COMSIG_MOVABLE_Z_CHANGED)
	remove_leash(currently_leashed)

/// Clean up when destroyed
/obj/item/clothing/erp_leash/Destroy()
	if(istype(src.loc, /mob))
		UnregisterSignal(src.loc, COMSIG_MOVABLE_Z_CHANGED)
	UnregisterSignal(currently_leashed, COMSIG_MOVABLE_Z_CHANGED)
	remove_leash(currently_leashed)
	. = ..()


/*
* BEAM HANDLING
*/

/datum/beam/leash
	/// Is the leash held in left side hand?
	/// shog todo: god this is the worst; FIX THIS PART IT NEEDS TO KNOW IF It'S THE LEFT HAND AAAAAAAA
	var/origin_lefthand = FALSE

	/// Origin Offsets
	var/origin_righthand_s_px = -5
	var/origin_righthand_s_py = -4

	var/origin_righthand_e_px = -1
	var/origin_righthand_e_py = -3

	var/origin_righthand_w_px = -4
	var/origin_righthand_w_py = -3

	var/origin_righthand_n_px = 5
	var/origin_righthand_n_py = -4

	var/origin_lefthand_s_px = 5
	var/origin_lefthand_s_py = -4

	var/origin_lefthand_e_px = 4
	var/origin_lefthand_e_py = -3

	var/origin_lefthand_w_px = -1
	var/origin_lefthand_w_py = -3

	var/origin_lefthand_n_px = -5
	var/origin_lefthand_n_py = -4

	/// Target Offsets
	var/target_s_px = 0
	var/target_s_py = 6

	var/target_e_px = 2
	var/target_e_py = 5

	var/target_w_px = -2
	var/target_w_py = 5

	var/target_n_px = 0
	var/target_n_py = 6

/datum/beam/leash/Start()
	update_origin_offsets(origin.dir)
	update_target_offsets(target.dir)
	. = ..()
	RegisterSignal(origin, COMSIG_ATOM_DIR_CHANGE, PROC_REF(handle_origin_dir_change))
	RegisterSignal(target, COMSIG_ATOM_DIR_CHANGE, PROC_REF(handle_target_dir_change))

/datum/beam/leash/Destroy()
	UnregisterSignal(origin, COMSIG_ATOM_DIR_CHANGE)
	UnregisterSignal(target, COMSIG_ATOM_DIR_CHANGE)
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

/datum/beam/leash/proc/update_target_offsets(target_dir)
	switch(target_dir)
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
