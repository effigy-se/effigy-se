/obj/item/dogborg_tongue
	name = "synthetic tongue"
	desc = "Useful for slurping mess off the floor before affectionally licking the crew members in the face."
	icon = 'packages/borgs/assets/robot_items.dmi'
	icon_state = "synthtongue"
	hitsound = 'sound/effects/attackblob.ogg'
	desc = "For giving affectionate kisses."
	item_flags = NOBLUDGEON

/obj/item/dogborg_tongue/afterattack(atom/target, mob/user, proximity)
	. = ..()
	if(!proximity || !isliving(target))
		return
	var/mob/living/silicon/robot/borg = user
	var/mob/living/mob = target

	if(check_zone(borg.zone_selected) == "head")
		borg.visible_message(span_warning("\the [borg] affectionally licks \the [mob]'s face!"), span_notice("You affectionally lick \the [mob]'s face!"))
		playsound(borg, 'sound/effects/attackblob.ogg', 50, 1)
	else
		borg.visible_message(span_warning("\the [borg] affectionally licks \the [mob]!"), span_notice("You affectionally lick \the [mob]!"))
		playsound(borg, 'sound/effects/attackblob.ogg', 50, 1)

/obj/item/dogborg_nose
	name = "boop module"
	desc = "The BOOP module"
	icon = 'packages/borgs/assets/robot_items.dmi'
	icon_state = "nose"
	flags_1 = CONDUCT_1
	item_flags = NOBLUDGEON
	force = 0

/obj/item/dogborg_nose/afterattack(atom/target, mob/user, proximity)
	. = ..()
	if(!proximity)
		return
	do_attack_animation(target, null, src)
	user.visible_message(span_notice("[user] [pick("nuzzles", "pushes", "boops")] \the [target.name] with their nose!"))

/obj/item/crowbar/cyborg/power
	name = "modular crowbar"
	desc = "A cyborg fitted module resembling the jaws of life."
	icon = 'icons/obj/items_cyborg.dmi'
	icon_state = "jaws_pry_cyborg"
	usesound = 'sound/items/jaws_pry.ogg'
	force = 10
	toolspeed = 0.5

/obj/item/crowbar/cyborg/power/examine()
	. = ..()
	. += " It's fitted with a [tool_behaviour == TOOL_CROWBAR ? "prying" : "cutting"] head."

/obj/item/crowbar/cyborg/power/attack_self(mob/user)
	playsound(get_turf(user), 'sound/items/change_jaws.ogg', 50, TRUE)
	if(tool_behaviour == TOOL_CROWBAR)
		tool_behaviour = TOOL_WIRECUTTER
		to_chat(user, span_notice("You attach the cutting jaws to [src]."))
		icon_state = "jaws_cutter_cyborg"
		usesound = 'sound/items/jaws_cut.ogg'
	else
		tool_behaviour = TOOL_CROWBAR
		to_chat(user, span_notice("You attach the prying jaws to [src]."))
		icon_state = "jaws_pry_cyborg"
		usesound = 'sound/items/jaws_pry.ogg'

/obj/item/screwdriver/cyborg/power
	name =	"automated drill"
	desc = "A cyborg fitted module resembling the hand drill"
	icon = 'icons/obj/items_cyborg.dmi'
	icon_state = "drill_screw_cyborg"
	hitsound = 'sound/items/drill_hit.ogg'
	usesound = 'sound/items/drill_use.ogg'
	toolspeed = 0.5
	random_color = FALSE

/obj/item/screwdriver/cyborg/power/examine()
	. = ..()
	. += " It's fitted with a [tool_behaviour == TOOL_SCREWDRIVER ? "screw" : "bolt"] head."

/obj/item/screwdriver/cyborg/power/attack_self(mob/user)
	playsound(get_turf(user), 'sound/items/change_drill.ogg', 50, TRUE)
	if(tool_behaviour == TOOL_SCREWDRIVER)
		tool_behaviour = TOOL_WRENCH
		to_chat(user, span_notice("You attach the bolt bit to [src]."))
		icon_state = "drill_bolt_cyborg"
	else
		tool_behaviour = TOOL_SCREWDRIVER
		to_chat(user, span_notice("You attach the screw bit to [src]."))
		icon_state = "drill_screw_cyborg"
