/obj/item/restraints/handcuffs/lewd
	name = "kinky handcuffs"
	desc = "Fake handcuffs meant for erotic roleplay."
	icon_state = "pinkcuffs"
	inhand_icon_state = "pinkcuffs"
	worn_icon = 'local/icons/lewd/mob/lewd_items/lewd_items.dmi'
	worn_icon_state = "pinkcuffs"
	icon = 'local/icons/lewd/obj/lewd_items/lewd_items.dmi'
	lefthand_file = 'local/icons/lewd/mob/lewd_inhands/lewd_inhand_left.dmi'
	righthand_file = 'local/icons/lewd/mob/lewd_inhands/lewd_inhand_right.dmi'
	breakouttime = 1 SECONDS

// Additionally, we will process the installation of the desired appearance, to bypass the bug in the general code
/obj/item/restraints/handcuffs/lewd/apply_cuffs(mob/living/carbon/target, mob/user, dispense = 0)
	. = ..()
	src.icon = 'local/icons/lewd/obj/lewd_items/lewd_items.dmi'
	src.icon_state = "pinkcuffs"
	src.worn_icon = 'local/icons/lewd/mob/lewd_items/lewd_items.dmi'
	src.worn_icon_state = "pinkcuffs"
	src.lefthand_file = 'local/icons/lewd/mob/lewd_inhands/lewd_inhand_left.dmi'
	src.righthand_file = 'local/icons/lewd/mob/lewd_inhands/lewd_inhand_right.dmi'

	// Similar code in general procedures does not correctly set the appearance
	target.remove_overlay(HANDCUFF_LAYER)
	if(!target.handcuffed)
		return
	target.overlays_standing[HANDCUFF_LAYER] = mutable_appearance('local/icons/lewd/mob/lewd_items/lewd_items.dmi', "pinkcuffs", -HANDCUFF_LAYER)
	target.apply_overlay(HANDCUFF_LAYER)
