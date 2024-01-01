#define LOADOUT_POINTS_MAX 10

#define LOADOUT_CATEGORY_NONE				"ERROR"
//Those three subcategories are good to apply to any category
#define LOADOUT_SUBCATEGORY_DONATOR			"Donator"
#define LOADOUT_SUBCATEGORY_MISC			"Miscellaneous"
#define LOADOUT_SUBCATEGORY_JOB 			"Job-related"

//In backpack
#define LOADOUT_CATEGORY_BACKPACK 				"In backpack"
#define LOADOUT_SUBCATEGORY_BACKPACK_TOYS 		"Toys"
#define LOADOUT_SUBCATEGORY_BACKPACK_FRAGRANCE "Fragrance"
#define LOADOUT_SUBCATEGORY_BACKPACK_PLUSHIES 	"Plushies"

//Neck
#define LOADOUT_CATEGORY_NECK 				"Neck"
#define LOADOUT_SUBCATEGORY_NECK_TIE 		"Ties"
#define LOADOUT_SUBCATEGORY_NECK_SCARVES 	"Scarves"

//Mask
#define LOADOUT_CATEGORY_MASK 				"Mask"

//In hands
#define LOADOUT_CATEGORY_HANDS 				"In hands"

//Uniform
#define LOADOUT_CATEGORY_UNIFORM 			"Uniform"
#define LOADOUT_SUBCATEGORY_UNIFORM_SUITS	"Suits"
#define LOADOUT_SUBCATEGORY_UNIFORM_SKIRTS	"Skirts"
#define LOADOUT_SUBCATEGORY_UNIFORM_DRESSES	"Dresses"
#define LOADOUT_SUBCATEGORY_UNIFORM_SWEATERS	"Sweaters"
#define LOADOUT_SUBCATEGORY_UNIFORM_PANTS	"Pants"
#define LOADOUT_SUBCATEGORY_UNIFORM_SHORTS	"Shorts"

//Suit
#define LOADOUT_CATEGORY_SUIT 				"Suit"
#define LOADOUT_SUBCATEGORY_SUIT_COATS 		"Coats"
#define LOADOUT_SUBCATEGORY_SUIT_JACKETS 	"Jackets"
#define LOADOUT_SUBCATEGORY_SUIT_HOODIES	"Hoodies"

//Head
#define LOADOUT_CATEGORY_HEAD 				"Head"

//Shoes
#define LOADOUT_CATEGORY_SHOES 				"Shoes"

//Gloves
#define LOADOUT_CATEGORY_GLOVES				"Gloves"

//Glasses
#define LOADOUT_CATEGORY_GLASSES			"Glasses"

//Loadout information types, allowing a user to set more customization to them
//Doesn't store any extra information a user could set
#define LOADOUT_INFO_NONE			0
//Stores a "style", which user can set from a pre-defined list on the loadout datum
#define LOADOUT_INFO_STYLE			1
//Stores a single color for use by the loadout datum
#define LOADOUT_INFO_ONE_COLOR 		2

/// Defines for what loadout slot a corresponding item belongs to.
#define LOADOUT_ITEM_BELT "belt"
#define LOADOUT_ITEM_EARS "ears"
#define LOADOUT_ITEM_GLASSES "glasses"
#define LOADOUT_ITEM_GLOVES "gloves"
#define LOADOUT_ITEM_HEAD "head"
#define LOADOUT_ITEM_MASK "mask"
#define LOADOUT_ITEM_NECK "neck"
#define LOADOUT_ITEM_SHOES "shoes"
#define LOADOUT_ITEM_SUIT "suit"
#define LOADOUT_ITEM_UNIFORM "under"
#define LOADOUT_ITEM_ACCESSORY "accessory"
#define LOADOUT_ITEM_INHAND "inhand_items"
#define LOADOUT_ITEM_MISC "pocket_items"
#define LOADOUT_ITEM_TOYS "toys"

#define INFO_GREYSCALE "greyscale"
#define INFO_NAMED "name"
#define INFO_DESCRIBED "description"

/// Max amonut of misc / backpack items that are allowed.
#define MAX_ALLOWED_MISC_ITEMS 3

/// Defines for extra info blurbs, for loadout items.
#define TOOLTIP_NO_ARMOR "ARMORLESS - This item has no armor and is entirely cosmetic."
#define TOOLTIP_NO_DAMAGE "CEREMONIAL - This item has very low force and is cosmetic."
#define TOOLTIP_RANDOM_COLOR "RANDOM COLOR -This item has a random color and will change every round."
#define TOOLTIP_GREYSCALE "GREYSCALED - This item can be customized via the greyscale modification UI."
#define TOOLTIP_RENAMABLE "RENAMABLE - This item can be given a custom name."

#define LOADOUT_OVERRIDE_JOB "Delete job items"
#define LOADOUT_OVERRIDE_BACKPACK "Move job to backpack"
#define LOADOUT_OVERRIDE_CASE "Place all in case"
