// Taur bodytype bitflags
#define STYLE_TAUR_SNAKE (1<<2) //taur-friendly suits
#define STYLE_TAUR_PAW (1<<3)
#define STYLE_TAUR_HOOF (1<<4)
#define STYLE_TAUR_ALL (STYLE_TAUR_SNAKE|STYLE_TAUR_PAW|STYLE_TAUR_HOOF)

// We don't use the HUD for these, they have their own menu.
#define LEWD_SLOT_VAGINA (1<<0)
#define LEWD_SLOT_PENIS (1<<1)
#define LEWD_SLOT_ANUS (1<<2)
#define LEWD_SLOT_NIPPLES (1<<3)

/// Manually set this on items you want anthro ears to show on!
#define SHOWSPRITEEARS (1<<14)
/// Does this sprite hide the tail?
#define HIDETAIL (1<<15)
/// Does this sprite also hide the spine on tails? Realistically only useful for the clothes that have a special tail overlay, like MODsuits
#define HIDESPINE (1<<16)
/// Does this sprite hide devious devices?
#define HIDESEXTOY (1<<17)

/// The sprite works fine for snouts.
#define CLOTHING_SNOUTED_VARIATION (1<<4)
/// The sprite works fine for snouts as-is.
#define CLOTHING_SNOUTED_VARIATION_NO_NEW_ICON (1<<5)
/// The sprite works fine for vox snouts.
#define CLOTHING_SNOUTED_VOX_VARIATION (1<<6)
/// The sprite works fine for vox snouts as is.
#define CLOTHING_SNOUTED_VOX_VARIATION_NO_NEW_ICON (1<<7)
/// The sprite works fine for vox snouts.
#define CLOTHING_SNOUTED_BETTER_VOX_VARIATION (1<<8)
/// The sprite works fine for vox snouts as is.
#define CLOTHING_SNOUTED_BETTER_VOX_VARIATION_NO_NEW_ICON (1<<9)
