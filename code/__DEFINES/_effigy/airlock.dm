#define AIRLOCK_LIGHT_POWER 1
#define AIRLOCK_LIGHT_RANGE 1.7

// Airlock light states, used for generating the light overlays
#define AIRLOCK_LIGHT_BOLTS "bolts"
#define AIRLOCK_LIGHT_EMERGENCY "emergency"
#define AIRLOCK_LIGHT_DENIED "denied"
#define AIRLOCK_LIGHT_CLOSING "closing"
#define AIRLOCK_LIGHT_OPENING "opening"
#define AIRLOCK_LIGHT_POWERON "poweron"
#define AIRLOCK_LIGHT_ENGINEERING "engineering"
#define AIRLOCK_LIGHT_FIRE "fire"

// Airlock physical states
#define AIRLOCK_CLOSED 1
#define AIRLOCK_CLOSING 2
#define AIRLOCK_OPEN 3
#define AIRLOCK_OPENING 4
#define AIRLOCK_DENY 5
#define AIRLOCK_EMAG 6

#define AIRLOCK_FRAME_CLOSED "closed"
#define AIRLOCK_FRAME_CLOSING "closing"
#define AIRLOCK_FRAME_OPEN "open"
#define AIRLOCK_FRAME_OPENING "opening"

#define AIRLOCK_SECURITY_NONE 0 //Normal airlock //Wires are not secured
#define AIRLOCK_SECURITY_IRON 1 //Medium security airlock //There is a simple iron plate over wires (use welder)
#define AIRLOCK_SECURITY_PLASTEEL_I_S 2 //Sliced inner plating (use crowbar), jumps to 0
#define AIRLOCK_SECURITY_PLASTEEL_I 3 //Removed outer plating, second layer here (use welder)
#define AIRLOCK_SECURITY_PLASTEEL_O_S 4 //Sliced outer plating (use crowbar)
#define AIRLOCK_SECURITY_PLASTEEL_O 5 //There is first layer of plasteel (use welder)
#define AIRLOCK_SECURITY_PLASTEEL 6 //Max security airlock //Fully secured wires (use wirecutters to remove grille, that is electrified)

#define AIRLOCK_INTEGRITY_N  300 // Normal airlock integrity
#define AIRLOCK_INTEGRITY_MULTIPLIER 1.5 // How much reinforced doors health increases
/// How much extra health airlocks get when braced with a seal
#define AIRLOCK_SEAL_MULTIPLIER  2
#define AIRLOCK_DAMAGE_DEFLECTION_N  21  // Normal airlock damage deflection
#define AIRLOCK_DAMAGE_DEFLECTION_R  30  // Reinforced airlock damage deflection

#define AIRLOCK_DENY_ANIMATION_TIME (0.8 SECONDS) /// The amount of time for the airlock deny animation to show // EffigyEdit Change

#define DOOR_CLOSE_WAIT 60 /// Time before a door closes, if not overridden

#define DOOR_VISION_DISTANCE 11 ///The maximum distance a door will see out to
