//Current stations

// FoxHoleStation: Added to Effigy as FoxHole May 28th, 2023 (#10) - Prior existed as HoleStation (May 26th, 2022)
/obj/structure/plaque/static_plaque/golden/commission/foxholestation
	desc = "Spinward Sector Station SS-13\n'HoleStation' Class Outpost\nRecommissioned 28/05/2563\n'Making Us Whole'"

/obj/structure/plaque/static_plaque/golden/commission/foxholestation/Initialize(mapload)
	. = ..()
	var/static/list/the_chief_engineer = list(/datum/job/chief_engineer)

	AddElement(/datum/element/unique_examine, \
		desc = "...Aren't they going to update the name?", \
		desc_requirement = EXAMINE_CHECK_JOB, \
		requirements = the_chief_engineer)

// Rimpoint: added September 19th, 2023 (#428)
/obj/structure/plaque/static_plaque/golden/commission/rimpoint
	desc = "Spinward Sector Station SS-13\n'RimPoint' Colonial Site\nCommissioned 19/09/2563\n'Taking Flight'"

// Sigma Octantis: added Feburary 19th, 2024 (#696)
/obj/structure/plaque/static_plaque/golden/commission/sigmaoctantis
	desc = "Spinward Sector Station SS-13\n'Sigma Octantis' Submersive Research Craft\nCommissioned 19/02/2564\n'A Merry Friday Every Day'"
