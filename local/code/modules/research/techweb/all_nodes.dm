/datum/techweb_node/improved_robotic_tend_wounds
	id = TECHWEB_NODE_ROBOTIC_SURGERY
	display_name = "Improved Robotic Repair Surgeries"
	description = "As it turns out, you don't actually need to cut out entire support rods if it's just scratched!"
	prereq_ids = list(TECHWEB_NODE_CONSTRUCTION)
	design_ids = list(
		"robotic_heal_surgery_upgrade"
	)
	research_costs = list(TECHWEB_POINT_TYPE_GENERIC = TECHWEB_TIER_1_POINTS)

/datum/techweb_node/advanced_robotic_tend_wounds
	id = TECHWEB_NODE_ROBOTIC_SURGERY_ADVANCED
	display_name = "Advanced Robotic Surgeries"
	description = "Did you know Hephaestus actually has a free online tutorial for synthetic trauma repairs? It's true!"
	prereq_ids = list(TECHWEB_NODE_ROBOTIC_SURGERY)
	design_ids = list(
		"robotic_heal_surgery_upgrade_2"
	)
	research_costs = list(TECHWEB_POINT_TYPE_GENERIC = TECHWEB_TIER_1_POINTS) // less expensive than the organic surgery research equivalent since its JUST tend wounds

/////////////////////////robotics tech/////////////////////////

/datum/techweb_node/robotics/New()
	design_ids += list(
		"borg_upgrade_snacks",
		"mini_soulcatcher",
	)
	return ..()

/datum/techweb_node/passive_implants/New()
	design_ids += list(
		"soulcatcher_device",
		"rsd_interface",
	)
	return ..()

/datum/techweb_node/borg_utility/New()
	design_ids += list(
		"borg_upgrade_clamp",
		"borg_upgrade_brush",
		"borg_upgrade_shrink",
	)
	return ..()

/datum/techweb_node/borg_engi/New()
	design_ids += list(
		"advanced_materials",
		"borg_upgrade_welding",
	)
	return ..()

/datum/techweb_node/borg_medical/New()
	design_ids += list(
		"borg_upgrade_surgicaltools",
	)
	return ..()
