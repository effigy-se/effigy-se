/datum/design/health_hud_prescription
	name = "Prescription Health Scanner HUD"
	desc = "A heads-up display that scans the humans in view and provides accurate data about their health status. This one has a prescription lens."
	id = "health_hud_prescription"
	build_type = PROTOLATHE | AWAY_LATHE
	materials = list(/datum/material/iron = 500, /datum/material/glass = 500, /datum/material/silver = 350)
	build_path = /obj/item/clothing/glasses/hud/health/prescription
	category = list(
		RND_CATEGORY_EQUIPMENT + RND_SUBCATEGORY_EQUIPMENT_MEDICAL
	)
	departmental_flags = DEPARTMENT_BITFLAG_MEDICAL

/datum/design/security_hud_prescription
	name = "Prescription Security HUD"
	desc = "A heads-up display that scans the humans in view and provides accurate data about their ID status. This one has a prescription lens."
	id = "security_hud_prescription"
	build_type = PROTOLATHE | AWAY_LATHE
	materials = list(/datum/material/iron = 500, /datum/material/glass = 500, /datum/material/silver = 350)
	build_path = /obj/item/clothing/glasses/hud/security/prescription
	category = list(
		RND_CATEGORY_EQUIPMENT + RND_SUBCATEGORY_EQUIPMENT_SECURITY
	)
	departmental_flags = DEPARTMENT_BITFLAG_SECURITY

/datum/design/diagnostic_hud_prescription
	name = "Prescription Diagnostic HUD"
	desc = "A HUD used to analyze and determine faults within robotic machinery. This one has a prescription lens."
	id = "diagnostic_hud_prescription"
	build_type = PROTOLATHE | AWAY_LATHE
	materials = list(/datum/material/iron = 500, /datum/material/glass = 500, /datum/material/gold = 350)
	build_path = /obj/item/clothing/glasses/hud/diagnostic/prescription
	category = list(
		RND_CATEGORY_EQUIPMENT + RND_SUBCATEGORY_EQUIPMENT_SCIENCE
	)
	departmental_flags = DEPARTMENT_BITFLAG_SCIENCE

/datum/design/science_hud_prescription
	name = "Prescription Science HUD"
	desc = "These glasses scan the contents of containers and projects their contents to the user in an easy to read format. This one has a prescription lens."
	id = "science_hud_prescription"
	build_type = PROTOLATHE | AWAY_LATHE
	materials = list(/datum/material/iron = 500, /datum/material/glass = 500, /datum/material/gold = 350)
	build_path = /obj/item/clothing/glasses/hud/science/prescription
	category = list(
		RND_CATEGORY_EQUIPMENT + RND_SUBCATEGORY_EQUIPMENT_SCIENCE
	)
	departmental_flags = DEPARTMENT_BITFLAG_SCIENCE | DEPARTMENT_BITFLAG_MEDICAL

/datum/design/mesons_prescription
	name = "Prescription Optical Meson Scanners"
	desc = "Used by engineering and mining staff to see basic structural and terrain layouts through walls, regardless of lighting condition. Prescription lens has been added into this design."
	id = "mesons_prescription"
	build_type = PROTOLATHE | AWAY_LATHE
	materials = list(/datum/material/iron = 500, /datum/material/glass = 500, /datum/material/silver = 350)
	build_path = /obj/item/clothing/glasses/meson/prescription
	category = list(
		RND_CATEGORY_EQUIPMENT + RND_SUBCATEGORY_EQUIPMENT_ENGINEERING
	)
	departmental_flags = DEPARTMENT_BITFLAG_CARGO | DEPARTMENT_BITFLAG_ENGINEERING

/datum/design/engine_goggles_prescription
	name = "Prescription Engineering Scanner Goggles"
	desc = "Goggles used by engineers. The Meson Scanner mode lets you see basic structural and terrain layouts through walls, regardless of lighting condition. The T-ray Scanner mode lets you see underfloor objects such as cables and pipes. Prescription lens has been added into this design."
	id = "engine_goggles_prescription"
	build_type = PROTOLATHE | AWAY_LATHE
	materials = list(/datum/material/iron = 500, /datum/material/glass = 500, /datum/material/plasma = 100, /datum/material/silver = 350)
	build_path = /obj/item/clothing/glasses/meson/engine/prescription
	category = list(
		RND_CATEGORY_EQUIPMENT + RND_SUBCATEGORY_EQUIPMENT_ENGINEERING
	)
	departmental_flags = DEPARTMENT_BITFLAG_ENGINEERING

/datum/design/tray_goggles_prescription
	name = "Prescription Optical T-Ray Scanners"
	desc = "Used by engineering staff to see underfloor objects such as cables and pipes.  Prescription lens has been added into this design."
	id = "tray_goggles_prescription"
	build_type = PROTOLATHE | AWAY_LATHE
	materials = list(/datum/material/iron = 500, /datum/material/glass = 500, /datum/material/silver = 150)
	build_path = /obj/item/clothing/glasses/meson/engine/tray/prescription
	category = list(
		RND_CATEGORY_EQUIPMENT + RND_SUBCATEGORY_EQUIPMENT_ENGINEERING
	)
	departmental_flags = DEPARTMENT_BITFLAG_ENGINEERING

/datum/design/vox_gas_filter
	name = "Vox Gas Filter"
	id = "vox_gas_filter"
	build_type = PROTOLATHE | AUTOLATHE
	materials = list(/datum/material/iron = 100)
	build_path = /obj/item/gas_filter/vox
	category = list(
		RND_CATEGORY_EQUIPMENT + RND_SUBCATEGORY_EQUIPMENT_GAS_TANKS
	)
	departmental_flags = ALL

/datum/design/pen
	name = "Pen"
	id = "pen"
	build_type = AUTOLATHE
	materials = list(/datum/material/iron = 32, /datum/material/glass = 8)
	build_path = /obj/item/pen
	category = list(RND_CATEGORY_INITIAL, RND_CATEGORY_EQUIPMENT + RND_SUBCATEGORY_EQUIPMENT_MISC)

/datum/design/borg_snack_dispenser
	name = "Snack Dispenser Module"
	id = "borg_upgrade_snacks"
	build_type = MECHFAB
	build_path = /obj/item/borg/upgrade/snack_dispenser
	materials = list(/datum/material/iron = 700, /datum/material/glass = 500)
	construction_time = 1 SECONDS
	category = list(RND_CATEGORY_MECHFAB_CYBORG_MODULES + RND_SUBCATEGORY_MECHFAB_CYBORG_MODULES_ALL)
