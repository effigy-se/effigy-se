/// ANY
/obj/effect/mapping_helpers/airlock/access/any/service/broadcast_centre/get_access()
	var/list/access_list = ..()
	access_list += ACCESS_BROADCAST_CENTRE
	return access_list

/// ALL
/obj/effect/mapping_helpers/airlock/access/all/service/broadcast_centre/get_access()
	var/list/access_list = ..()
	access_list += ACCESS_BROADCAST_CENTRE
	return access_list
