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
	has_gravity = STANDARD_GRAVITY
	flags_1 = NONE
	area_flags = VALID_TERRITORY | UNIQUE_AREA | FLORA_ALLOWED
	sound_environment = SOUND_AREA_TAELOTH
	ambience_index = AMBIENCE_HOLY
	outdoors = TRUE

/area/taeloth/Initialize(mapload)
	try_lighting()
	return ..()

/area/taeloth/proc/try_lighting()
	if(HAS_TRAIT(SSstation, STATION_TRAIT_BRIGHT_DAY))
		base_lighting_alpha = 125 // With all that canopy in the way and no snow to amplify, things are a smidge darker than Icebox.

/*
	SURFACE FEATURES
*/

/area/taeloth/hotspring
	name = "Taeloth - Hotspring"
	ambientsounds = list('local/sound/ambience/ambihotspring.ogg')
	mood_bonus = 10
	mood_message = "I feel relaxed and refreshed!"

/area/taeloth/ocean
	name = "Taeloth - Ocean"

/*
	STATION CHUNKS
*/

/// 'nearstation' sections mimic how hallways work on a traditional ss13 map; so blob is allowed to both move through it and place here freely. not sure why you would; but still
/// likewise cult can also build/rune here. again - probably not smart as a cultie; but you can. There are some exceptions to areas we want to name but don't want either on; too.
/// For those; see /area/taeloth/nearstation/no_valids_to_hunt
/area/taeloth/nearstation
	area_flags = VALID_TERRITORY | BLOBS_ALLOWED | UNIQUE_AREA | FLORA_ALLOWED | CULT_PERMITTED

/// AI
/area/taeloth/nearstation/ai_sat_trail
	name = "AI Satellite Trail"
	icon_state = "ai_foyer"

/// ARRIVALS
/area/taeloth/nearstation/arrivals
	name = "Arrivals Crossway"
	icon_state = "entry"

/// CARGO
/area/taeloth/nearstation/cargo_crossway
	name = "Cargo Crossway"
	icon_state = "cargo_lobby"

/area/taeloth/nearstation/cargo_crossway/pavement
	name = "Cargo Department - Exterior"
	icon_state = "cargo_lobby"

/// COMMAND
/area/taeloth/nearstation/bridge_crossway
	name = "Bridge Crossway"
	icon_state = "bridge_hallway"

/area/taeloth/nearstation/gateway
	name = "Gateway Crossway"
	icon_state = "gateway"

/area/taeloth/nearstation/hop_line
	name = "Head of Personnel's Line"
	icon_state = "hop_office"

/// DORMS

/area/taeloth/nearstation/dormitory_concourse
	name = "Dormitory Concourse"
	icon_state = "dorms"

/area/taeloth/nearstation/dormitory_concourse/interlink_dock_beach
	name = "Interlink Dock - Beach"

/area/taeloth/nearstation/dormitory_concourse/sinners_trail
	name = "Dormitory Concourse - Sinner's Trail"

/area/taeloth/nearstation/dormitory_concourse/crew_facilities
	name = "Dormitory Concourse - Crew Facilities"
	icon_state = "commons"

/// ENGINEERING
/area/taeloth/nearstation/engsci_crossway
	name = "Engineer-Science Crossway"
	icon_state = "engie"

/// MEDICAL
/area/taeloth/nearstation/medsci_crossway
	name = "Medical-Science Crossway"
	icon_state = "science_lobby"

/area/taeloth/nearstation/virology_pen
	name = "Virology - Monkey Pen"
	icon_state = "virology"

/// PUBLIC
/area/taeloth/nearstation/departures_deck
	name = "Departures Deck"
	icon_state = "escape_lounge"

/area/taeloth/nearstation/restroom_crossway
	name = "Restroom Crossway"
	icon_state = "restrooms"

/// SECURITY
/area/taeloth/nearstation/medsec_crossway
	name = "Medical-Security Crossway"
	icon_state = "checkpoint_arr"

/// SERVICE
/area/taeloth/nearstation/service_crossway
	name = "Service Crossway - North"
	icon_state = "hall_service"

/area/taeloth/nearstation/service_crossway/south
	name = "Service Crossway - South"

/area/taeloth/nearstation/service_crossway/bar
	name = "Bar Crossway - North"
	icon_state = "bar"

/area/taeloth/nearstation/service_crossway/public_garden
	name = "Exterior - Public Garden"


/*
	Blob-Banned; Cult-Banned
*/

/area/taeloth/nearstation/no_valids_to_hunt
	area_flags = /area/taeloth::area_flags

/// AI
/area/taeloth/nearstation/no_valids_to_hunt/ai_sat_lake
	name = "AI Satellite - Lake"
	icon_state = "ai"

/// ARRIVALS
/area/taeloth/nearstation/no_valids_to_hunt/arrivals_landing_zone
	name = "Arrivals - Landing Zone"
	icon_state = "entry"

/area/taeloth/nearstation/no_valids_to_hunt/arrivals_landing_zone/public_mining
	name = "Public Mining Landing Zone"

/// CARGO
/area/taeloth/nearstation/no_valids_to_hunt/cargo_landing_zone
	name = "Cargo Shuttle Landing Zone"
	icon_state = "cargo_bay"

/area/taeloth/nearstation/no_valids_to_hunt/cargo_landing_zone/mining
	name = "Mining Shuttle Landing Zone"
	icon_state = "mining_dock"

/// COMMAND
/area/taeloth/nearstation/no_valids_to_hunt/bridge_lake
	name = "Central Lake"
	icon_state = "centralhall"

/// PUBLIC
/area/taeloth/nearstation/no_valids_to_hunt/departures_landing_zone
	name = "Departures Landing Zone"
	icon_state = "escape"

/*
	GENERATED CHUNKS
*/

/area/taeloth/unexplored // In theory, monsters spawn here. They do not in practice, unimplemented. Random Generation + Ruins work though.
	icon_state = "unexplored"
	area_flags = VALID_TERRITORY | UNIQUE_AREA | CAVES_ALLOWED | FLORA_ALLOWED | MOB_SPAWN_ALLOWED
	map_generator = /datum/map_generator/jungle_generator

/area/taeloth/unexplored/danger // Additional to said theory: megafauna.
	icon_state = "danger"
	area_flags = VALID_TERRITORY | UNIQUE_AREA | CAVES_ALLOWED | FLORA_ALLOWED | MOB_SPAWN_ALLOWED | MEGAFAUNA_SPAWN_ALLOWED

/*
	UNGERGROUND
*/

/area/taeloth/underground
	name = "Taeloth Caves"

/area/taeloth/underground/try_lighting()
	return

/area/taeloth/underground/unexplored
	icon_state = "unexplored"
	area_flags = VALID_TERRITORY | UNIQUE_AREA | CAVES_ALLOWED | FLORA_ALLOWED | MOB_SPAWN_ALLOWED
	map_generator = /datum/map_generator/cave_generator/rimpoint_jungle // really need to replace that floor with a proper stone one at some point.. soon(tm)
