/client/verb/webmap()
	set name = "View Webmap"
	set category = "OOC"
	set hidden = FALSE
	var/mapurl = null
	switch(SSmapping.config.map_name)
		if("TramStation")
			mapurl = "https://webmap.affectedarc07.co.uk/maps/effigy/tramstation/"
		if("Sigma Octantis")
			mapurl = "https://webmap.affectedarc07.co.uk/maps/effigy/sigmaoctantis/"
		if("FoxHoleStation")
			mapurl = "https://webmap.affectedarc07.co.uk/maps/effigy/foxholestation/"
		if("Ice Box Station")
			mapurl = "https://webmap.affectedarc07.co.uk/maps/effigy/icebox/"
		if("MetaStation")
			mapurl = "https://webmap.affectedarc07.co.uk/maps/effigy/metastation/"
		if("RimPoint")
			mapurl = "https://webmap.affectedarc07.co.uk/maps/effigy/rimpoint/"
	if(mapurl)
		src << link(mapurl)
	else
		to_chat(usr, span_boldwarning("No WebMap Found!"), MESSAGE_TYPE_SYSTEM)
	return
