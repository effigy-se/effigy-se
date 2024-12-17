/obj/effect/immovablerod/Initialize(mapload, atom/target_atom, atom/specific_target, force_looping)
	. = ..()
	var/static/list/there_is_no_fucking_way_you_see_this_without_delibrately_trying = list(/obj/item/skillchip/research_director)

	AddElement(/datum/element/unique_examine, \
		desc = "Quick, press R2 to parry!", \
		desc_requirement = EXAMINE_CHECK_SKILLCHIP, \
		requirements = there_is_no_fucking_way_you_see_this_without_delibrately_trying)
