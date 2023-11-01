/datum/hud/revenant
	ui_style = GENERAL_SCREEN_ICONS // EffigyEdit Change - Custom UI Styles

/datum/hud/revenant/New(mob/owner)
	..()

	pull_icon = new /atom/movable/screen/pull(null, src)
	pull_icon.icon = ui_style
	pull_icon.update_appearance()
	pull_icon.screen_loc = ui_living_pull
	static_inventory += pull_icon

	healths = new /atom/movable/screen/healths/revenant(null, src)
	infodisplay += healths
