/obj/item/clothing/sextoy
	name = "sextoy"
	icon = 'packages/lewd/assets/obj/lewd_items/lewd_items.dmi'
	worn_icon = 'packages/lewd/assets/mob/lewd_items/lewd_items.dmi'
	equip_sound = 'packages/lewd/assets/sounds/bang1.ogg'
	drop_sound = 'packages/lewd/assets/sounds/bang2.ogg'
	pickup_sound =  'sound/items/handling/cloth_pickup.ogg'
	/// This is used to decide what lewd slot a toy should be able to be inserted into.
	/// The currently accepted defines are all prefixes with LEWD_SLOT_, and there is one for each lewd organ.
	/// See code/__DEFINES/_effigy/inventory.dm for the full list.
	var/lewd_slot_flags = NONE

/obj/item/clothing/sextoy/dropped(mob/user)
	..()

	update_appearance()
	if(!ishuman(loc))
		return

	var/mob/living/carbon/human/holder = loc
	holder.update_inv_lewd()
	holder.fan_hud_set_fandom()

/// A check to confirm if you can open the toy's color/design radial menu
/obj/item/clothing/sextoy/proc/check_menu(mob/living/user)
	if(!istype(user))
		return FALSE
	if(user.incapacitated())
		return FALSE
	return TRUE

/// Returns if the item is inside a lewd slot.
/obj/item/clothing/sextoy/proc/is_inside_lewd_slot(mob/living/carbon/human/target)
	return (src == target.penis || src == target.vagina || src == target.anus || src == target.nipples)
