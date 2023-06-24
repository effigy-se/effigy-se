/client/verb/webmap()
	set name = "webmap"
	set desc = "View WebMap"
	set category = "Game"
	set hidden = FALSE
	var/mapurl = "https://affectedarc07.github.io/SS13WebMap/Effigy/[SSmapping.config.map_name]/"
	if(tgui_alert(src, "This will open the SS13 WebMap in your browser. Are you sure?",, list("Yes","No"))!="Yes")
		return
	src << link(mapurl)
	return
