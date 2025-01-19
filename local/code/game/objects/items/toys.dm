/obj/item/toy/balloon/syndicate/Initialize(mapload)
	. = ..()

	AddElement(/datum/element/unique_examine, \
		desc = "While some might advise running around with this is a faux pas for mission integrity; REAL agents know the only \
		reward worth more than styling on the corporate drones is the embrace of victory. You also get on (the remains) of the \
		wall of fame; so who's REALLY the tactical genius?", \
		desc_requirement = EXAMINE_CHECK_ANTAG, \
		requirements = GLOB.examine_syndicate_antag_list)

/*
	Effigy Content Below
*/

/// Come on, I gotta do SOME stupid reference or else it isn't funny. Plus I need to make it for later.
/obj/item/toy/faustian_doll
	name = "doll"
	desc = "Typically speaking, toys don't have faustian, teleporting-for-lifeforce bargains built into them. \
	This one, however, does - and it's not quite clear how much life it thirsts for."
	icon = 'icons/obj/toys/toy.dmi'
	icon_state = "assistant"

/obj/item/toy/faustian_doll/Initialize(mapload)
	. = ..()
	AddElement(/datum/element/unique_examine, \
	desc = "Corporate's put out a brief dossier on 'remnants' of the old wartime occupation Taeloth fell under, this doll \
		being one of many the Power Recovery team ran into - and most likely, utilized. It has been determined, according to \
		them, to have an exact 50% mortality rate.", \
	desc_requirement = EXAMINE_CHECK_DEPARTMENT, \
	requirements = DEPARTMENT_SECURITY)

/obj/item/toy/faustian_doll/attack_self(mob/user as mob)
	var/turf/T = find_safe_turf(zlevels=SSmapping.levels_by_trait(ZTRAIT_STATION))

	playsound(src, 'sound/effects/screech.ogg', 70)
	if(T)
		var/atom/movable/AM = user.pulling
		if(AM)
			AM.forceMove(T)
		user.forceMove(T)
		if(AM)
			user.start_pulling(AM)
		to_chat(user, span_notice("You blink and find yourself in [get_area_name(T)]."))
	else
		to_chat(user, "Nothing happens. You feel that this is a bad sign.")
	if(istype(user, /mob/living))
		var/mob/living/guy_who_is_totally_screwed = user
		guy_who_is_totally_screwed.apply_damage(rand((guy_who_is_totally_screwed.health * 0.5),guy_who_is_totally_screwed.health))
	balloon_alert(user, "[src] crumbles!")
	qdel(src)


/obj/item/toy/tennis
	name = "tennis ball"
	desc = "A classical tennis ball. It appears to have faint bite marks scattered all over its surface."
	icon = 'local/icons/balls.dmi'
	icon_state = "tennis_classic"
	lefthand_file = 'local/icons/mob/inhands/balls_left.dmi'
	righthand_file = 'local/icons/mob/inhands/balls_right.dmi'
	inhand_icon_state = "tennis_classic"
	worn_icon = 'local/icons/mouthball.dmi'
	slot_flags = ITEM_SLOT_MASK
	throw_range = 14
	w_class = WEIGHT_CLASS_SMALL

/obj/item/toy/tennis/rainbow
	name = "pseudo-euclidean interdimensional tennis sphere"
	desc = "A tennis ball from another plane of existance. Really groovy."
	icon_state = "tennis_rainbow"
	inhand_icon_state = "tennis_rainbow"
	actions_types = list(/datum/action/item_action/squeeze)		//Giving the masses easy access to unlimited honks would be annoying

/obj/item/toy/tennis/rainbow/Initialize(mapload)
	. = ..()
	AddComponent(/datum/component/squeak)
	var/static/list/doggish_species = list(/datum/species/vulpkanin)

	var/static/list/dog_trait = list(TRAIT_CANINE)

	AddElement(/datum/element/unique_examine, \
		desc = "To want the ball; or to not want the ball. That is the question.", \
		desc_requirement = EXAMINE_CHECK_SPECIES, \
		requirements = doggish_species)

	AddElement(/datum/element/unique_examine, \
		desc = "Holy SHIT. [span_bold("Holy. SHIT.")]", \
		desc_requirement = EXAMINE_CHECK_TRAIT, \
		requirements = dog_trait, \
		hint = FALSE)

/obj/item/toy/tennis/red	//da red wuns go fasta
	name = "red tennis ball"
	desc = "A red tennis ball. It goes three times faster!"
	icon_state = "tennis_red"
	inhand_icon_state = "tennis_red"
	throw_speed = 9

/obj/item/toy/tennis/yellow	//because yellow is hot I guess
	name = "yellow tennis ball"
	desc = "A yellow tennis ball. It seems to have a flame-retardant coating."
	icon_state = "tennis_yellow"
	inhand_icon_state = "tennis_yellow"
	resistance_flags = FIRE_PROOF

/obj/item/toy/tennis/green	//pestilence
	name = "green tennis ball"
	desc = "A green tennis ball. It seems to have an impermeable coating."
	icon_state = "tennis_green"
	inhand_icon_state = "tennis_green"

/obj/item/toy/tennis/cyan	//electric
	name = "cyan tennis ball"
	desc = "A cyan tennis ball. It seems to have odd electrical properties."
	icon_state = "tennis_cyan"
	inhand_icon_state = "tennis_cyan"
	siemens_coefficient = 0.9

/obj/item/toy/tennis/blue	//reliability
	name = "blue tennis ball"
	desc = "A blue tennis ball. It seems ever so slightly more robust than normal."
	icon_state = "tennis_blue"
	inhand_icon_state = "tennis_blue"
	max_integrity = 300

/obj/item/toy/tennis/purple	//because purple dyes have high pH and would neutralize acids I guess
	name = "purple tennis ball"
	desc = "A purple tennis ball. It seems to have an acid-resistant coating."
	icon_state = "tennis_purple"
	inhand_icon_state = "tennis_purple"
	resistance_flags = ACID_PROOF

/datum/action/item_action/squeeze
	name = "Squeak!"
