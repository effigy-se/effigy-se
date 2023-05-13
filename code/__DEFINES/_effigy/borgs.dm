//Module - altborgs
//Defines for dogborgs and stuff
#define ROBOT_REST_NORMAL 1
#define ROBOT_REST_SITTING 2
#define ROBOT_REST_BELLY_UP 3

/// Module is compatible with Cargo Cyborg model
#define BORG_MODEL_CARGO (BORG_MODEL_ENGINEERING<<1)

/// For the new system of borg making
#define SKIN_FEATURES "skin_features"

/// Defines for model features, set in the model_features list of a robot model datum. Are they a dogborg? Is the model small? etc.
/// Cyborgs with unique sprites for when they get totally broken down.
#define R_TRAIT_UNIQUEWRECK	"unique_wreck"
/// Or when tipped over.
#define R_TRAIT_UNIQUETIP	"unique_tip"
/// Represents wide/quadruped/dogborg type models.
#define R_TRAIT_WIDE		"wide_borg"
/// 32x64 skins
#define R_TRAIT_TALL		"tall_borg"
/// Any model small enough to reject the shrinker upgrade.
#define R_TRAIT_SMALL		"small_chassis"

/// To store all the different cyborg models, instead of creating that for each cyborg.
GLOBAL_LIST_EMPTY(cyborg_model_list)
/// To store all of the different base cyborg model icons, instead of creating them every time the pick_module() proc is called.
GLOBAL_LIST_EMPTY(cyborg_base_models_icon_list)
/// To store all of the different cyborg model icons, instead of creating them every time the be_transformed_to() proc is called.
GLOBAL_LIST_EMPTY(cyborg_all_models_icon_list)

/// Icon file locations for borg icons
#define CYBORG_ICON_STANDARD 'packages/borgs/assets/robots.dmi'

#define CYBORG_ICON_MED 'packages/borgs/assets/robots_med.dmi'
#define CYBORG_ICON_MED_WIDE 'packages/borgs/assets/widerobot_med.dmi'

#define CYBORG_ICON_CARGO 'modular_skyrat/modules/cargoborg/icons/robots_cargo.dmi'
#define CYBORG_ICON_CARGO_WIDE 'modular_skyrat/modules/cargoborg/icons/widerobots_cargo.dmi'

#define CYBORG_ICON_SEC 'packages/borgs/assets/robots_sec.dmi'
#define CYBORG_ICON_SEC_WIDE 'packages/borgs/assets/widerobot_sec.dmi'

#define CYBORG_ICON_ENG 'packages/borgs/assets/robots_eng.dmi'
#define CYBORG_ICON_ENG_WIDE 'packages/borgs/assets/widerobot_eng.dmi'

#define CYBORG_ICON_PEACEKEEPER 'packages/borgs/assets/robots_pk.dmi'
#define CYBORG_ICON_PEACEKEEPER_WIDE 'packages/borgs/assets/widerobot_pk.dmi'

#define CYBORG_ICON_SERVICE 'packages/borgs/assets/robots_serv.dmi'
#define CYBORG_ICON_SERVICE_WIDE 'packages/borgs/assets/widerobot_serv.dmi'

#define CYBORG_ICON_MINING 'packages/borgs/assets/robots_mine.dmi'
#define CYBORG_ICON_MINING_WIDE 'packages/borgs/assets/widerobot_mine.dmi'

#define CYBORG_ICON_JANI 'packages/borgs/assets/robots_jani.dmi'
#define CYBORG_ICON_JANI_WIDE 'packages/borgs/assets/widerobot_jani.dmi'

#define CYBORG_ICON_SYNDIE 'packages/borgs/assets/robots_syndi.dmi'
#define CYBORG_ICON_SYNDIE_WIDE 'packages/borgs/assets/widerobot_syndi.dmi'

#define CYBORG_ICON_CLOWN 'packages/borgs/assets/robots_clown.dmi'
#define CYBORG_ICON_CLOWN_WIDE 'packages/borgs/assets/widerobot_clown.dmi'

#define CYBORG_ICON_NINJA 'packages/borgs/assets/robots_ninja.dmi'
