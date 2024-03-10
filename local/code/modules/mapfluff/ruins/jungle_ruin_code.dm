/// LUNA ///
// The sword itself
/obj/item/claymore/cutlass/luna
	name = "Luna"
	desc = "Forged by a madwoman, in recognition of a time, a place - she thought almost real. Various etchings of moons are inscribed onto the surface, different phases marking different parts of the blade."
	icon = 'local/icons/obj/weapons/sword.dmi'
	lefthand_file = 'local/icons/mob/inhands/weapons/swords_lefthand.dmi'
	righthand_file = 'local/icons/mob/inhands/weapons/swords_righthand.dmi'
	icon_state = "luna"
	inhand_icon_state = "luna"
	slot_flags = null // Let's not.
	w_class = WEIGHT_CLASS_HUGE // This is a SWORD, coward
	force = 15
	throwforce = 10
	bare_wound_bonus = 10
	var/list/fragments = list()
	var/can_bloodbeam

/obj/item/claymore/cutlass/luna/examine(mob/living/user)
	. = ..()
	. += span_notice("The design looks modular - it's possible you might be able to find additional pieces to attach.")
	for(var/f in fragments)
		var/obj/item/luna_fragment/fragment = f
		. += span_notice("\a [fragment] has been attached, allowing for Luna to [fragment.effect_desc]")

/obj/item/claymore/cutlass/luna/Destroy()
	QDEL_LIST(fragments)
	return ..()

/obj/item/claymore/cutlass/luna/Exited(atom/movable/gone, direction)
	. = ..()
	fragments -= gone

/obj/item/claymore/cutlass/luna/attackby(obj/item/I, mob/living/user)
	if(I.tool_behaviour == TOOL_CROWBAR)
		if(LAZYLEN(fragments))
			to_chat(user, span_notice("You remove [src]'s array of addons."))
			I.play_tool_sound(src)
			for(var/f in fragments)
				var/obj/item/luna_fragment/Fragment = f
				Fragment.remove_upgrade(src, user)
		else
			to_chat(user, span_warning("[src] is bare of any additional baubles."))
	else if(istype(I, /obj/item/luna_fragment))
		var/obj/item/luna_fragment/F = I
		F.apply_upgrade(src, user)
	else
		return ..()

/obj/item/claymore/cutlass/luna/attack_secondary(atom/target, mob/living/user, clickparams)
	return SECONDARY_ATTACK_CONTINUE_CHAIN

/obj/item/claymore/cutlass/luna/afterattack_secondary(atom/target, mob/living/user, proximity_flag, click_parameters)
	if(!can_bloodbeam)
		return
	if(target == user)
		balloon_alert(user, "can't aim at yourself!")
		return SECONDARY_ATTACK_CANCEL_ATTACK_CHAIN
	send_sword_laser(target, user, click_parameters)
	user.changeNext_move(CLICK_CD_MELEE)
	return SECONDARY_ATTACK_CANCEL_ATTACK_CHAIN

/obj/item/claymore/cutlass/luna/proc/send_sword_laser(atom/target, mob/living/user)
	var/turf/proj_turf = user.loc
	if(!isturf(proj_turf))
		return
	var/obj/projectile/beam/weak/penetrator/sord_beam = new(proj_turf)
	sord_beam.preparePixelProjectile(target, user)
	sord_beam.firer = user
	playsound(user, 'sound/weapons/resonator_blast.ogg', 90, TRUE)
	sord_beam.fire()
	user.apply_damage(25, STAMINA, BODY_ZONE_CHEST) // Spam these and pay the price of self-ownage
	user.blood_volume -= 10 // 560 is normal blood volume

/// Upgrades ///

/obj/item/luna_fragment
	name = "coder's bane"
	desc = "report this on github! unless you got this from a christmas present!"
	icon = 'icons/obj/mining_zones/artefacts.dmi'
	var/effect_desc = "Does literally nothing."
	var/has_spoken = FALSE
	var/hallucination_sound = 'sound/hallucinations/im_here1.ogg'
	var/hallucination_text = "Why.. do those stupid smelly nerds... not put an EXE file.. on the github..."

/obj/item/luna_fragment/proc/apply_upgrade(/obj/item/claymore/cutlass/luna/our_sord, mob/living/user)
	for(var/obj/item/luna_fragment/trophy as anything in our_sord.fragments)
		if(istype(src, trophy))
			to_chat(user, span_warning("You can't seem to attach [src] to [our_sord]."))
			return FALSE
	if(!user.transferItemToLoc(src, our_sord))
		return
	our_sord.fragments += src
	balloon_alert(user, "upgrade applied")
	to_chat(user, span_notice("You attach [src] to [our_sord]."))
	if(!has_spoken)
		var/mob/taylor = user
		taylor.playsound_local(src.loc, hallucination_sound, 30, FALSE, 3)
		to_chat(user, span_blue(hallucination_text))
	return

/obj/item/luna_fragment/proc/remove_upgrade(/obj/item/claymore/cutlass/luna/our_sord, mob/living/user)
	return

/// Blood Beam
/obj/item/luna_fragment/blood_beam
	name = "H.P.A."
	desc = "A \"hemophilic projectile apparatus\". In practice; it trades some of the electrical activity in the user's brain and some of their blood to fire off an armor-piercing laser. \
	Science CAN be metal!"
	icon_state = "tail_spike"
	effect_desc = "shoot a laser beam when right-clicking, in exchange for your stamina - and some blood."
	hallucination_text = "I remember it clearly. It was.. so white; where I was. So cold. Trees all around me."

/obj/item/luna_fragment/blood_beam/apply_upgrade(/obj/item/claymore/cutlass/luna/our_sord, mob/living/user)
	our_sord.can_bloodbeam = TRUE
	return ..()

/obj/item/luna_fragment/blood_beam/remove_upgrade(/obj/item/claymore/cutlass/luna/our_sord, mob/living/user)
	our_sord.can_bloodbeam = FALSE
	return ..()
