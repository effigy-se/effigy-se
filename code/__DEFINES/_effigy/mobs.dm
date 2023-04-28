#define BLOOD_VOLUME_OVERSIZED 1120

#define PULL_OVERSIZED_SLOWDOWN 2

/// This layer is used for things that shouldn't be over clothes, but should be over mutations
#define BODY_FRONT_UNDER_CLOTHES 31

///The limb fits a modular custom shape
#define BODYTYPE_CUSTOM (1<<8)
///The limb fits a taur body
#define BODYTYPE_TAUR (1<<9)
///The limb causes shoes to no longer be displayed, useful for taurs.
#define BODYTYPE_HIDE_SHOES (1<<10)
///The limb causes glasses and hats to be drawn on layers 5 and 4 respectively. Currently used for snouts with the (Top) suffix, which are drawn on layer 6 and would normally cover facewear
#define BODYTYPE_ALT_FACEWEAR_LAYER (1<<11)

/// Used for Nanite Slurry vomit. The mob will vomit a nanite puddle.
#define VOMIT_NANITE 3

#define UNDERWEAR_HIDE_SOCKS (1<<0)
#define UNDERWEAR_HIDE_SHIRT (1<<1)
#define UNDERWEAR_HIDE_UNDIES (1<<2)

/// Draws organ on the BODY_FRONT_UNDER_CLOTHES
#define EXTERNAL_FRONT_UNDER_CLOTHES (1 << 4)
/// Draws organ on the ABOVE_BODY_FRONT_HEAD_LAYER
#define EXTERNAL_FRONT_OVER (1 << 5)

//Appends to the bottom of Defib fails - DNR TRAIT
#define DEFIB_FAIL_DNR (1<<11)

///Defines for icons used for modular bodyparts, created to make it easier to relocate the module or files if necessary.
#define BODYPART_ICON_HUMAN 'packages/bodyparts/assets/human_parts_greyscale.dmi'
#define BODYPART_ICON_MAMMAL 'packages/bodyparts/assets/mammal_parts_greyscale.dmi'
#define BODYPART_ICON_AKULA 'packages/bodyparts/assets/akula_parts_greyscale.dmi'
#define BODYPART_ICON_GHOUL 'packages/bodyparts/assets/ghoul_bodyparts.dmi'
#define BODYPART_ICON_INSECT 'packages/bodyparts/assets/insect_parts_greyscale.dmi'
#define BODYPART_ICON_LIZARD 'packages/bodyparts/assets/lizard_parts_greyscale.dmi'
#define BODYPART_ICON_MOTH 'packages/bodyparts/assets/moth_parts_greyscale.dmi'
#define BODYPART_ICON_ROUNDSTARTSLIME 'packages/bodyparts/assets/slime_parts_greyscale.dmi'
#define BODYPART_ICON_SKRELL 'packages/bodyparts/assets/skrell_parts_greyscale.dmi'
#define BODYPART_ICON_TAUR 'packages/bodyparts/assets/taur_invisible_legs.dmi'
#define BODYPART_ICON_TESHARI 'packages/bodyparts/assets/teshari_parts_greyscale.dmi'
#define BODYPART_ICON_VOX 'packages/bodyparts/assets/vox_parts_greyscale.dmi'
#define BODYPART_ICON_XENO 'packages/bodyparts/assets/xeno_parts_greyscale.dmi'
#define BODYPART_ICON_SYNTHMAMMAL 'packages/bodyparts/assets/synthmammal_parts_greyscale.dmi'
#define BODYPART_ICON_IPC 'packages/bodyparts/assets/ipc_parts.dmi'
#define BODYPART_ICON_SYNTHLIZARD 'packages/bodyparts/assets/synthliz_parts_greyscale.dmi'

#define ANUS_LAYER 29
#define VAGINA_LAYER 28
#define PENIS_LAYER 27
#define NIPPLES_LAYER 26
#define BANDAGE_LAYER 25

#define OFFSET_ACCESSORY "accessory"

