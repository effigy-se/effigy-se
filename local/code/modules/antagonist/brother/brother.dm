// Because Skyrat fundamentally changes how customization works, it borks the moth in the blood brother antag icon
// This is a replacement implementation that's more in line with how skyrat's customization works

/datum/antagonist/brother/get_preview_icon()
	var/mob/living/carbon/human/dummy/consistent/brother1 = new
	var/mob/living/carbon/human/dummy/consistent/brother2 = new

	brother1.dna.features["ethcolor"] = GLOB.color_list_ethereal["Faint Red"]
	brother1.set_species(/datum/species/ethereal)

	brother2.dna.mutant_bodyparts["wings"] = list(MUTANT_INDEX_NAME = "Moth (Plain)", MUTANT_INDEX_COLOR_LIST = list("#FFFFFF", "#FFFFFF", "#FFFFFF"), MUTANT_INDEX_EMISSIVE_LIST = list(FALSE, FALSE, FALSE))
	brother2.dna.mutant_bodyparts["moth_antennae"] = list(MUTANT_INDEX_NAME = "Plain", MUTANT_INDEX_COLOR_LIST = list("#FFFFFF", "#FFFFFF", "#FFFFFF"), MUTANT_INDEX_EMISSIVE_LIST = list(FALSE, FALSE, FALSE))
	brother2.dna.features["mcolor"] = COLOR_WHITE
	brother2.set_species(/datum/species/moth)

	// NASTY HACK INBOUND SINCE SKYRAT HANDLES MOTHS COMPLETELY
	// DIFFERENTLY AND WE WANT BACKWARDS COMPATIBILITY
	for(var/obj/item/bodypart/limb in brother2.bodyparts)
		limb.icon = 'icons/mob/human/species/moth/bodyparts.dmi'
		limb.icon_greyscale = 'icons/mob/human/species/moth/bodyparts.dmi'

	var/obj/item/bodypart/head/moth_head = brother2.get_bodypart(BODY_ZONE_HEAD)
	moth_head.is_dimorphic = FALSE

	brother2.regenerate_icons()
	// NASTY HACK HAS PASSED

	var/icon/brother1_icon = render_preview_outfit(/datum/outfit/job/quartermaster, brother1)
	brother1_icon.Blend(icon('icons/effects/blood.dmi', "maskblood"), ICON_OVERLAY)
	brother1_icon.Shift(WEST, 8)

	var/icon/brother2_icon = render_preview_outfit(/datum/outfit/job/scientist/consistent, brother2)
	brother2_icon.Blend(icon('icons/effects/blood.dmi', "uniformblood"), ICON_OVERLAY)
	brother2_icon.Shift(EAST, 8)

	var/icon/final_icon = brother1_icon
	final_icon.Blend(brother2_icon, ICON_OVERLAY)

	qdel(brother1)
	qdel(brother2)

	return finish_preview_icon(final_icon)
