/client/verb/webmap()
	set name = "webmap"
	set desc = "View WebMap"
	set category = "Game"
	set hidden = FALSE
	var/mapurl = null
	switch(SSmapping.config.map_name)
		if("TramStation")
			mapurl = "https://affectedarc07.github.io/SS13WebMap/Effigy/TramStation/"
		if("Sigma Octantis")
			mapurl = "https://affectedarc07.github.io/SS13WebMap/Effigy/SigmaOctantis/"
		if("FoxHoleStation")
			mapurl = "https://affectedarc07.github.io/SS13WebMap/Effigy/FoxHoleStation/"
		if("Ice Box Station")
			mapurl = "https://affectedarc07.github.io/SS13WebMap/Effigy/IceBoxStation/"
		if("MetaStation")
			mapurl = "https://affectedarc07.github.io/SS13WebMap/Effigy/MetaStation/"
		if("MiniStation")
			mapurl = "https://affectedarc07.github.io/SS13WebMap/Effigy/MiniStation/"
		if("NorthStar")
			mapurl = "https://affectedarc07.github.io/SS13WebMap/Effigy/NorthStar/"
		if("RimPoint")
			mapurl = "https://affectedarc07.github.io/SS13WebMap/Effigy/RimPoint/"
	if(mapurl)
		src << link(mapurl)
	else
		to_chat(usr, span_boldwarning("No WebMap Found!"), MESSAGE_TYPE_SYSTEM)
	return
