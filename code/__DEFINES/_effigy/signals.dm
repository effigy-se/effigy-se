//Movable signals
///When someone talks into a radio
#define COMSIG_MOVABLE_RADIO_TALK_INTO "movable_radio_talk_into" //from radio talk_into(): (obj/item/radio/radio, message, channel, list/spans, datum/language/language, direct)
/// When a hostile simple mob loses it's target.
#define COMSIG_HOSTILE_MOB_LOST_TARGET "hostile_mob_lost_target"

// Power signals
/// Sent when an obj/item calls item_use_power: (use_amount, user, check_only)
#define COMSIG_ITEM_POWER_USE "item_use_power"
	#define NO_COMPONENT NONE
	#define COMPONENT_POWER_SUCCESS (1<<0)
	#define COMPONENT_NO_CELL  (1<<1)
	#define COMPONENT_NO_CHARGE (1<<2)

// Health signals
/// /mob/living/proc/updatehealth()
#define COMSIG_MOB_RUN_ARMOR "mob_run_armor"
/// /mob/living/proc/adjustBruteLoss (amount)
#define COMSIG_MOB_LOSS_BRUTE "mob_loss_brute"
/// /mob/living/proc/adjustBurnLoss (amount)
#define COMSIG_MOB_LOSS_FIRE "mob_loss_fire"
/// /mob/living/proc/adjustCloneLoss (amount)
#define COMSIG_MOB_LOSS_CLONE "mob_loss_clone"
/// /mob/living/proc/adjustToxLoss (amount)
#define COMSIG_MOB_LOSS_TOX "mob_loss_tox"
////mob/living/proc/adjustOyxLoss (amount)
#define COMSIG_MOB_LOSS_OXY "mob_loss_oxy"
////mob/living/proc/adjustStaminaLoss (amount)
#define COMSIG_MOB_LOSS_STAMINA "mob_loss_stamina"
/// /mob/living/proc/adjustOrganLoss (slot, amount)
#define COMSIG_MOB_LOSS_ORGAN "mob_loss_organ"
///from base of /turf/handle_fall(): (mob/faller)
#define COMSIG_TURF_MOB_FALL "turf_mob_fall"
///from base of /obj/effect/abstract/liquid_turf/Initialize() (/obj/effect/abstract/liquid_turf/liquids)
#define COMSIG_TURF_LIQUIDS_CREATION "turf_liquids_creation"
/// Engineering Override Access manual toggle
#define COMSIG_GLOB_FORCE_ENG_OVERRIDE "force_engineering_override"
/// From mob/living/*/set_combat_mode(): (new_state)
#define COMSIG_LIVING_COMBAT_MODE_TOGGLE "living_combat_mode_toggle"

/// Whenever we need to check if a mob is currently inside of soulcatcher.
#define COMSIG_SOULCATCHER_CHECK_SOUL "soulcatcher_check_soul"

/// Whenever we need to get the soul of the mob inside of the soulcatcher.
#define COMSIG_SOULCATCHER_SCAN_BODY "soulcatcher_scan_body"
