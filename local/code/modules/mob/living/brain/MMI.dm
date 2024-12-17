/obj/item/mmi/syndie/Initialize(mapload)
	. = ..()
	var/static/list/our_boys_in_red = list(/datum/antagonist/traitor, /datum/antagonist/nukeop)

	AddElement(/datum/element/unique_examine, \
		desc = "This MMI uploads a modified version of Asimov curated by The Syndicate. \
			Caution should be taken while using this device - although effective, the resulting unit is loyal \
			to The Syndicate as a whole rather than any specific cell, and may go against your directives.", \
		desc_requirement = EXAMINE_CHECK_ANTAG, \
		requirements = our_boys_in_red, \
		hint = FALSE) // hint would give it away
