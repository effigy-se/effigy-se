/datum/reagent
	/// Modular version of `chemical_flags`, so we don't have to worry about
	/// it causing conflicts in the future.
	var/expanded_chemical_flags = NONE
	///What can process this? REAGENT_ORGANIC, REAGENT_SYNTHETIC, or REAGENT_ORGANIC | REAGENT_SYNTHETIC?. We'll assume by default that it affects organics.
	var/process_flags = REAGENT_ORGANIC
