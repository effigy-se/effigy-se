/obj/item/storage/box/syndie_kit/Initialize(mapload)
	. = ..()
	AddElement(/datum/element/unique_examine, \
		desc = "For a series of terrorist cells and collapsed corporations; the Syndicate truly have mastered the art of making boxes look like \
		something only a gamer could love.", \
		desc_requirement = EXAMINE_CHECK_MINDSHIELD)
