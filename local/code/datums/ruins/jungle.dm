// Hey! Listen! Update \config\jungleruinblacklist.txt with your new ruins!
// has_ceiling = TRUE for any ruin without any external tiles.
// If your ruin has external tiles, you can't have a ceiling atm. A mapping helper for this'll be in soon:tm:.

/datum/map_template/ruin/jungle
	ruin_type = ZTRAIT_JUNGLE_RUINS
	prefix = "_maps/RandomRuins/JungleRuins/"
	default_area = /area/taeloth/unexplored
	cost = 1
	allow_duplicates = FALSE

/datum/map_template/ruin/jungle/luna
	id = "luna"
	suffix = "luna.dmm"
	name = "LUNA"
	description = "The dream of a dead dreamer."

/datum/map_template/ruin/jungle/deadorgone
	id = "deadorgone"
	suffix = "deadorgone.dmm"
	name = "Dead Or Gone"
	description = "Everyone is dead or gone. The story is over."

/datum/map_template/ruin/jungle/trilogy
	id = "trilogy"
	suffix = "trilogy.dmm"
	name = "Trilogy"
	description = "They have to sell out at some point, right? If the sequel does well, raise them a third, make a box set... bam. Millions."

/datum/map_template/ruin/jungle/fountain
	name = "Fountain Hall"
	id = "jungle_fountain"
	description = "The fountain has a warning on the side. DANGER: May have undeclared side effects that only become obvious when implemented."
	prefix = "_maps/RandomRuins/AnywhereRuins/"
	suffix = "fountain_hall.dmm"
