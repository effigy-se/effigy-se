//Module - altborgs
//Defines for dogborgs and stuff
#define ROBOT_REST_NORMAL 1
#define ROBOT_REST_SITTING 2
#define ROBOT_REST_BELLY_UP 3

#define SKIN_FEATURES "skin_features" //for the new system of borg making

//Defines for model features, set in the model_features list of a robot model datum. Are they a dogborg? Is the model small? etc.
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
