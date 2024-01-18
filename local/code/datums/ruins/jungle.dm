// Hey! Listen! Update \config\jungleruinblacklist.txt with your new ruins!
// has_ceiling = TRUE for any ruin without any external tiles.
// If your ruin has external tiles, you can't have a ceiling atm. A mapping helper for this'll be in soon:tm:.

/// Surface ///
/datum/map_template/ruin/jungle
	ruin_type = ZTRAIT_JUNGLE_RUINS
	prefix = "_maps/RandomRuins/JungleRuins/"
	default_area = /area/taeloth/unexplored
	cost = 1
	allow_duplicates = FALSE

/datum/map_template/ruin/jungle/luna
	id = "surface_luna"
	suffix = "surface_luna.dmm"
	name = "LUNA"
	description = "The dream of a dead dreamer."

/datum/map_template/ruin/jungle/deadorgone
	id = "surface_deadorgone"
	suffix = "surface_deadorgone.dmm"
	name = "Dead Or Gone"
	description = "Everyone is dead or gone. The story is over."

/datum/map_template/ruin/jungle/trilogy
	id = "surface_trilogy"
	suffix = "surface_trilogy.dmm"
	name = "Trilogy"
	description = "They have to sell out at some point, right? If the sequel does well, raise them a third, make a box set... bam. Millions."

/datum/map_template/ruin/jungle/fountain
	name = "Fountain Hall"
	id = "jungle_fountain"
	description = "The fountain has a warning on the side. DANGER: May have undeclared side effects that only become obvious when implemented."
	prefix = "_maps/RandomRuins/AnywhereRuins/"
	suffix = "fountain_hall.dmm"

/// Caves ///

/datum/map_template/ruin/jungle_cave
	ruin_type = ZTRAIT_JUNGLE_CAVE_RUINS
	prefix = "_maps/RandomRuins/JungleRuins/"
	default_area = /area/taeloth/underground/unexplored
	cost = 1
	allow_duplicates = FALSE

/datum/map_template/ruin/jungle_cave/generator_right_here
	id = "caves_generator_right_here"
	suffix = "caves_generator_right_here.dmm"
	name = "Generator, Right Here!"
	description = "I knew transferring to power recovery was a fuckin' bad idea. I'm going back to scouting, on god!"

/datum/map_template/ruin/jungle_cave/hut
	id = "caves_hut"
	suffix = "caves_hut.dmm"
	name = "Underground Hut"
	description = "Maybe it'll have a neat trinket or accessory?"
