/mob/living/basic/slasher/sid
	name = "Sid"
	desc = "The Psychotic Slasher which keeps his rage in check with Cookies."
	icon_state = "sid"
	gender = MALE

/mob/living/basic/slasher/sid/Initialize(mapload)
	. = ..()
	AddElement(/datum/element/footstep, FOOTSTEP_SID)

/mob/living/basic/slasher/sid/update_overlays()
	. = ..()
	for(var/datum/antagonist/slasher/sid/our_slasher in mind?.antag_datums)
		if(our_slasher.our_gun)
			. += mutable_appearance('icons/mob/inhands/weapons/guns_righthand.dmi', "deagleg", alpha = src.alpha)

/mob/living/basic/slasher/sid/UnarmedAttack(atom/attack_target, proximity_flag, list/modifiers)
	. = ..()
	if(istype(attack_target, /obj/item/food/cookie))
		for(var/datum/antagonist/slasher/sid/our_slasher in mind?.antag_datums)
			visible_message(span_warning("[src] bites down on the [attack_target]; clearing it in one go!"), \
				span_warning("Your chomp on the [attack_target]; enjoying the treat!"), \
				span_warning("You hear something chomping down...")
			)
			var/sound_to_start_with = pick('local/code/modules/slashco13/sound/slasher/sid/cookie1.ogg', 'local/code/modules/slashco13/sound/slasher/sid/cookie2.ogg')
			playsound(src, sound_to_start_with, 75, FALSE)
			Paralyze(10 SECONDS, TRUE)
			addtimer(CALLBACK(src, PROC_REF(eat_that_thang_gurl), attack_target), 2 SECONDS)

/mob/living/basic/slasher/proc/eat_that_thang_gurl(atom/attack_target)
	new /obj/effect/decal/cleanable/generic(get_turf(attack_target))
	playsound(src, 'local/code/modules/slashco13/sound/slasher/sid/eating.ogg', 75, FALSE)
	qdel(attack_target)
	addtimer(CALLBACK(src, PROC_REF(be_sad_and_give_bullet)), 8 SECONDS)

/mob/living/basic/slasher/proc/be_sad_and_give_bullet()
	playsound(src, 'local/code/modules/slashco13/sound/slasher/sid/sad_1.ogg', 75, FALSE)
	for(var/datum/antagonist/slasher/sid/our_slasher in mind?.antag_datums)
		our_slasher.available_bullets++
		our_slasher.in_clip = our_slasher.available_bullets
		our_slasher.our_chase_attack.Remove(src) // he's sad now :(
		our_slasher.crank_that.Remove(src) // too sad to be american
		if(our_slasher.available_bullets >= 4)
			our_slasher.free_toggle = TRUE // hail to the king baby
		can_jumpscare = FALSE
		to_chat(src, span_warning("You feel malaise after completing your treat; and although you found a bullet in your haste... It'll still take you 20 seconds to get back to killing shape."))
		addtimer(CALLBACK(src, PROC_REF(give_jumpscare_and_chase_back), our_slasher), 20 SECONDS)

/mob/living/basic/slasher/proc/give_jumpscare_and_chase_back(datum/antagonist/slasher/sid/our_slasher)
	can_jumpscare = TRUE
	our_slasher.our_chase_attack.Grant(src)
	our_slasher.crank_that.Grant(src)
	to_chat(src, span_cult("You feel right as rain as the scent of another cookie hits your nostrils..."))
	playsound(our_slasher, 'sound/hallucinations/im_here2.ogg', 75)
