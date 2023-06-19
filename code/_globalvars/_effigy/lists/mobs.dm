/proc/init_emote_list_se()
	//Scream types
	for(var/spath in subtypesof(/datum/scream_type))
		var/datum/scream_type/S = new spath()
		GLOB.scream_types[S.name] = spath
	sort_list(GLOB.scream_types, GLOBAL_PROC_REF(cmp_typepaths_asc))

	//Laugh types
	for(var/spath in subtypesof(/datum/laugh_type))
		var/datum/laugh_type/L = new spath()
		GLOB.laugh_types[L.name] = spath
	sort_list(GLOB.laugh_types, GLOBAL_PROC_REF(cmp_typepaths_asc))
