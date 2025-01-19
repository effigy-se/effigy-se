/obj/item/toy/cards/deck/syndicate/Initialize(mapload)
	. = ..()

	AddElement(/datum/element/unique_examine, \
		desc = "It took a crack-team of Interdyne's most dedicated - to anywhere but the dorms - researchers to develop these: playing cards \
		that sting just as bad as chucked floor-tiles. Why would someone opt for these over said floor; when it's more readily available? Simple: \
		because [span_bold("nothing ever happens,")] and they're all in.", \
		desc_requirement = EXAMINE_CHECK_ANTAG, \
		requirements = GLOB.examine_syndicate_antag_list) // reference to one of my favorite stupid images
