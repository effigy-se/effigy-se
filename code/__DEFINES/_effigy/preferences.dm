#define PREVIEW_PREF_JOB "Job"
#define PREVIEW_PREF_LOADOUT "Loadout"
#define PREVIEW_PREF_UNDERWEAR "Underwear"
#define PREVIEW_PREF_NAKED "Naked"
#define PREVIEW_PREF_NAKED_AROUSED "Naked - Aroused"

/// for tri color prefs: doesn't check type_to_check pref
#define TRICOLOR_NO_CHECK 0
/// checks that the value of type_to_check is not FALSE
#define TRICOLOR_CHECK_BOOLEAN 1
/// checks that the value of type_to_check is associated with a factual sprite accessory (tldr not "None")
#define TRICOLOR_CHECK_ACCESSORY 2

#define ORGAN_PREF_POSI_BRAIN "Positronic Brain"
#define ORGAN_PREF_MMI_BRAIN "Man-Machine Interface"
#define ORGAN_PREF_CIRCUIT_BRAIN "Circuitboard"

#define PLAYTIME_GREEN 1000

// Antag opt-in
#define YES_TEMP 1
#define YES_KILL 2
#define YES_ROUND_REMOVE 3
#define NOT_TARGET 0

#define READ_PREFS(target, pref) (target.client.prefs.read_preference(/datum/preference/pref) || "Unset")
GLOBAL_DATUM(character_directory, /datum/character_directory)
