
/mob/living/carbon
	var/next_stamina_message = 0

//Force mob to rest, does NOT do stamina damage.
//It's really not recommended to use this proc to give feedback, hence why silent is defaulting to true.
/mob/living/carbon/proc/KnockToFloor(silent = TRUE, ignore_canknockdown = FALSE, knockdown_amt = 1)
	if(!silent && body_position != LYING_DOWN)
		to_chat(src, span_warning("You are knocked to the floor!"))
	Knockdown(knockdown_amt, ignore_canknockdown)

/mob/living/proc/StaminaKnockdown(stamina_damage, disarm, brief_stun, hardstun, ignore_canknockdown = FALSE, paralyze_amount, knockdown_amt = 1)
	if(!stamina_damage)
		return
	return Paralyze((paralyze_amount ? paralyze_amount : stamina_damage))

/mob/living/carbon/StaminaKnockdown(stamina_damage, disarm, brief_stun, hardstun, ignore_canknockdown = FALSE, paralyze_amount, knockdown_amt = 1)
	if(!stamina_damage)
		return
	if(!ignore_canknockdown && !(status_flags & CANKNOCKDOWN))
		return FALSE
	if(istype(buckled, /obj/vehicle/ridden))
		buckled.unbuckle_mob(src)
	KnockToFloor(TRUE, ignore_canknockdown, knockdown_amt)
	adjustStaminaLoss(stamina_damage)
	if(disarm)
		drop_all_held_items()
	if(brief_stun)
		//Stun doesnt send a proper signal to stand up, so paralyze for now
		Paralyze(0.25 SECONDS)
	if(hardstun)
		Paralyze((paralyze_amount ? paralyze_amount : stamina_damage))

/mob/living/carbon/human/CtrlShiftClick(mob/user) //We have to remove the can_interact check from humans.
	SEND_SIGNAL(src, COMSIG_CLICK_CTRL_SHIFT, user)
	return

/// alt-clicking a human as another human while grappling them tightly makes you try for grappling-based maneuvers.
/mob/living/carbon/human/AltClick(mob/user)
	if(!ishuman(user))
		return ..()
	var/mob/living/carbon/human/human_user = user
	if(human_user == src || !human_user.combat_mode || !human_user.dna.species.try_grab_maneuver(user, src))
		return FALSE
	. = ..()
