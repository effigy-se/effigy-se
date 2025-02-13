/datum/antagonist/slasher/sid
	name = "Sid"
	mob_type = /mob/living/basic/slasher/sid
	ui_name = "AntagInfoSid"
	fluff = "You yearn for the gift of cookies..."
	jumpscare_sound = 'local/code/modules/slashco13/sound/slasher/sid/kill.ogg'
	jumpscare_icon = 'local/code/modules/slashco13/icons/ui/jumpscares/sid.dmi'
	jumpscare_icon_state = "sid"

	var/datum/action/cooldown/toggle_sid_gun/crank_that

	/// How many bullets do we have to fire at people with? Increases per cookie eaten globally
	var/available_bullets = 0

	/// How many bullets do we have LEFT to fire at people with?
	var/in_clip = 0

	/// Can we toggle the gun freely?
	var/free_toggle = FALSE

	/// Hard reference to our ranged attack component; if we have it
	var/datum/component/ranged_attacks/sid/our_gun

/datum/antagonist/slasher/sid/give_slasher_abilities()
	. = ..()
	crank_that = new
	crank_that.Grant(owner.current)

/datum/antagonist/slasher/sid/map_specific_setup()
	for(var/integer=1 to 8)
		var/OurItem = pick(GLOB.slashitemstart)
		GLOB.slashitemstart -= OurItem
		new /obj/item/food/cookie(OurItem)

/datum/antagonist/slasher/sid/slasher_specific_jumpscare_effects(image/jumpscare, mob/living/target, mob/living/user)
	animate(jumpscare, jumpscare_time, color = COLOR_BLACK)
	return

/datum/action/cooldown/toggle_sid_gun
	name = "Toggle Gun"
	desc = "Take out - or put away - your gun; if eligible."
	background_icon = 'local/icons/mob/actions/backgrounds.dmi'
	background_icon_state = "bg_slasher"
	button_icon = 'local/icons/mob/actions/actions_slashers.dmi'
	button_icon_state = "toggle_gun"
	overlay_icon = 'local/icons/mob/actions/backgrounds.dmi'
	overlay_icon_state = "bg_slasher_border"
	cooldown_time = 5 SECONDS

/datum/action/cooldown/toggle_sid_gun/Activate(atom/target_atom)
	. = ..()
	for(var/datum/antagonist/slasher/sid/our_slasher in owner?.mind?.antag_datums)
		if(our_slasher.our_gun)
			end_shooties(our_slasher)
			return
		if(our_slasher.in_clip < 1 && !our_slasher.free_toggle)
			to_chat(owner, span_cult("You don't have enough bullets left to use this yet... perhaps look for another cookie?"))
			playsound(our_slasher, 'sound/hallucinations/im_here2.ogg', 75)
			return
		playsound(owner, 'local/code/modules/slashco13/sound/slasher/sid/draw.ogg', 75)
		our_slasher.our_gun = owner.AddComponent(/datum/component/ranged_attacks/sid, casing_type = /obj/item/ammo_casing/a50ae, projectile_sound = 'local/code/modules/slashco13/sound/slasher/sid/shot_closerange.ogg', cooldown_time = 3 SECONDS)
		owner.update_appearance()
		if(isliving(owner))
			var/mob/living/to_paralyze = owner
			to_paralyze.Paralyze(1 SECONDS, TRUE)
		playsound(owner, 'local/code/modules/slashco13/sound/slasher/sid/slideback.ogg', 75)

/datum/action/cooldown/toggle_sid_gun/proc/end_shooties(datum/antagonist/slasher/sid/our_slasher)
	playsound(owner, 'local/code/modules/slashco13/sound/slasher/sid/clipout.ogg', 75)
	QDEL_NULL(our_slasher.our_gun)
	to_chat(owner, span_cult("You stow your weapon."))
	playsound(owner, 'local/code/modules/slashco13/sound/slasher/sid/draw.ogg', 75)
	owner.update_appearance()
	if(isliving(owner))
		var/mob/living/to_paralyze = owner
		to_paralyze.Paralyze(2 SECONDS, TRUE)

/datum/component/ranged_attacks/sid/async_fire_ranged_attack(mob/living/basic/firer, atom/target, modifiers)
	for(var/datum/antagonist/slasher/sid/our_slasher in firer?.mind?.antag_datums)
		our_slasher?.when_shot()
	. = ..() // mfw early return

/datum/antagonist/slasher/sid/proc/when_shot()
	in_clip--
	if(in_clip < 1 && !free_toggle)
		crank_that.end_shooties(src)
	for(var/mob/dead_fuck in GLOB.player_list)
		if((is_station_level(dead_fuck.z) && is_station_level(owner.current.z)) || dead_fuck.z == owner.current.z)
			if(dead_fuck in range(SOUND_RANGE, owner.current))
				return // already heard the shot ring out; don't need to be here anymore
			if(dead_fuck in range((SOUND_RANGE * 2), owner.current))
				dead_fuck.playsound_local(turf_source = get_turf(owner.current), soundin = 'local/code/modules/slashco13/sound/slasher/sid/shot_mediumrange.ogg', vol = 100)
			/// Still not in radius; assume we should play the last variant
			dead_fuck.playsound_local(turf_source = get_turf(owner.current), soundin = 'local/code/modules/slashco13/sound/slasher/sid/shot_farthest.ogg', vol = 200)
