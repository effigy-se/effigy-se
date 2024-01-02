#define TRAIT_ALREADYSTAMINAFLOORED    	"alreadystaminafloored" //Trait to keep track whether someone was floored recently by stamina damage.
#define STAMINA_KNOCKDOWN_COOLDOWN 10 SECONDS

#define HUMAN_LIFE_MULTIPLIER 1.15
#define MAX_HUMAN_HEALTH (MAX_LIVING_HEALTH * HUMAN_LIFE_MULTIPLIER)
#define MAX_HUMAN_STAMINA (120 * HUMAN_LIFE_MULTIPLIER)

//APPLICATION OF STAM DAMAGE
//Should maybe wounds do it too?
//This one is applied on non-glancing melee attacks aswell as normal projectiles.
#define SIMPLE_MOB_TISSUE_DAMAGE_STAMINA_MULTIPLIER 1.7 //Fights with simple mobs are usually more sustained, so apply a bit less
#define BLUNT_TISSUE_DAMAGE_STAMINA_MULTIPLIER 1.8 //Brute that isnt sharp, knocks the wind outta you real good
#define OTHER_TISSUE_DAMAGE_STAMINA_MULTIPLIER 1.5 //Burns, sharp implements
#define PROJECTILE_TISSUE_DAMAGE_STAMINA_MULTIPLIER 1

//Glancing attacks happen when someone uses disarm intent with melee weaponry, aiming to disable a person instead
#define TISSUE_DAMAGE_GLANCING_DAMAGE_MULTIPLIER 0.5
#define BLUNT_TISSUE_DAMAGE_GLANCING_STAMINA_MULTIPLIER 4.2 //This is also multiplied by the glancing damage multiplier, so usually less
#define OTHER_TISSUE_DAMAGE_GLANCING_STAMINA_MULTIPLIER 3.6

#define PUNCH_STAMINA_MULTIPLIER 2.6

//STAMINA REGEN
#define STAMINA_STATIC_REGEN_MULTIPLIER 0.4
//Flat amount regenerated per 2 seconds, multiplied by a lot of variables
#define STAMINA_STATIC_REGEN_FLAT 1.8
//Extra flat of regeneration while we're in crit
#define STAMINA_EXTRA_FLAT_IN_CRIT 0.5
//This increases the multiplier in relation to current stamina (staminaloss/THIS)
#define STAMINALOSS_REGEN_COEFF 50

//Thresholds for detrimental effects from stamina
#define STAMINA_THRESHOLD_WEAK 60

#define STAMINA_THRESHOLD_KNOCKDOWN 120

#define STAMINA_THRESHOLD_SOFTCRIT 150

#define STAMINA_THRESHOLD_HARDCRIT 150

//Stamina threshold from which resisting a grab becomes hard
#define STAMINA_THRESHOLD_HARD_RESIST 80

//A coefficient for doing the change of random CC's on a person (staminaloss/THIS)
#define STAMINA_CROWD_CONTROL_COEFF 200

//Resting thresholds
#define STAMINA_THRESHOLD_MEDIUM_GET_UP 50
#define STAMINA_THRESHOLD_SLOW_GET_UP 100

//Standing times in seconds
#define GET_UP_FAST 0.6
#define GET_UP_MEDIUM 1.5
#define GET_UP_SLOW 3

//Stamina threshold for attacking slower with items
#define STAMINA_THRESHOLD_TIRED_CLICK_CD 120
#define CLICK_CD_MELEE_TIRED 11 //#define CLICK_CD_MELEE 8, so 38% slower
#define CLICK_CD_RANGE_TIRED 5 //#define CLICK_CD_RANGE 4, so 25% slower

#define STAMINA_THRESHOLD_MESSAGE_ACHE 40
#define STAMINA_THRESHOLD_MESSAGE_MILD 60
#define STAMINA_THRESHOLD_MESSAGE_MEDIUM 80
#define STAMINA_THRESHOLD_MESSAGE_HIGH 100
#define STAMINA_THRESHOLD_MESSAGE_SEVERE 120
#define STAMINA_THRESHOLD_MESSAGE_OHGOD 190

#define STAMINA_MESSAGE_COOLDOWN 20 SECONDS

#define FILTER_STAMINACRIT filter(type="drop_shadow", x=0, y=0, size=-3, color="#04080F")

#define HEADSMASH_BLOCK_ARMOR 20
#define SUPLEX_TIMER 3 SECONDS

#define PERSONAL_SPACE_DAMAGE 2
#define ASS_SLAP_EXTRA_RANGE -1
