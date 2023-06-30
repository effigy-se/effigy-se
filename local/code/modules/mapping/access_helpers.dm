/// ANY
/obj/effect/mapping_helpers/airlock/access/any/service/studio/get_access()
	var/list/access_list = ..()
	access_list += ACCESS_STUDIO_CONTROL
	return access_list

/// ALL
/obj/effect/mapping_helpers/airlock/access/all/service/studio/get_access()
	var/list/access_list = ..()
	access_list += ACCESS_STUDIO_CONTROL
	return access_list
