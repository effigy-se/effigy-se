/obj/structure/sign/painting/dorm_private // The REAL exclusive stuff.
	name = "\improper Private Painting mounting"
	desc = "For art pieces that fit only in the fine walls of a home. Or a poor excuse for one."
	desc_with_canvas = "A painting probably taken off the wall with guests over."
	/// Future maintainability note: AI portrait pickers used to discriminate based on persistence_id but that was commented out. If that's re-implemented this may need checking.
	/// If you're coming here years in the future and this has been re-implemented before you even found out what SS13 was: lol
	persistence_id = "dorms_private"

/obj/structure/sign/painting/interlink // Stuff that's exclusive from the library painting pool, but still public.
	name = "\improper Interlink Painting mounting"
	desc = "For art pieces that're only a canvas apart from just being subway graffiti."
	desc_with_canvas = "A painting that somehow, someway, corporate has neglected to take down so far."
	persistence_id = "interlink"
