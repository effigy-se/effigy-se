#define MOB_LAYER_SHIFT_INCREMENT	0.01
#define MOB_LAYER_SHIFT_MIN 		3.95
//#define MOB_LAYER 				4   // This is a byond standard define
#define MOB_LAYER_SHIFT_MAX   		4.05

/// Fast multi-z rendering (no blur)
#define MULTIZ_PERFORMANCE_FAST
/// Includes blur, but honestly it looks the same as 'disabled' so no idea if this actually does anything
#define MULTIZ_PERFORMANCE_NICE (MAX_EXPECTED_Z_DEPTH - 1)
