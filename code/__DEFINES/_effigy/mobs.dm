///The limb fits a modular custom shape
#define BODYTYPE_CUSTOM (1<<9)
///The limb fits a taur body
#define BODYTYPE_TAUR (1<<10)
///The limb causes shoes to no longer be displayed, useful for taurs.
#define BODYTYPE_HIDE_SHOES (1<<11)
///The limb causes glasses and hats to be drawn on layers 5 and 4 respectively. Currently used for snouts with the (Top) suffix, which are drawn on layer 6 and would normally cover facewear
#define BODYTYPE_ALT_FACEWEAR_LAYER (1<<12)

/// Used for Nanite Slurry vomit. The mob will vomit a nanite puddle.
#define VOMIT_NANITE 3

#define UNDERWEAR_HIDE_SOCKS (1<<0)
#define UNDERWEAR_HIDE_SHIRT (1<<1)
#define UNDERWEAR_HIDE_UNDIES (1<<2)

//Appends to the bottom of Defib fails - DNR TRAIT
#define DEFIB_FAIL_DNR (1<<11)

///Defines for icons used for modular bodyparts, created to make it easier to relocate the module or files if necessary.
#define BODYPART_ICON_HUMAN 'local/icons/mob/species/human_parts_greyscale.dmi'
#define BODYPART_ICON_MAMMAL 'local/icons/mob/species/mammal_parts_greyscale.dmi'
#define BODYPART_ICON_AKULA 'local/icons/mob/species/akula_parts_greyscale.dmi'
#define BODYPART_ICON_GHOUL 'local/icons/mob/species/ghoul_bodyparts.dmi'
#define BODYPART_ICON_INSECT 'local/icons/mob/species/insect_parts_greyscale.dmi'
#define BODYPART_ICON_LIZARD 'local/icons/mob/species/lizard_parts_greyscale.dmi'
#define BODYPART_ICON_MOTH 'local/icons/mob/species/moth_parts_greyscale.dmi'
#define BODYPART_ICON_ROUNDSTARTSLIME 'local/icons/mob/species/slime_parts_greyscale.dmi'
#define BODYPART_ICON_SKRELL 'local/icons/mob/species/skrell_parts_greyscale.dmi'
#define BODYPART_ICON_TAUR 'local/icons/mob/species/taur_invisible_legs.dmi'
#define BODYPART_ICON_TESHARI 'local/icons/mob/species/teshari_parts_greyscale.dmi'
#define BODYPART_ICON_VOX 'local/icons/mob/species/vox_parts_greyscale.dmi'
#define BODYPART_ICON_XENO 'local/icons/mob/species/xeno_parts_greyscale.dmi'
#define BODYPART_ICON_SYNTHMAMMAL 'local/icons/mob/species/synthmammal_parts_greyscale.dmi'
#define BODYPART_ICON_IPC 'local/icons/mob/species/ipc_parts.dmi'
#define BODYPART_ICON_SYNTHLIZARD 'local/icons/mob/species/synthliz_parts_greyscale.dmi'
