// 	Smoke particle effect for heavy-duty cyborgs
/datum/component/robot_smoke

/datum/component/robot_smoke/RegisterWithParent()
	add_verb(parent, /mob/living/silicon/robot/proc/toggle_smoke)
	RegisterSignal(parent, COMSIG_ATOM_DIR_CHANGE, PROC_REF(dir_change))

/datum/component/robot_smoke/UnregisterFromParent()
	remove_verb(parent, /mob/living/silicon/robot/proc/toggle_smoke)
	UnregisterSignal(parent, COMSIG_ATOM_DIR_CHANGE)

/datum/component/robot_smoke/Destroy()
	return ..()

/datum/component/robot_smoke/proc/dir_change(datum/source, olddir, newdir)
	SIGNAL_HANDLER

	var/atom/movable/movable_parent = parent

	if(!movable_parent.particles)
		return

	var/truedir = movable_parent.dir
	if(newdir && (truedir != newdir))
		truedir = newdir

	switch(truedir)
		if(NORTH)
			movable_parent.particles.position = list(-6, 12, 0)
			movable_parent.particles.drift = generator("vector", list(0, 0.4), list(0.2, -0.2))
		if(EAST)
			movable_parent.particles.position = list(-6, 12, 0)
			movable_parent.particles.drift = generator("vector", list(0, 0.4), list(-0.8, 0.2))
		if(SOUTH)
			movable_parent.particles.position = list(5, 12, 0)
			movable_parent.particles.drift = generator("vector", list(0, 0.4), list(0.2, -0.2))
		if(WEST)
			movable_parent.particles.position = list(6, 12, 0)
			movable_parent.particles.drift = generator("vector", list(0, 0.4), list(0.8, -0.2))


/mob/living/silicon/robot/proc/toggle_smoke()
	set name = "Toggle smoke"
	set category = "AI Commands"

	if(particles)
		dissipate()
	else if (!stat && !robot_resting)
		do_jitter_animation(10)
		playsound(src, 'local/sound/effects/robot_smoke.ogg', 50)
		particles = new /particles/smoke/robot()

/mob/living/silicon/robot/proc/dissipate()
	particles.spawning = 0
	addtimer(CALLBACK(src, PROC_REF(particles_qdel)), 1.5 SECONDS)

/mob/living/silicon/robot/proc/particles_qdel()
	QDEL_NULL(particles)

/mob/living/silicon/robot/death()
	. = ..()
	if(GetComponent(/datum/component/robot_smoke))
		dissipate()

/mob/living/silicon/robot/robot_lay_down()
	. = ..()

	if(GetComponent(/datum/component/robot_smoke))
		if(robot_resting)
			dissipate()
		else
			return

// The smoke
/particles/smoke/robot
	spawning = 0.4
	lifespan = 1 SECONDS
	fade = 0.75 SECONDS
	position = list(5, 12, 0)
	velocity = list(0, 0.2, 0)
	friction = 0.35
	scale = 0.5
	grow = 0.1
	spin = generator("num", -20, 20)

/mob/living/silicon/robot/Moved(atom/old_loc, movement_dir, forced, list/old_locs, momentum_change = TRUE)
	. = ..()
	if(robot_resting)
		robot_resting = FALSE
		on_standing_up()
		update_icons()

/mob/living/silicon/robot/toggle_resting()
	robot_lay_down()

/mob/living/silicon/robot/on_lying_down(new_lying_angle)
	if(layer == initial(layer)) //to avoid things like hiding larvas.
		layer = LYING_MOB_LAYER //so mob lying always appear behind standing mobs
	density = FALSE // We lose density and stop bumping passable dense things.

/mob/living/silicon/robot/on_standing_up()
	if(layer == LYING_MOB_LAYER)
		layer = initial(layer)
	density = initial(density) // We were prone before, so we become dense and things can bump into us again.

/mob/living/silicon/robot/proc/rest_style()
	set name = "Switch Rest Style"
	set category = "AI Commands"
	set desc = "Select your resting pose."
	if(!can_rest())
		to_chat(src, span_warning("You can't do that!"))
		return
	var/choice = tgui_alert(src, "Select resting pose", "", list("Resting", "Sitting", "Belly up"))
	switch(choice)
		if("Resting")
			robot_rest_style = ROBOT_REST_NORMAL
		if("Sitting")
			robot_rest_style = ROBOT_REST_SITTING
		if("Belly up")
			robot_rest_style = ROBOT_REST_BELLY_UP
	robot_resting = robot_rest_style
	if (robot_resting)
		on_lying_down()
	update_icons()

/mob/living/silicon/robot/proc/robot_lay_down()
	set name = "Lay down"
	set category = "AI Commands"
	if(!can_rest())
		to_chat(src, span_warning("You can't do that!"))
		return
	if(stat != CONSCIOUS) //Make sure we don't enable movement when not concious
		return
	if(robot_resting)
		to_chat(src, span_notice("You are now getting up."))
		robot_resting = FALSE
		mobility_flags = MOBILITY_FLAGS_DEFAULT
		on_standing_up()
	else
		to_chat(src, span_notice("You are now laying down."))
		robot_resting = robot_rest_style
		on_lying_down()
	update_icons()

/mob/living/silicon/robot/update_resting()
	. = ..()
	if(can_rest())
		robot_resting = FALSE
		update_icons()

/**
 * Safe check of the cyborg's model_features list.
 *
 */
/mob/living/silicon/robot/proc/can_rest()
	if(model && model.model_features && (R_TRAIT_WIDE in model.model_features))
		if(TRAIT_IMMOBILIZED in _status_traits)
			return FALSE
		return TRUE
	return FALSE
