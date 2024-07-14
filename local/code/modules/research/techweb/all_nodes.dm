/datum/techweb_node/improved_robotic_tend_wounds
	id = "improved_robotic_surgery"
	display_name = "Improved Robotic Repair Surgeries"
	description = "As it turns out, you don't actually need to cut out entire support rods if it's just scratched!"
	prereq_ids = list(TECHWEB_NODE_CONSTRUCTION)
	design_ids = list(
		"robotic_heal_surgery_upgrade"
	)
	research_costs = list(TECHWEB_POINT_TYPE_GENERIC = 900)

/datum/techweb_node/advanced_robotic_tend_wounds
	id = "advanced_robotic_surgery"
	display_name = "Advanced Robotic Surgeries"
	description = "Did you know Hephaestus actually has a free online tutorial for synthetic trauma repairs? It's true!"
	prereq_ids = list("improved_robotic_surgery")
	design_ids = list(
		"robotic_heal_surgery_upgrade_2"
	)
	research_costs = list(TECHWEB_POINT_TYPE_GENERIC = 1300) // less expensive than the organic surgery research equivalent since its JUST tend wounds

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

/datum/techweb_node/augmentation/New()
	design_ids += list(
		"affection_module",
	)
	return ..()

/datum/techweb_node/borg_medical/New()
	design_ids += list(
		"borg_upgrade_surgicaltools",
	)
	return ..()

/datum/techweb_node/hud/New()
	design_ids += list(
		"nifsoft_money_sense",
	)
	return ..()

/datum/techweb_node/augmentation/New()
	design_ids += list(
		"synth_eyes",
		"synth_tongue",
		"synth_liver",
		"synth_lungs",
		"synth_stomach",
		"synth_ears",
		"synth_heart",
	)
	return ..()

/datum/techweb_node/gene_engineering/New()
	design_ids += list(
		"dna_fixer",
	)
	return ..()
