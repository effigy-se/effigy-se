/// INTERLINK BLASTER ///
/datum/map_template/shuttle/interlink_blaster
	port_id = "interlink"
	name = "Interlink Blaster"
	suffix = "blaster"
	description = "Standard issue Interlink ferry."

/// FOXHOLE ///

/datum/map_template/shuttle/arrival/foxhole
	suffix = "foxhole"
	name = "arrival shuttle (FoxHole)"

/datum/map_template/shuttle/cargo/foxhole
	suffix = "foxhole"
	name = "cargo ferry (FoxHole)"

/datum/map_template/shuttle/emergency/foxhole
	suffix = "foxhole"
	name = "(Fox)Hole Station Emergency Shuttle" // It's just the Holestation shuttle verbatim, lmao
	credit_cost = CARGO_CRATE_VALUE * 3
	description = "A middlingly small evacuation vessel, with \"private\" cabins for the research and engineering staff. Warranty void if used with more than 25 occupants."
	admin_notes = "While the hull is as big as Boxstation's shuttle, the floorplan is SMALL. S-M-A-L-L. Meant for under 25 people. You have been warned."
	occupancy_limit = "25"

/datum/map_template/shuttle/whiteship/foxhole
	suffix = "foxhole"
	name = "Tungsten-Class Cruise Vessel" // This is the safest of any whiteship so far. No hostile mobs, but on the coinflip, no power and only a PACMAN to work with to change that.
	description = "Life is a party - and we aren't in the dark ages of Orion anymore. Why stop having a good time just because you have \"captaincy\" and a \"crew\"? Our automated systems take \
	the hard choices from your journey, no matter where it takes you - so you can focus on what really matters. Complimentary NIF Subscription with your purchase!"

/// RIMPOINT ///

/datum/map_template/shuttle/arrival/rimpoint
	suffix = "rimpoint"
	name = "arrival shuttle (RimPoint)"

/datum/map_template/shuttle/emergency/rimpoint
	suffix = "rimpoint"
	name = "RimPoint Emergency Shuttle"
	credit_cost = CARGO_CRATE_VALUE * 10
	description = "A middling-sized evacuation shuttle, with an individualized floorplan for each department."
	admin_notes = "Center room is as wide as Cere's shuttle and very, VERY comically easy for lasers to dominate in. Otherwise a standard fare shuttle as far as equipment's concerned."
	occupancy_limit = "50"

/// SIGMA OCTANTIS ///

/datum/map_template/shuttle/arrival/sigma_octantis
	suffix = "sigmaoctantis"
	name = "arrival shuttle (Sigma Octantis)"

/datum/map_template/shuttle/emergency/sigma_octantis
	suffix = "sigmaoctantis"
	name = "Sigma Octantis Emergency Shuttle"
	credit_cost = CARGO_CRATE_VALUE * 4
	description = "A cramped emergency shuttle; specialized for handling flooded stations with an onboard drainage system."
	admin_notes = "Centre is dedicated to dealing with a flood - it will be pretty useless in other scenarios."
	occupancy_limit = "30"
