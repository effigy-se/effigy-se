//Deterministic bonus for bodypart wounding:
#define DAMAGED_BODYPART_BONUS_WOUNDING_BONUS 30 //After this threshold we dont get any wounding bonuses form damaged bodyparts
#define DAMAGED_BODYPART_BONUS_WOUNDING_THRESHOLD 0.5 //How much extra % of wounding dmg we'll have if a bodypart is damaged enough
#define DAMAGED_BODYPART_BONUS_WOUNDING_COEFF 15 //This is multiplied by the sustained damage %. Keep in mind the % limit //Currently: 15/0.5=7.5

#define GAUZE_STAIN_BLOOD 1
#define GAUZE_STAIN_PUS 2

#define COMSIG_BODYPART_SPLINTED "bodypart_splinted" // from /obj/item/bodypart/proc/apply_gauze(/obj/item/stack/gauze)
#define COMSIG_BODYPART_SPLINT_DESTROYED "bodypart_desplinted" // from [/obj/item/bodypart/proc/seep_gauze] when it runs out of absorption

/// If a synth is revived via defib, they will have a brain trauma for this amount of time.
#define SYNTH_DEFIBBED_TRAUMA_DURATION 90 SECONDS
/// If a synth is revived via defib, they will get a brain trauma of this severity.
#define SYNTH_DEFIBBED_TRAUMA_SEVERITY BRAIN_TRAUMA_SEVERE
