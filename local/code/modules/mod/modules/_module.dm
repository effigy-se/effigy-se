/obj/item/mod/module
	/// The suit's supports_variations_flags, currently only for the chestplate and the helmet parts of the MODsuit.
	var/suit_supports_variations_flags = NONE
	/// Does this module have a separate head sprite? Useful for muzzled sprites
	var/has_head_sprite = FALSE
	/// Is the module's visuals head-only when active? Useful for visors and such, to avoid multiplying the amount of overlay with empty images
	var/head_only_when_active = FALSE
	/// Is the module's visuals head-only when inactive? Useful for visors and such, to avoid multiplying the amount of overlay with empty images
	var/head_only_when_inactive = FALSE


/**
 * Proc that handles the mutable_appearances of the module on the MODsuits
 *
 * Arguments:
 * * standing - The mutable_appearance we're taking as a reference for this one, mainly to use its layer.
 * * module_icon_state - The name of the icon_state we'll be using for the module on the MODsuit.
 */
/obj/item/mod/module/proc/handle_module_icon(mutable_appearance/standing, module_icon_state)
	. = list()
	var/is_old_vox = FALSE
	if(mod.wearer)
		if(mod.chestplate && (mod.chestplate.supports_variations_flags & CLOTHING_DIGITIGRADE_VARIATION) && (mod.wearer.bodytype & BODYTYPE_DIGITIGRADE))
			suit_supports_variations_flags |= CLOTHING_DIGITIGRADE_VARIATION

		if(mod.helmet && (mod.helmet.supports_variations_flags & CLOTHING_SNOUTED_VARIATION) && mod.wearer.bodytype & BODYTYPE_SNOUTED)
			suit_supports_variations_flags |= CLOTHING_SNOUTED_VARIATION
		is_old_vox = isvox(mod.wearer)

	var/icon_to_use = 'icons/mob/clothing/modsuit/mod_modules.dmi'
	var/icon_state_to_use = module_icon_state
//	if(is_new_vox || is_old_vox)
//		if(is_new_vox)
//			icon_to_use = worn_icon_better_vox
	if(is_old_vox)
		icon_to_use = worn_icon_vox

	if(suit_supports_variations_flags && (supports_variations_flags & CLOTHING_DIGITIGRADE_VARIATION))
		icon_to_use = 'packages/customization/assets/mob/mod.dmi'
		icon_state_to_use = "[module_icon_state]_digi"

	var/add_overlay = TRUE
	if(has_head_sprite && ((active && head_only_when_active) || (!active && head_only_when_inactive)))
		add_overlay = FALSE

	if(add_overlay)
		icon_to_use = overlay_icon_file
		var/mutable_appearance/module_icon = mutable_appearance(icon_to_use, icon_state_to_use, layer = standing.layer + 0.1) // Just changed the raw icon path to icon_to_use and the used_overlay to icon_state_to_use
		module_icon.appearance_flags |= RESET_COLOR
		. += module_icon

	if(has_head_sprite)
		icon_to_use = 'packages/customization/assets/mob/mod.dmi'
		icon_state_to_use = "[module_icon_state]_head"

		if(suit_supports_variations_flags && (supports_variations_flags & CLOTHING_SNOUTED_VARIATION))
			icon_state_to_use = "[icon_state_to_use]_muzzled"

		var/mutable_appearance/additional_module_icon = mutable_appearance(icon_to_use, icon_state_to_use, layer = standing.layer + 0.1)
		additional_module_icon.appearance_flags |= RESET_COLOR
		. += additional_module_icon
