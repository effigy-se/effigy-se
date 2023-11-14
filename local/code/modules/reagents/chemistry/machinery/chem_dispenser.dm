/obj/machinery/chem_dispenser
	/// These become available once the manipulator has been upgraded to tier 2 (femto)
	var/list/upgrade_reagents_t2 = list()
	/// These become available once the manipulator has been upgraded to tier 3 (femto)
	var/list/upgrade_reagents_t3 = list()
	/// These become available once the manipulator has been upgraded to tier 4 (femto)
	var/list/upgrade_reagents_t4 = list()
	/// The default list of reagents upgrade_reagents Tier 2
	var/static/list/default_upgrade_reagents_t2 = list(
		/datum/reagent/fuel/oil,
		/datum/reagent/ammonia,
		/datum/reagent/ash,
		/datum/reagent/phenol
	)
	/// The default list of reagents upgrade_reagents Tier 3
	var/static/list/default_upgrade_reagents_t3 = list(
		/datum/reagent/acetone,
		/datum/reagent/diethylamine,
		/datum/reagent/saltpetre
	)
	/// The default list of reagents upgrade_reagents Tier 4
	var/static/list/default_upgrade_reagents_t4 = list(
		/datum/reagent/medicine/mine_salve,
		/datum/reagent/medicine/rezadone,
		/datum/reagent/toxin
	)
	/// The default list of reagents emagged_reagents
	var/static/list/default_emagged_reagents = list(
		/datum/reagent/drug/space_drugs,
		/datum/reagent/toxin/plasma,
		/datum/reagent/consumable/frostoil,
		/datum/reagent/toxin/carpotoxin,
		/datum/reagent/toxin/histamine,
		/datum/reagent/medicine/morphine
	)
	/// Custom transfer amount list
	var/list/transfer_amounts = list()
	/// Custom transfer amount
	var/custom_transfer_amount

/obj/machinery/chem_dispenser/drinks
	upgrade_reagents_t3 = null
	upgrade_reagents_t4 = null
	/// The default list of reagents upgrade_reagents Tier 2
	var/static/list/drinks_upgrade_reagents = list(
		/datum/reagent/consumable/applejuice,
		/datum/reagent/consumable/pumpkinjuice,
		/datum/reagent/consumable/vanilla,
		/datum/reagent/consumable/banana,
		/datum/reagent/consumable/berryjuice,
		/datum/reagent/consumable/blumpkinjuice,
		/datum/reagent/consumable/watermelonjuice,
		/datum/reagent/consumable/peachjuice,
		/datum/reagent/consumable/sol_dry,
		/datum/reagent/consumable/ethanol/thirteenloko,
		/datum/reagent/consumable/ethanol/whiskey_cola,
		/datum/reagent/toxin/mindbreaker,
		/datum/reagent/toxin/staminatoxin
	)

/obj/machinery/chem_dispenser/drinks/Initialize(mapload)
	if(upgrade_reagents_t2 != null && !upgrade_reagents_t2.len)
		upgrade_reagents_t2 = drinks_upgrade_reagents
	if(upgrade_reagents_t2)
		upgrade_reagents_t2 = sort_list(upgrade_reagents_t2, GLOBAL_PROC_REF(cmp_reagents_asc))
	. = ..()

/obj/machinery/chem_dispenser/drinks/beer
	upgrade_reagents_t2 = null

/obj/machinery/chem_dispenser/mutagen
	upgrade_reagents_t2 = null
	upgrade_reagents_t3 = null
	upgrade_reagents_t4 = null

/obj/machinery/chem_dispenser/mutagensaltpeter
	upgrade_reagents_t2 = null
	upgrade_reagents_t3 = null
	upgrade_reagents_t4 = null
