/datum/design/rsd_interface
	name = "RSD Phylactery"
	desc = "A brain interface that allows for transfer of Resonance from a handheld RSD, such as the Evoker model."
	id = "rsd_interface"
	build_type = PROTOLATHE | AWAY_LATHE
	departmental_flags = DEPARTMENT_BITFLAG_MEDICAL | DEPARTMENT_BITFLAG_SCIENCE
	category = list(RND_CATEGORY_EQUIPMENT)
	materials = list(
		/datum/material/iron = SHEET_MATERIAL_AMOUNT * 0.5,
		/datum/material/gold = SHEET_MATERIAL_AMOUNT,
		/datum/material/silver = SHEET_MATERIAL_AMOUNT,
	)
	build_path = /obj/item/rsd_interface

/datum/design/surgery/healing/robotic_healing_upgrade
	name = "Repair robotic limbs upgrade: Advanced"
	surgery = /datum/surgery/robot_healing/upgraded
	id = "robotic_heal_surgery_upgrade"

/datum/design/surgery/healing/robotic_healing_upgrade_2
	name = "Repair robotic limbs upgrade: Experimental"
	surgery = /datum/surgery/robot_healing/experimental
	id = "robotic_heal_surgery_upgrade_2"
