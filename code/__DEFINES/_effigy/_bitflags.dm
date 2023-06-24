/// Whether something is repairable by the anvil
#define ANVIL_REPAIR (1<<0)

DEFINE_BITFIELD(expanded_obj_flags, list(
	"ANVIL_REPAIR" = ANVIL_REPAIR,
))
