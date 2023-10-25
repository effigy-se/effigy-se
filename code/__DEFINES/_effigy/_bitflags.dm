/// Whether something is repairable by the anvil
#define ANVIL_REPAIR (1<<0)
/// This reagent is useful for blood regeneration. Useful for Hemophages.
#define REAGENT_BLOOD_REGENERATING (1<<0)

DEFINE_BITFIELD(expanded_obj_flags, list(
	"ANVIL_REPAIR" = ANVIL_REPAIR,
))

DEFINE_BITFIELD(expanded_chemical_flags, list(
	"REAGENT_BLOOD_REGENERATING" = REAGENT_BLOOD_REGENERATING,
))
