/obj/item/mmi/syndie/Initialize(mapload)
	. = ..()

	AddElement(/datum/element/unique_examine, \
		desc = "This MMI uploads a modified version of Asimov curated by The Syndicate. \
			Caution should be taken while using this device - although effective, the resulting unit is loyal \
			to The Syndicate as a whole rather than any specific cell, and may go against your directives.", \
		desc_requirement = EXAMINE_CHECK_ANTAG, \
		requirements = GLOB.examine_syndicate_antag_list, \
		hint = FALSE) // hint would give it away
