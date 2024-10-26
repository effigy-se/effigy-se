/mob/living/basic/slasher/malezeroseven
	name = "Male_07"
	desc = "The Omniscient Slasher which can possess one of his many clones."
	icon_state = "malezeroseven"
	gender = MALE
	ai_controller = /datum/ai_controller/basic_controller/malezeroseven

/mob/living/basic/slasher/malezeroseven/Initialize(mapload)
	. = ..()
	AddElement(/datum/element/footstep, FOOTSTEP_MOB_SHOE)
	var/datum/action/cooldown/malezeroseven_to_ghost/to_ghost = new
	to_ghost.Grant(src)

/datum/ai_controller/basic_controller/malezeroseven
	ai_movement = /datum/ai_movement/jps
	idle_behavior = /datum/idle_behavior/idle_random_walk

/*
	ASCEND TO GHOSTHOOD
*/
/datum/action/cooldown/malezeroseven_to_ghost
	name = "Unpossess"
	desc = "Release this vessel."
	background_icon = 'local/icons/mob/actions/backgrounds.dmi'
	background_icon_state = "bg_slasher"
	button_icon = 'local/icons/mob/actions/actions_slashers.dmi'
	button_icon_state = "unpossess"
	overlay_icon = 'local/icons/mob/actions/backgrounds.dmi'
	overlay_icon_state = "bg_slasher_border"
	cooldown_time = 5 SECONDS

/datum/action/cooldown/malezeroseven_to_ghost/Activate(atom/target)
	. = ..()
	var/mob/dead/observer/spooky_mf = owner.ghostize(TRUE)
	playsound(owner, pick('local/code/modules/slashco13/sound/slasher/malezeroseven/unpossess1.ogg', 'local/code/modules/slashco13/sound/slasher/malezeroseven/unpossess2.ogg'), 75)
	spooky_mf.name = "Dark Spirit of L'az-lo" // the finest mind of his generation.. come to such an end
	spooky_mf.color = "red"
	var/datum/action/cooldown/ghost_to_malezeroseven/become_real_again = new
	become_real_again.Grant(spooky_mf)

/*
	POSSESS VESSEL
*/

/datum/action/cooldown/ghost_to_malezeroseven
	name = "Possess"
	desc = "Select a vessel via clicking on them; and you shall possess them immediately."
	background_icon = 'local/icons/mob/actions/backgrounds.dmi'
	background_icon_state = "bg_slasher"
	button_icon = 'local/icons/mob/actions/actions_slashers.dmi'
	button_icon_state = "possess"
	overlay_icon = 'local/icons/mob/actions/backgrounds.dmi'
	overlay_icon_state = "bg_slasher_border"
	cooldown_time = 5 SECONDS
	click_to_activate = TRUE

/datum/action/cooldown/ghost_to_malezeroseven/Activate(atom/target)
	. = ..()
	if(istype(target, /mob/living/basic/slasher/malezeroseven))
		var/mob/living/basic/slasher/malezeroseven/our_found_malezeroseven = target
		owner.mind.transfer_to(our_found_malezeroseven, TRUE)
		for(var/datum/antagonist/slasher/malezeroseven/our_found_antag_datum in owner.mind.antag_datums)
			// Move over antag stuff
			our_found_antag_datum.carpspawn_spell.Grant(our_found_malezeroseven)
			our_found_antag_datum.knock_spell.Grant(our_found_malezeroseven)
			our_found_antag_datum.our_chase_attack.Grant(our_found_malezeroseven)
		if(istype(owner, /mob/dead/observer))
			var/mob/dead/observer/ghostie = owner
			ghostie.reenter_corpse()
		playsound(our_found_malezeroseven, 'local/code/modules/slashco13/sound/slasher/malezeroseven/possess.ogg', 75)
		return
