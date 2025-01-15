/obj/item/storage/fancy/cigarettes/cigpack_syndicate/Initialize(mapload)
	. = ..()

	AddElement(/datum/element/unique_examine, \
		desc = "Each cigarette in this box should contain 10u of Nicotine and 15u of Omnizine. Spacing them out apropriately should allow you \
		to heal up without any long-term side-effects.", \
		desc_requirement = EXAMINE_CHECK_ANTAG, \
		requirements = GLOB.examine_syndicate_antag_list)
