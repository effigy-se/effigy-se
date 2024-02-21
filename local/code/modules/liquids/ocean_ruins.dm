// Hey! Listen! Update \config\oceanruinblacklist.txt with your new ruins!

/datum/map_template/ruin/ocean
	ruin_type = ZTRAIT_OCEAN_RUINS
	prefix = "_maps/RandomRuins/OceanRuins/"
	cost = 1

/datum/map_template/ruin/ocean/fissure
	name = "Thermal Fissure"
	id = "ocean-fissure"
	description = "A tear in the ocean."
	suffix = "ocean_fissure.dmm"

/datum/map_template/ruin/ocean/fissure/diag
	name = "Horizontal Thermal Fissure"
	id = "ocean-fissure-diag"
	description = "A horizontal tear in the ocean."
	suffix = "ocean_fissure_diag.dmm"

//Some copypastas ahead, but it's how our ruins spawning system works

/datum/map_template/ruin/trench
	ruin_type = ZTRAIT_TRENCH_RUINS
	prefix = "_maps/RandomRuins/OceanRuins/"

/datum/map_template/ruin/trench/biolab_research
	name = "Ocean Biolab Research Station"
	id = "ocean-biolab"
	description = "Biolab in the ocean."
	suffix = "ocean_bioweapon_lab.dmm"
	cost = 3
	allow_duplicates = FALSE

/datum/map_template/ruin/trench/fissure
	name = /datum/map_template/ruin/ocean/fissure::name
	id = /datum/map_template/ruin/ocean/fissure::id
	description = /datum/map_template/ruin/ocean/fissure::description
	suffix = /datum/map_template/ruin/ocean/fissure::suffix
	cost = /datum/map_template/ruin/ocean/fissure::cost

/datum/map_template/ruin/trench/fissure/diag
	name = /datum/map_template/ruin/ocean/fissure/diag::name
	id = /datum/map_template/ruin/ocean/fissure/diag::id
	description = /datum/map_template/ruin/ocean/fissure/diag::description
	suffix = /datum/map_template/ruin/ocean/fissure/diag::suffix
