/**********************Taeloth Areas**************************/

/area/taeloth
	name = "Taeloth"
	icon = 'icons/area/areas_station.dmi'
	icon_state = "explored"
	always_unpowered = TRUE
	power_environ = FALSE
	power_equip = FALSE
	power_light = FALSE
	requires_power = TRUE
	ambience_index = AMBIENCE_MINING
	has_gravity = STANDARD_GRAVITY
	flags_1 = NONE
	area_flags = VALID_TERRITORY | UNIQUE_AREA | FLORA_ALLOWED
	sound_environment = SOUND_AREA_TAELOTH
	ambience_index = AMBIENCE_HOLY
	outdoors = TRUE

/area/taeloth/underground
	name = "Taeloth Caves"

/area/taeloth/unexplored // In theory, monsters and ruins spawn here. They do not in practice, unimplemented. Random Generation works though.
	icon_state = "unexplored"
	area_flags = VALID_TERRITORY | UNIQUE_AREA | CAVES_ALLOWED | FLORA_ALLOWED | MOB_SPAWN_ALLOWED
	map_generator = /datum/map_generator/jungle_generator

/area/taeloth/unexplored/danger // Additional to said theory: megafauna.
	icon_state = "danger"
	area_flags = VALID_TERRITORY | UNIQUE_AREA | CAVES_ALLOWED | FLORA_ALLOWED | MOB_SPAWN_ALLOWED | MEGAFAUNA_SPAWN_ALLOWED
