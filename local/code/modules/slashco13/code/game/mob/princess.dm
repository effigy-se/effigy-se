/mob/living/basic/slasher/princess
	name = "Princess"
	desc = "Found near your newborn baby."
	icon_state = "princess"
	gender = FEMALE

/mob/living/basic/slasher/princess/Initialize(mapload)
	. = ..()
	AddElement(/datum/element/footstep, FOOTSTEP_PRINCESS)

/mob/living/basic/slasher/princess/UnarmedAttack(atom/attack_target, proximity_flag, list/modifiers)
	. = ..()
	if(istype(attack_target, /obj/item/toy/faustian_doll))
		for(var/datum/antagonist/slasher/princess/our_slasher in mind?.antag_datums)
			visible_message(span_warning("[src] bites down on the [attack_target]; shaking it's head violently as it tears it to shreds!"), \
				span_warning("Your bloodlust rises as you chomp down on the [attack_target]..."), \
				span_warning("You hear something chomping down on... plastic?")
			)
			our_slasher.aggression_prestige += 0.1
			our_slasher.aggression = 0
			our_slasher.maximum_aggression += rand(15,20)
			if(our_slasher.maximum_aggression > 100)
				our_slasher.maximum_aggression = 100
			playsound(src, 'local/code/modules/slashco13/sound/slasher/princess/maul.ogg', 75, FALSE)
			new /obj/effect/decal/cleanable/blood/old(get_turf(attack_target))
			qdel(attack_target)
			Paralyze(3 SECONDS, TRUE)
			break
